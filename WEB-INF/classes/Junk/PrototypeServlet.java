// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.IOException ;
import java.io.PrintWriter ;
import javax.servlet.ServletConfig ;
import javax.servlet.ServletException ;
import javax.servlet.UnavailableException ;
import javax.servlet.http.HttpSession ;
import javax.servlet.http.HttpServletRequest ;
import javax.servlet.http.HttpServletResponse ;

import java.util.Map ;
import java.util.HashMap ;
import java.util.ResourceBundle ;

import html.FormListPage ;

import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;

import misc.Helper ;
import misc.Ticket ;
import misc.Jump ;

final public class ???Servlet extends MyBasicHttpServlet {

  private final static String form1 = ??? ;						// 
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//
  
  private String major, s1, s2 ;
  private FormListPage p1 ;
  private ResourceBundle r1 ;
  private Jump j1 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.formListPage (def, form1) ;
      j1 = d.jump (??) ;										// 'cancel'
      s1 = r1.getString ("errmsg1") ;
      s2 = r1.getString ("caption") ;
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

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;
    
    if (u == null ? true : ! u.permissions ().perm??? ()) {
    	response.sendError (HttpServletResponse.SC_FORBIDDEN, s1) ;
    }
    else {
      try {
 
         
        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;      
        out.println (p3.format (s2, m)) ;
        out.close () ;
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null ? true : ! u.permissions ().perm??? ()) {
    	response.sendError (HttpServletResponse.SC_FORBIDDEN, s1) ;
    } 
    else {
      
      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      try {
      	if (cnl) {
          response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
      	}
      	else {

        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_BAD_REQUEST, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }
}
