// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Map ;
import java.util.Properties ;

import misc.Ticket ;

import html.frame.Outer ;

import data.DataSourceException ;
import data.DataSourceLayout ;
import data.DataSourceConfiguration ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;

final public class OuterFrameServlet extends MyBasicHttpServlet {

  private final static String param_acn = "action" ;					//
  private final static String param_lgn = "login" ;						//
  private final static String param_pwd = "passwd" ;					//
  private final static String value_def = "default" ;					//
  private final static String value_log = "login" ;						//
  private final static String value_off = "logout" ;					//
  private final static String value_flu = "flush" ;						//
  private final static String value_er2 = "invalidpassword" ;	//
  private final static String value_er1 = "invaliduid" ;			//
    
  private String major ;
  private Map m1 ;
  private int i1 ;
  private boolean b1 = true ;
  private Properties p1 ;
  
  protected void reload () throws ServletException {
    try {
      DataSourceConfiguration d = new DataSourceConfiguration (getInitParameter("config")) ;
      p1 = d.properties (major) ;
      i1 = Integer.parseInt (p1.getProperty ("maxInactiveInterval")) ;
      b1 = Boolean.valueOf (p1.getProperty ("tracelogin")).booleanValue() ;
      m1 = java.util.Collections.synchronizedMap (new java.util.HashMap ()) ;
    }
    catch (Exception e) {
      throw new UnavailableException (e.getClass () + " " + e.getMessage ()) ;
    }  
  }

  public void init (ServletConfig cfg) throws ServletException { 
    super.init (cfg) ;
    major = getServletName () ;
    reload () ; 
  } 

  Outer layout (String key) throws DataSourceException {
    if (! m1.containsKey (key)) {
      m1.put (key, new Outer (new DataSourceLayout (getInitParameter("config")).frameDescription (def,key))) ;
    }
    return (Outer) m1.get (key) ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    String action = request.getParameter (param_acn) ;
    String ipaddr = request.getRemoteAddr() ;

    if (action == null) {
      action = value_def ; 
    } 
    else if (0 == action.compareTo (value_off)) {
      HttpSession session = request.getSession (false) ;
      if (session != null) {
        try {
          if (b1) new DataSourceSchedule (getInitParameter("schedule")).logInfo (ipaddr + ": logout: " + ((Ticket) session.getAttribute ("Ticket")).uid ()) ;
        }
        catch (Exception e) {}
        session.invalidate () ;
      }
    }
    else if (0 == action.compareTo (value_flu)) {
    	
      HttpSession session = request.getSession (false) ;
      Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

      if (u == null ? false : u.permissions ().permAdm ()) {
      	refresh () ; 
      }
      else {
        response.sendError (HttpServletResponse.SC_FORBIDDEN) ;
        return ;
      }
    }

    try {
      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      PrintWriter out = response.getWriter () ;
      out.println (layout (action).format (response.encodeURL (layout (action).description ().driverURL () + "?action=" + action))) ;
      out.close () ;
    }
    catch (DataSourceException e) {
      response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ; 
    }
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {

    HttpSession session = request.getSession (false) ;
    String ipaddr = request.getRemoteAddr() ;

    if (session != null) { session.invalidate () ; }

    try {
      DataSourceSchedule d = new DataSourceSchedule (getInitParameter("schedule")) ;
      int uid = Integer.parseInt (request.getParameter (param_lgn)) ;
      
      String action = "" ;
      
      if (uid == 0) {
      	action = value_er1 ;
      }
      else {
           	
        String pwd = request.getParameter (param_pwd) ;
        Ticket ticket = d.userTicket (uid) ;
        
        if (ticket.checkPassword (pwd) && ticket.permissions ().permLgn ()) {
          if (b1) d.logInfo (ipaddr + ":login:" + uid) ;
          session = request.getSession (true) ;
          session.setMaxInactiveInterval (i1) ;
          session.setAttribute ("Ticket",ticket) ;
          action = value_log ;
        }
        else {
      	  d.logWarning (ipaddr + ":invalid:" + uid) ;
      	  action = value_er2 ;
        }
      }

      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      PrintWriter out = response.getWriter () ;
      out.println (layout (action).format (response.encodeURL (layout (action).description ().driverURL () + "?action=" + action))) ;
      out.close () ;
    }
    catch (Exception e) {
      response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ;
    }
  }
}
