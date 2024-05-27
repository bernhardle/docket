// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-200

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Locale ;

import html.NavigatorPage ;

import misc.Ticket ;
import misc.Jump ;
import misc.JumpTarget ;

import data.DataSourceException ;
import data.DataSourceConfiguration ;
import data.DataSourceForm ;

final public class NavigatorServlet extends MyBasicHttpServlet {

  private String major ;
  private NavigatorPage pageLayout ;
  private Jump j1, j2, j3, j4, j5 ;

  protected void reload () throws ServletException {
   try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      pageLayout = new NavigatorPage (d.formBasePage (def,getInitParameter("layout")),"Suche",8,0) ;
      j1 = d.jump (100) ;
      j2 = d.jump (101) ;
      j3 = d.jump (102) ;
      j4 = d.jump (103) ;
      j5 = d.jump (104) ;
    }
    catch (DataSourceException e) {
      throw new UnavailableException (e.getMessage ()) ;
    }
  }

  public void init (ServletConfig cfg) throws ServletException { 
    super.init (cfg) ;
    major = getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (null == session) ? null : (Ticket) session.getAttribute ("Ticket") ;

    NavigatorPage.IconTable iconTable = pageLayout.new IconTable () ;
     
    iconTable.addIcon ("overview", j1.get (response, new Object [0])) ;
    if (u == null ? false : u.permissions ().permCrt ()) iconTable.addIcon ("insert", j2.get (response, new Object [0])) ;
    if (u == null ? false : u.permissions ().permLgn ()) iconTable.addIcon ("service", j3.get (response, new Object [0])) ;
    if (u == null ? false : u.permissions ().permAdm ()) iconTable.addIcon ("user", j4.get (response, new Object [0])) ;
    iconTable.addIcon ("help", j5.get (response, new Object [0])) ;

    response.setContentType ("text/html") ;
    response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
    PrintWriter out = response.getWriter () ;
    out.println (pageLayout.format (iconTable)) ;
    out.close () ;
  }
}
