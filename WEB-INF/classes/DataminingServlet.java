// (c) Bernhard Schupp 2001-2002

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import html.RawPage ;
import html.RawPageImpl ;
import html.text.TableFormat ;

import data.DataSourceScheduleRead ;

final public class DataminingServlet extends MyBasicHttpServlet {

  private String d1, q1 ;
  private TableFormat f1 ;
  private RawPage p1 ;

  protected void reload () throws ServletException {
    d1 = getInitParameter ("schedule") ;
    q1 = getInitParameter ("query") ;
    f1 = new TableFormat () ;
    p1 = new RawPageImpl () ;
    if (q1 == null ? true : (q1.length () == 0 ? true : false) || 
        d1 == null ? true : (d1.length () == 0 ? true : false)) 
      throw new UnavailableException ("Invalid key for query/database") ;
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      PrintWriter out = response.getWriter () ;
      out.println (p1.format (f1.format (new DataSourceScheduleRead (d1).executeQuery (q1)))) ;
      out.close () ;
    }
    catch (Exception e) {
    	response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ;
    }
  }
}