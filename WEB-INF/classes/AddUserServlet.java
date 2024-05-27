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
import misc.Helper ;

final public class AddUserServlet extends MyBasicHttpServlet {
	
	private final static String form1 = "adduser" ;			// Formularschlüssel
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			// 
  private final static String param_lgn = "lgn" ;			// Benutzerkürzel
  private final static String param_nme = "nme" ;			// Benutzername
  private final static String param_psa = "psa" ;			// Erste Eingabe Kennwort
  private final static String param_psb = "psb" ;			// Zweite Eingabe Kennwort
  private final static String param_adm = "adm" ;			// Admin Kennwort

  private String major ;
  private String s1, s2 ;
  private FormListPage p1 ;
  private BodyPage p2 ;
  private ResourceBundle r1 ;
  private Jump j1, j2, j3, j4, j5 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p2 = d.bodyPage (def, "default") ;
      p1 = d.formListPage (def, form1) ;
      s1 = r1.getString ("errmsg1") ;
      s2 = r1.getString ("caption") ;
      j1 = d.jump (71) ;								// Zurück in's Benutzermenue
      j2 = d.jump (400) ;								// Fehlerblatt (fail)
      j3 = d.jump (401) ;								// Vorgang ausgeführt (ok)
      j4 = d.jump (300) ;
      j5 = d.jump (301) ;
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
    	response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;      
        out.println (p1.format (s2)) ;
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
    	response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    } 
    else {

      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      if (cnl) {
        response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
      }
      else {
        try {
          
          String shd = request.getParameter (param_lgn) ;
          String nam = request.getParameter (param_nme) ;
          String psa = request.getParameter (param_psa) ;
          String psb = request.getParameter (param_psb) ;
          String pss = request.getParameter (param_adm) ;
          
          DataSourceSchedule db = new DataSourceSchedule (getInitParameter("schedule")) ;
          
          boolean condNul = nam.trim ().length () != 0 && shd.trim ().length () != 0 ;
          boolean condShd = Helper.isValidShorthand (shd) ;
          boolean condNam = Helper.isValidName (nam) ;
          boolean condDub = true ;
          boolean condCnf = psb.compareTo (psa) == 0 ;
          boolean condAdm = db.userTicket (1).checkPassword (pss) ;
          
          boolean condAll = condNul && condShd && condNam && condDub && condCnf && condAdm ;

          if (condAll) {    	
            db.createLogin (shd, nam, psa) ;
            response.sendRedirect (j3.redirectURL (response, new Object [0])) ;
          }
          else {
            Object o [] = {Boolean.toString (condNul),
          								 Boolean.toString (condShd),
          								 Boolean.toString (condNam),
          								 Boolean.toString (condDub),
          								 Boolean.toString (condCnf),
          								 Boolean.toString (condAdm)} ;
          	response.sendRedirect (j2.redirectURL (response, o)) ;
          }
        }
        catch (Exception e) {
          response.sendError (HttpServletResponse.SC_BAD_REQUEST, e.getClass ().getName () + " " + e.getMessage ()) ;
        }
      }
    }
  }
}
