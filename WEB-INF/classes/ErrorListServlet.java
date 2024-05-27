// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.* ;

import java.util.List ;
import java.util.Map ;
import java.util.Vector ;
import java.util.LinkedList ;
import java.util.Enumeration ;
import java.util.Iterator ;
import java.util.Properties ;
import java.util.ResourceBundle ;

import html.ListPage ;

import data.DataSourceLayout ;
import data.DataSourceException ;

import misc.Ticket ;
import misc.Jump ;
import misc.Helper ;

public class ErrorListServlet extends MyBasicHttpServlet {

  private final static String param_cnd = "cond" ;			//
  private final static String prfix_cnd = "cond" ;			// 
  private final static String param_bck = "backurl" ;		//
  private final static String prfix_bck = "bck" ;				//

  private ResourceBundle r1 ;
  private ListPage y1 ;
  private String major, s1, s2 ;
  
  public void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      y1 = d.listPage (def, getInitParameter("layout")) ;
      r1 = d.resourceBundle (major) ;
      s1 = r1.getString ("caption") ;
      s2 = r1.getString ("trailer") ;
    }
    catch (Exception e) {
      throw new UnavailableException (e.getMessage ()) ;
    }
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    major = getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {

    try {
    	
      List rws = new LinkedList () ;
      rws.add (y1.textRow (r1.getString (param_cnd))) ;
  
      for (Enumeration pms = request.getParameterNames () ; pms.hasMoreElements() ; ) {
        String  nam = (String) pms.nextElement() ;
        if (nam.startsWith (prfix_cnd)) {
          boolean val = Boolean.valueOf (request.getParameter (nam)).booleanValue () ;
          rws.add (y1.iconTextRow (val ? "cond.ok" : "cond.fail", Helper.htmlConvert (r1.getString (nam)))) ;
        }
      }
      String backurl = request.getParameter (param_bck) ;
      if (backurl != null) {
        Jump j = new DataSourceLayout (getInitParameter("config")).jump (Integer.parseInt (backurl)) ;
        Map r = new java.util.TreeMap () ;
        for (Enumeration pms = request.getParameterNames () ; pms.hasMoreElements() ; ) {
      	  String  nam = (String) pms.nextElement() ;
          if (nam.startsWith (prfix_bck)) { r.put (nam, request.getParameter (nam)) ; }
        }
        Vector o = new Vector () ;
        for (Iterator i = r.entrySet ().iterator () ; i.hasNext () ; o.add (((Map.Entry) i.next ()).getValue ())) ;
        rws.add (y1.textRow (s2, j.get (response, o.toArray ()))) ;
      }
      response.setContentType ("text/html") ;
      PrintWriter out = response.getWriter () ;
      out.println (y1.format (rws, s1)) ;
    }
    catch (Exception e) {
    	response.sendError (HttpServletResponse.SC_BAD_REQUEST, e.getMessage ()) ;
    }
  }
}