// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Map ;
import java.util.Iterator ;

import misc.Jump ;
import misc.Ticket ;

import html.frame.Inner ;
import html.frame.Argument ;

import data.DataSourceException ;
import data.DataSourceLayout ;
import data.DataSourceConfiguration ;

final public class InnerFrameServlet extends MyBasicHttpServlet {

  private final static String c1 = "?", c2 = "&", c3 = "=" ;
  private final static String param_acn = "action" ;
  private final static String param_tok = "token" ;
  private final static String value_sea = "search" ;
  
  private String major ;
  private Map m1 ;
  private Jump j1, j2 ;

  protected void reload () throws ServletException {
    m1 = java.util.Collections.synchronizedMap (new java.util.HashMap ()) ;
    try {
      DataSourceConfiguration d = new DataSourceConfiguration (getInitParameter("config")) ;
      j1 = d.jump (34) ;
      j2 = d.jump (35) ;
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

  Inner layout (String key) throws DataSourceException {
    if (! m1.containsKey (key)) {
       m1.put (key,new Inner (new DataSourceLayout (getInitParameter("config")).frameDescription (def,key))) ;
    }
    return (Inner) m1.get (key) ;
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doGet (request, response) ;
    return ;	
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	// Ausnahme für die Direktsprung-Option über das Suchfeld:

    String acn = request.getParameter (param_acn) ;
    
    if (acn == null) {
    	response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
    	return ;
    }
    
    if (0 == acn.compareTo (value_sea)) {
      try {
      	Object r [] = {misc.Helper.parseDate (request.getParameter (param_tok)).toString ()} ;
        response.sendRedirect (j1.redirectURL (response, r)) ;
        return ;
      }
      catch (Exception e) {}
    }

	// Standardablauf ab hier ...

    try {
     
      Inner layout = layout (acn) ;

      StringBuffer buf = new StringBuffer (layout.description ().bodyURL ()) ;

      boolean first = true ;
      for (Iterator i = layout.description ().arguments (); i.hasNext () ; ) {
        Argument a = (Argument) i.next () ;
        String s = request.getParameter (a.name ()) ;

        if (s != null) {
          buf.append (first ? c1 : c2) ;
          buf.append (a.name ()) ;
          buf.append (c3) ;
          buf.append (s) ;
          first = false ;
        } 
        else {
          if (! a.optional ()) {
          	response.sendError (HttpServletResponse.SC_BAD_REQUEST, "FATAL: non optional argument \'" + a.name () + "\' missing in request") ;
          	return ;
          }
          if (a.defval () != null) {
            buf.append (first ? c1 : c2) ;
            buf.append (a.name ()) ;
            buf.append (c3) ;
            buf.append (a.defval ()) ;
            first = false ;
          }
        }
      }

      response.setContentType ("text/html") ;
      PrintWriter out = response.getWriter () ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      Object r [] = {acn} ; 
      out.println (layout.format (j2.get(response,r).url (), response.encodeURL (buf.toString ()))) ;
      out.close () ;
    }
    catch (Exception e) {
    	response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ;
    }
  }
}
