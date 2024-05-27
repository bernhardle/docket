// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.* ;

import java.util.List ;
import java.util.ResourceBundle ;

import html.LoginPage ;

import misc.Ticket ;

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceScheduleRead ;

final public class LoginServlet extends MyBasicHttpServlet {

  private String major ;
  private LoginPage l1, l2 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      ResourceBundle r = d.resourceBundle (major) ;
      String a1 = r.getString ("userLoc") ;
      String a2 = r.getString ("passLoc") ;
      String a3 = r.getString ("logoLoc") ;
      l1 = new LoginPage (d.formBasePage (def,getInitParameter("layoutLogin")), a1, a2, a3, 4) ;
      l2 = new LoginPage (d.formBasePage (def,getInitParameter("layoutLogout")), a1, a2, a3, 4) ;
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

    HttpSession session = request.getSession (false) ;
    Ticket u = session == null ? null : (Ticket) session.getAttribute ("Ticket") ;

    try {
      String s = (u == null ? true : ! u.permissions ().permLgn ()) ? l1.format (new DataSourceScheduleRead (getInitParameter("schedule")).loginNameList (true,false,false)) : l2.format (u)  ;
      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      PrintWriter out = response.getWriter () ;
      out.println (s) ;
      out.close () ;
    }
    catch (Exception e) {
     response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ; 
    }
  }
}
