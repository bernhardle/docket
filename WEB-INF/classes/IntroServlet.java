// (c) Bernhard Schupp 2001-2002

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.List ;
import java.util.Locale ;
import java.util.Iterator ;
import java.util.ResourceBundle ;

import html.BodyPage ;

import data.DataSourceException ;
import data.DataSourceLayout ;

final public class IntroServlet extends MyBasicHttpServlet {

  private String major ;
  private BodyPage p1 ;
  private ResourceBundle r1 ;
  
  protected void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      p1 = d.bodyPage (def,getInitParameter ("layout")) ;
      r1 = d.resourceBundle (major) ;
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

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType ("text/html") ;
    response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
    PrintWriter out = response.getWriter () ;
    out.println (p1.format (r1.getString ("contents"),r1.getString ("caption"))) ;
    out.close () ;
  }
}
