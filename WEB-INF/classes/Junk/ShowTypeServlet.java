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

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceScheduleRead ;

import misc.Helper ;
import misc.Pair ;
import misc.Ticket ;
import misc.Jump ;

final public class ShowTypeServlet extends MyBasicHttpServlet {
	
  private final static String form1 = "showtype" ;		// Formularschlüssel
  private final static String param_tid = "tid" ;			// Parameter mit der uid
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//

  private String major ;
  private String s2 ;
  private FormListPage p1 ;
  private ResourceBundle r1 ;
  private Jump j1, j2, j3, j4, j5 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.formListPage (def, form1) ;
      s2 = r1.getString ("caption") ;
      j1 = d.jump (93) ;								// Benutzereinstellungen ändern für UID
      j2 = d.jump (150) ;						 		// Statische Daten-Menue
      j3 = d.jump (92) ;								// Fehlerblatt falsche/keine UID
      j4 = d.jump (310) ;								// Fehler: Keine Anmeldung
      j5 = d.jump (311) ;								// Fehler: Berechtigung fehlt
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
    
    if (u == null) {
    	response.sendRedirect (j4.redirectURL (response,new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j5.redirectURL (response,new Object [0])) ;
    }
    else {
      try {
      	DataSourceScheduleRead d = new DataSourceScheduleRead (getInitParameter("schedule")) ;
        Map m = new HashMap () ;
        m.put (param_tid, new Pair (d.typeList (false).iterator (), new Integer (0))) ;
        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;      
        out.println (p1.format (s2, m)) ;
        out.close () ;
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ;
      }
    }
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null) {
    	response.sendRedirect (j4.redirectURL (response,new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j5.redirectURL (response,new Object [0])) ;
    } 
    else {
      
      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      try {
      	if (cnl) {
          response.sendRedirect (j2.redirectURL (response,new Object [0])) ;
      	}
      	else {
          int tid = Integer.parseInt (request.getParameter (param_tid)) ;
          if (tid == 0) {
            response.sendRedirect (j3.redirectURL (response,new Object [0])) ;
          }
          else {
            Object [] o = {Integer.toString (tid)} ;
            response.sendRedirect (j1.redirectURL (response,o)) ;
          }
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_BAD_REQUEST, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }
}
