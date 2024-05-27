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

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;

import misc.Helper ;
import misc.Pair ;
import misc.Ticket ;
import misc.Jump ;

final public class ModifyUserServlet extends MyBasicHttpServlet {

  private final static String param_uid = "lgn" ;			// Parameter mit der uid
  private final static String param_adm = "adm" ;			// Parameter mit dem Admin Kennwort
  private final static String param_nme = "nme" ;			// Parameter mit dem Benutzernamen zur Anzeige
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//
  private final static String param_pm1 = "permlgn" ;	// Berechtigung zum Anmelden,
  private final static String param_pm2 = "permadm" ;	// z. Verwalten,
  private final static String param_pm3 = "permcrt" ;	// z. Erstellen von Einträgen,
  private final static String param_pm4 = "permdel" ;	// z. Streichen von Einträgen,
  private final static String value__on = "ON" ;
  private final static String value_off = "OFF" ;
  
  private String major, s2 ;
  private FormListPage p3 ;
  private ResourceBundle r1 ;
  private Jump j1, j2, j3, j4, j5, j6 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p3 = d.formListPage (def, "moduser") ;
      j1 = d.jump (67) ;										// Benutzereinstellungen ändern (0)
      j2 = d.jump (68) ;										// Fehlerblatt falsches Admin-Kennwort
      j3 = d.jump (71) ;										// Benutzermenue
      j4 = d.jump (72) ;										// Fehlerblatt falsche/keine UID
      j5 = d.jump (300) ;
      j6 = d.jump (301) ;
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
    
    if (u == null) {
    	response.sendRedirect (j5.redirectURL (response,new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j6.redirectURL (response,new Object [0])) ;
    }
    else {
      try {
 
        String lgn = request.getParameter (param_uid) ;
          	
        int uid = Integer.parseInt (lgn) ;
            	
        Ticket x = new DataSourceScheduleRead (getInitParameter("schedule")).userTicket (uid) ;
            
        Map m = new HashMap () ;
        m.put (param_uid, Integer.toString (x.uid())) ;
        m.put (param_nme, x.name ()) ;
        m.put (param_pm1, x.permissions ().permLgn () ? value__on : value_off) ;
        m.put (param_pm2, x.permissions ().permAdm () ? value__on : value_off) ;
        m.put (param_pm3, x.permissions ().permCrt () ? value__on : value_off) ;
        m.put (param_pm4, x.permissions ().permDel () ? value__on : value_off) ;
         
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

    if (u == null) {
    	response.sendRedirect (j5.redirectURL (response,new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j6.redirectURL (response,new Object [0])) ;
    } 
    else {
      
      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      try {
      	if (cnl) {
          response.sendRedirect (j3.redirectURL (response,new Object [0])) ;
      	}
      	else {
          int uid = Integer.parseInt (request.getParameter (param_uid)) ;
          String s1 = request.getParameter (param_pm1) ;
          String s2 = request.getParameter (param_pm2) ;
          String s3 = request.getParameter (param_pm3) ;
          String s4 = request.getParameter (param_pm4) ;
          boolean b1 = s1 == null ? false : s1.compareTo (value__on) == 0 ;
          boolean b2 = s2 == null ? false : s2.compareTo (value__on) == 0 ;
          boolean b3 = s3 == null ? false : s3.compareTo (value__on) == 0 ;
          boolean b4 = s4 == null ? false : s4.compareTo (value__on) == 0 ;
          	
          DataSourceSchedule db = new DataSourceSchedule (getInitParameter("schedule")) ;
          if (db.userTicket (1).checkPassword (request.getParameter (param_adm))) {
            db.modUser (uid, b1, b2, b3, b4) ;
          	response.sendRedirect (j1.redirectURL (response,new Object [0])) ;
          }
          else {
            Object o [] = {Boolean.toString (false),
            							 Integer.toString (uid)} ;
          	response.sendRedirect (j2.redirectURL (response,o)) ;
          }
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_BAD_REQUEST, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }
}
