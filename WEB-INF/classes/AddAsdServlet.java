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
import java.util.List ;
import java.util.Iterator ;
import java.util.HashMap ;
import java.util.Properties ;
import java.util.ResourceBundle ;

import html.FormListPage ;

import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;

import misc.Helper ;
import misc.Ticket ;
import misc.Jump ;
import misc.Assign ;

final public class AddAsdServlet extends MyBasicHttpServlet {

  private final static String param_ini = "init" ;		// Wahr, falls das Formular zu Ändern das erste Mal angezeigt wird
  private final static String param_lbl = "long" ;		// Label in den Formularen
  private final static String param_dsc = "desc" ;		// Beschreibung
  private final static String param_uid = "lgn" ;			// Benutzer-ID
  private final static String param_aid = "aid" ;			// Asd-ID (bei Neuerstellen -1)
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//
  
  private String major, s1, s2 ;
  private FormListPage p1, p2 ;
  private Properties y1 ;
  private ResourceBundle r1 ;
  private Jump j1, j2, j3, j4, j5, j6, j7 ;
  private List l1 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      y1 = d.properties (major) ;
      p1 = d.formListPage (def, y1.getProperty ("form.add")) ;
      p2 = d.formListPage (def, y1.getProperty ("form.mod")) ;
      j1 = d.jump (150) ;										// Zurück ins Statische Daten-Menue
      j2 = d.jump (620) ;										// Erstellen erfolgreich abgeschlossen
      j7 = d.jump (740) ;										// Ändern erfolgreich abgeschlossen
      j3 = d.jump (630) ;										// Fehlerblatt alles außer Dublette
      j4 = d.jump (640) ;										// Fehlerblatt nur Dublette
      j5 = d.jump (310) ;										// Anmeldefehler
      j6 = d.jump (311) ;										// Berechtigungsfehler
      s1 = r1.getString ("caption.new") ;
      s2 = r1.getString ("caption.mod") ;
      l1 = d.colors () ;
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
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permAdm ()) {
    	response.sendRedirect (j6.redirectURL (response, new Object [0])) ;
    }
    else {
    	
      int uid = -1, aid = -1 ;
      
      boolean condUid = true ;
      boolean condAid = true ;
      
    	try {
    		uid = Integer.parseInt (request.getParameter (param_uid)) ;
    	} catch (Exception e) { condUid = false ; }
    	try {
    		aid = Integer.parseInt (request.getParameter (param_aid)) ;
    	} catch (Exception e) { condAid = false ; }
    	
    	String dsc = request.getParameter (param_dsc) ;
    	String lbl = request.getParameter (param_lbl) ;
    	
    	boolean ini = Boolean.valueOf (request.getParameter (param_ini)).booleanValue () ;
    	
      try {
      	
      	DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter ("schedule")) ;
      	Iterator in1 = db.loginNameList (false,true,true).iterator () ;

      	Map m = new java.util.HashMap () ;
      	m.put (param_aid, Integer.toString (aid)) ;
      	
      	if (ini) {
      		if (!condAid) {
      			throw new IllegalArgumentException ("FATAL: ID missing ...") ;
      		}
      		Assign a = db.assign (aid) ;
      		m.put (param_ini, Boolean.toString (false)) ;
      	  m.put (param_lbl, a.label ()) ;
      	  m.put (param_dsc, a.description ()) ;
      	  m.put (param_uid, new misc.Pair (in1, new Integer (a.login ()))) ;
      	}
        else {
          m.put (param_uid, new misc.Pair (in1, new Integer (condUid ? uid : 0))) ;
          if (dsc != null) m.put (param_dsc, dsc) ;
          if (lbl != null) m.put (param_lbl, lbl) ;
        }
        {       
          response.setContentType ("text/html") ;
          PrintWriter out = response.getWriter () ;      
          out.println (aid == -1 ? p1.format (s1, m) : p2.format (s2, m)) ;
          out.close () ;
        }
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
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permAdm ()) {
    	response.sendRedirect (j6.redirectURL (response, new Object [0])) ;
    }
    else {
      
      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      
      if (cnl) {
        response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
      }
      else {
        try {
        	
     	    int aid = Integer.parseInt (request.getParameter (param_aid)) ;
     	    int uid = Integer.parseInt (request.getParameter (param_uid)) ;
     	    
     	    boolean add = aid == -1 ;
     	    
     	    DataSourceSchedule db = new DataSourceSchedule (getInitParameter ("schedule")) ;
     	    
     	    if (!add) {	// Ändern muss gelingen, wenn die Daten aus dem Formular stammen ...
            db.modAsd (aid, uid, "", "", false) ;
            response.sendRedirect (j7.redirectURL (response, new Object [0])) ;
          }
          else {
          	
      		  String lbl = request.getParameter (param_lbl) ;
      		  String dsc = request.getParameter (param_dsc) ;
      		  
      		  boolean condUid = uid > 0 ;
      		  boolean condNul = (lbl != null ? lbl.length () != 0 : false) && (dsc != null ? dsc.length () != 0 : false) ; 
      		  boolean condCst = condNul ? (Helper.isValidLabel (lbl) && Helper.isValidDescription (dsc)) : false ;
      		
      		  if (condNul && condUid && condCst) {
      		 
      		    if (-1 != db.addAsd (uid, lbl, dsc, true)) {	// ok
      		    	response.sendRedirect (j2.redirectURL (response, new Object [0])) ;
      		    }
      		    else {														// Fehler: Dublette
      		      Object [] o = {Integer.toString (aid),
      		                     condCst ? dsc : misc.Helper.nameConvert (dsc),
          	                   condCst ? lbl : misc.Helper.nameConvert (lbl),
          	                   Integer.toString (uid)} ;
      		  	  response.sendRedirect (j4.redirectURL (response, o)) ;
      		  	}
      		  }
            else {
          	  Object [] o = {Boolean.toString (condCst),
          	                 Boolean.toString (condNul),
          	                 Boolean.toString (condUid),
          	                 Integer.toString (aid),
          	                 dsc == null ? "" : (condCst ? dsc : misc.Helper.nameConvert (dsc)),
          	                 lbl == null ? "" : (condCst ? lbl : misc.Helper.nameConvert (lbl)),
          	                 condUid ? Integer.toString (uid) : ""
          	                 } ;
              response.sendRedirect (j3.redirectURL (response, o)) ;
            }
          }
        }
        catch (Exception e) {
          response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + " " + e.getMessage ()) ;
        }
      }
    }
  }
}
