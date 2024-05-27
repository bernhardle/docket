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
import java.util.HashMap ;
import java.util.Iterator ;
import java.util.Collections ;
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
import misc.Option ;
import misc.Jump ;

final public class DeleteUserServlet extends MyBasicHttpServlet {

  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//
  private final static String param_nme = "nme" ;			//	Benutzernamen
  private final static String param_uid = "lgn" ;			//	UID
  private final static String param_adm = "adm" ;			//	Admin-Kennwort
  private final static String param_asd = "asd" ;			//	Zuweisung

  private String major ;

  private ResourceBundle r1 ;
  private FormListPage p1, p2 ;
  private Jump j1, j2, j3, j4, j5, j6 ;
  private String s1 ;
  
  List exclude (List d, int k) throws IllegalArgumentException {
    List l = new java.util.LinkedList (d) ;
    for (Iterator i = l.iterator () ; i.hasNext () ; ) {
      Option o = (Option) i.next () ;
      if (o.key () == k) {
      	i.remove () ;
      	return Collections.unmodifiableList (l) ;
      }
   	}
   	throw new IllegalArgumentException () ;
  }
  
  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.formListPage (def, "deluser") ;
      p2 = d.formListPage (def, "deluserX") ;
      j1 = d.jump (310) ;		// Anmeldefehler
      j2 = d.jump (311) ;		// Berechtigungsfehler
      j3 = d.jump (71) ;		// Zurück in's Benutzermenü
      j4 = d.jump (441) ;		// Löschen erfolgreich
      j5 = d.jump (442) ;		// Löschen gescheitert
      j6 = d.jump (443) ;		// dto. mit Defaults
      s1 = r1.getString ("caption.del") ;
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
    	response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permAdm ()) {
    	response.sendRedirect (j2.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
      	
      	int uid = Integer.parseInt (request.getParameter (param_uid)) ;
      	int asd = 0 ;
      	
      	try {
    	  	asd = Integer.parseInt (request.getParameter (param_asd)) ;
       	} catch (Exception e) { }
      	
        DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter("schedule")) ;
        Ticket t = db.userTicket (uid) ;
        
        boolean rea = t.assigned () > 0 ; 	// Neuzuweisung der Bearbeiterkürzel
        
        Map m = new HashMap () ;
        m.put (param_uid, Integer.toString (uid)) ;
        m.put (param_nme, t.name ()) ;
        if (rea) {
        	m.put (param_asd, new misc.Pair (exclude (db.loginNameList (false,false,true), uid).iterator (), new Integer (asd))) ;
        }
        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;      
        out.println (rea ? p2.format (s1,m) : p1.format (s1,m)) ;
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
    	response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permAdm ()) {
    	response.sendRedirect (j2.redirectURL (response, new Object [0])) ;
    } 
    else {
 
      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      if (cnl) {
        response.sendRedirect (j3.redirectURL (response, new Object [0])) ;
      }
      else {
        try {
        	
          int uid = Integer.parseInt (request.getParameter (param_uid)) ;
          String pss = request.getParameter (param_adm) ;
          
          DataSourceSchedule db = new DataSourceSchedule (getInitParameter("schedule")) ;
          Ticket t = db.userTicket (uid) ;
          boolean rea = t.assigned () > 0 ; 	// Neuzuweisung der Bearbeiterkürzel erforderlich
          
          if (!rea) {
            if (db.userTicket (1).checkPassword (pss)) {
              if (db.delUser (uid, -1)) {
              	if (uid == u.uid ()) session.invalidate () ;
                response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
              }
              else {
              	response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
              }
            }
            else {
          	  Object [] o = {Integer.toString (uid)} ;
              response.sendRedirect (j5.redirectURL (response, o)) ;
            }
          }
          else {
          	int asd = Integer.parseInt (request.getParameter (param_asd)) ;
          	boolean asdOK = false ;
          	boolean pswOK = db.userTicket (1).checkPassword (pss) ;
          	
          	for (Iterator i = exclude (db.assignList (), uid).iterator () ; i.hasNext () ; asdOK |= ((Option) i.next ()).key () == asd) ;

          	if (asdOK && pswOK) {
              if (db.delUser (uid, asd)) {
              	if (uid == u.uid ()) session.invalidate () ;
                response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
              }
              else {
              	response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
              }
            }
            else {
          	  Object [] o = {	Boolean.toString (asdOK),
          	  								Boolean.toString (pswOK),
          	  								Integer.toString (uid),
          	  							 	Integer.toString (asd)} ;
              response.sendRedirect (j6.redirectURL (response, o)) ;            	
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
