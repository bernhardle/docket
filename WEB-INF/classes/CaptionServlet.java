// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Map ; 
import java.util.Collections ;

import html.CaptionPage ;

import misc.Ticket ;
import misc.Caption ;

import data.DataSourceConfiguration ;
import data.DataSourceLayout ;

final public class CaptionServlet extends MyBasicHttpServlet {

  private final static String param_acn = "action" ;
  private CaptionPage p1 ;
  private Map m1 ;

  protected void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      p1 = d.captionPage (def, "default") ;
      m1 = Collections.synchronizedMap (new java.util.HashMap ()) ;
    }
    catch (Exception e) {
      throw new UnavailableException (e.getMessage ()) ;
    }
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String arg = request.getParameter (param_acn) ;
      if (!m1.containsKey (arg)) {
        m1.put (arg, p1.format (new DataSourceConfiguration (getInitParameter("config")).caption (def,arg))) ;
      }
      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 60000) ;
      PrintWriter out = response.getWriter () ;
      out.println ((String) m1.get (arg)) ;
      out.close () ;
    }
    catch (Exception e) {
      response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
    }
  }
}