// (c) Bernhard Schupp 2001-2002

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.* ;

import html.template.TemplatePage ;

import data.DataSourceConfiguration ;
import data.DataSourceException ;

final public class SimpleTemplateServlet extends MyBasicHttpServlet {

  private TemplatePage p1 ;
  private String major ;

  protected void reload () throws ServletException {
    try {
      p1 = new TemplatePage (new DataSourceConfiguration (getInitParameter("config")).templateDescription (def, getInitParameter("template"))) ;
    }
    catch (Exception e) {
    	throw new UnavailableException (e.getMessage ()) ;
    }
  }

  public void init (ServletConfig c) throws ServletException {
    super.init (c) ;
    major = getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
    response.setContentType ("text/html") ;
    PrintWriter out = response.getWriter () ;
    out.println (p1.format ()) ;
    out.close () ;
  }
}

