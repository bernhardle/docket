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

import html.BodyPage ;
import html.FormListPage ;
import html.template.TemplatePage ;

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;

import misc.Helper ;
import misc.Pair ;
import misc.Ticket ;
import misc.Jump ;

final public class ChangePasswordServlet extends MyBasicHttpServlet {

  private final static String form1 = "password" ;		//
  private final static String param_uid = "lgn" ;			// Benutzernummer
  private final static String param_nme = "nme" ;			// Benutzername (lang)
  private final static String param_pso = "pso" ;			// Bisheriges Kennwort
  private final static String param_psa = "psa" ;			// Geändertes Kennwort, 1. Eingabe
  private final static String param_psb = "psb" ;			// Geändertes Kennwort, 2. Eingabe
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//
  private final static String resky_er1 = "errmsg1" ;	// Fehlermeldung: Keine Berechtigung
  private final static String resky_lyt = "default" ;	// Layout Schlüssel
  
  private String major ;
  private String s1, s2 ;
  private FormListPage p1 ;
  private ResourceBundle r1 ;
  private Jump j1, j2, j3, j4, j5, j6 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.formListPage (def, form1) ;
      s1 = r1.getString (resky_er1) ;
      s2 = r1.getString ("caption") ;
      j1 = d.jump (80) ;							// Anzeige ok
      j2 = d.jump (81) ;							// Anzeige Fehler
      j3 = d.jump (82) ;							// Zurück ins Tools-Menue
      j4 = d.jump (300) ;							// Anmeldefehler
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
    
    if (u == null ? true : ! u.permissions ().permLgn ()) {
    	response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
        Map m = new HashMap () ;
        m.put (param_nme, u.name ()) ;
        m.put (param_uid, Integer.toString (u.uid ())) ;
        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;      
        out.println (p1.format (s2, m)) ;
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

    if (u == null ? true : ! u.permissions ().permLgn ()) {
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    }
    else {
      
      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      if (cnl) {
        response.sendRedirect (j3.redirectURL (response, new Object [0])) ;
      }
      else {
        try {
        	
          int uid = Integer.parseInt (request.getParameter (param_uid)) ;
          String psw = request.getParameter (param_pso) ;
          String ps1 = request.getParameter (param_psa) ;
          String ps2 = request.getParameter (param_psb) ;
          DataSourceSchedule db = new DataSourceSchedule (getInitParameter("schedule")) ;

          if (db.userTicket (uid).checkPassword (psw)) {
            if (ps1.compareTo (ps2) == 0) { 
               if (db.setPassword (uid,ps1)) {
                 response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
               }
               else {
               	 response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
               }
            } else {
            	Object o [] = {Boolean.toString (true),
          								   Boolean.toString (true),
          								   Boolean.toString (false)} ;
            	response.sendRedirect (j2.redirectURL (response, o)) ; 
            }
          } else {
          	Object o [] = {Boolean.toString (false),
          								 Boolean.toString (true),
          								 Boolean.toString (true)} ;
          	response.sendRedirect (j2.redirectURL (response, o)) ;
          }
        }
        catch (Exception e) {
          response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + " " + e.getMessage ()) ;
        }
      }
    }
  }
}
