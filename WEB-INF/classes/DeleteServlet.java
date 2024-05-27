// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.Date ;

import java.util.Map ;
import java.util.HashMap ;
import java.util.List ;
import java.util.LinkedList ;
import java.util.Locale ;
import java.util.Iterator ; 
import java.util.Calendar ;
import java.util.Properties ;
import java.util.ResourceBundle ;

import java.text.DateFormat ;
import java.text.MessageFormat ;

import html.FormListPage ;

import misc.Pair ;
import misc.Jump ;
import misc.Helper ;
import misc.Ticket ;
import misc.Detail ;
import misc.Option ;
import misc.Notification ;
import misc.AutoContinuation ;

import dynamic.meta.Meta ;

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;

final public class DeleteServlet extends MyBasicHttpServlet {

  private final static String param__id = "id" ;			//	Frist, ID
  private final static String param_det = "detail" ;	//	Detail-Pseudo-Input
  private final static String param_ext = "extend" ;	//	Formular erweitern
  private final static String param_txt = "cmm" ;			//	Kommentar
  private final static String param_bas = "bas" ;			//	
  private final static String param_ref = "ref" ;			//
  private final static String param_off = "off" ;			//
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//

  private Jump j1, j2, j3, j4, j5, j6, j7, j8 ;
  private MessageFormat f2, f3 ; 
  private String major, s1 ;
  private FormListPage p2, p3, p4 ;
  private Properties y1 ;
  private ResourceBundle r1 ;
  private Meta meta ;
  private List l1, l2, l3 ;

  private DateFormat dateFormat = DateFormat.getDateInstance (DateFormat.LONG) ;

  public void reload () throws ServletException {
    major = getServletName () ;
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter ("config")) ;
      y1 = d.properties (major) ;
      r1 = d.resourceBundle (major) ;
      
      s1 = r1.getString ("errmsg1") ;
      
	// URLs:
      j1 = d.jump (44) ;						// Übersicht nach 'id'
      j2 = d.jump (53) ;						// Löschen GET/POST
      j3 = d.jump (59) ;						// Fehlerblatt kurz
      j5 = d.jump (57) ;						// Fehlerblatt lang
      j6 = d.jump (64) ;						// Fehlerblatt ohne Rücksprung
      j4 = d.jump (60) ;						// Formular erweitern
      j7 = d.jump (300) ;						// Anmeldefehler
      j8 = d.jump (301) ;						// Berechtigung fehlt
	// Bestätigungsformulare:
	
      p2 = d.formListPage (def,"confirm") ;				// einfach
      p3 = d.formListPage (def,"confirmX") ;			// dto. mit Kommentar
      p4 = d.formListPage (def,"confirmPX") ;			// dto. mit Fortsetzung
      
	// Überschriften:
      f2 = new MessageFormat (r1.getString ("caption.deadline")) ;			// Frist löschen
      f3 = new MessageFormat (r1.getString ("caption.notification")) ;	// Wiedervorlage löschen
      
      l1 = new java.util.LinkedList () ;
      l1.add (new misc.Option (0, r1.getString ("option.base.1"))) ;
      l1.add (new misc.Option (1, r1.getString ("option.base.2"))) ;
      l1.add (new misc.Option (2, r1.getString ("option.base.3"))) ;
      
      
      l2 = new java.util.LinkedList () ;
      l2.add (new misc.Option (0, r1.getString ("option.base.1"))) ;
      l2.add (new misc.Option (1, r1.getString ("option.base.2"))) ;
      
      l3 = new DataSourceScheduleRead (getInitParameter ("schedule")).shiftBaseList () ;
      
      meta = (Meta) Class.forName (y1.getProperty ("meta")).newInstance () ;
    }
    catch (Exception e) {
      throw new UnavailableException (e.getMessage ()) ;
    }
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null) {
    	response.sendRedirect (j7.redirectURL (response, new Object [0])) ;
    }
    else if (! u.permissions ().permDel ()) {
      response.sendRedirect (j8.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
      	
        DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter ("schedule")) ;
        int i = Integer.parseInt (request.getParameter (param__id)) ;
        
        boolean ext = request.getParameter (param_ext) != null ;
        
        Detail det = db.detail (i) ;
        
        if (i == det.id ()) {
        	
          AutoContinuation ap = db.autoContinuation (i) ;
          
          boolean pro = ap != null ;
          
          FormListPage p = pro ? p4 : (ext ? p3 : p2) ;

          Object [] o = {db.dateFromID (i)} ;
          
       	  Map g = new java.util.HashMap () ;
  	      g.put (param_det, det) ;
  	      g.put (param__id, Integer.toString (i)) ;
  	      
  	      if (pro) g.put (param_bas, new Pair (l3.iterator (), new Integer (5))) ;
  	      if (pro) g.put (param_ref, new Pair (l1.iterator (), new Integer (0))) ;
  	      if (pro) g.put (param_off, Integer.toString (10)) ;
  	      
  	      response.setContentType ("text/html") ;
          PrintWriter out = response.getWriter () ;
          out.println (p.format (f2.format (o), g)) ;
          out.close () ;   
        }
        else {
        	
          FormListPage p = ext ? p3 : p2 ;

          Object [] o = {db.dateFromID (i)} ;
          
       	  Map g = new java.util.HashMap () ;
  	      g.put (param_det, det) ;
  	      g.put (param__id, Integer.toString (i)) ;
  	      
  	      response.setContentType ("text/html") ;
          PrintWriter out = response.getWriter () ;
          out.println (p.format (f3.format (o), g)) ;
          out.close () ;
        }
      }
      catch (DataSourceException e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
      }
    }
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;
    
    if (u == null) {
    	response.sendRedirect (j7.redirectURL (response, new Object [0])) ;
    }
    else if (! u.permissions ().permDel ()) {
      response.sendRedirect (j8.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
      	
	// Anfang: Parameter auslesen und überprüfen:
      	 
      	int gid = -1, ref = -1, bas = -1, off = -1, typ = -1 ;
      	Date due = null ;
      	Detail det = null ;
        String cmm = request.getParameter (param_txt) ;
        
        
        DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter ("schedule")) ;
        
        boolean condGid = false,		// Falsche Frist-/Wiedervorlagenummer
                condRef = false,		// Falscher Wert von 'ref'
                condBas = false,		// Falscher Wert von 'bas'
                condOff = false,		// Falscher Wert von 'off'
                condDue = false,		// Neues Datum liegt nicht in der Zukunft
                condCmm = false,		// Kommentar zu lang
                condPro = false ;		// Fortsetung ausgeschlossen
        
        condCmm = cmm == null ? true : (cmm.length () < maxCmmLen) ;
        
        try {
          gid = Integer.parseInt (request.getParameter (param__id)) ;
          det = db.detail (gid) ;
          condGid = true ;
        } catch (Exception e) {}

        boolean ext = request.getParameter (param_ext) != null ;
        boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

        if (condGid && ext) {	// Formular erweitern ...
          Object o [] = {Integer.toString (gid)} ;
          response.sendRedirect (j4.redirectURL (response, o)) ;
        }
        else if (condGid && cnl) {				// Vorgang abbrechen und zurück zur Übersicht ...
          Object o [] = {Integer.toString (gid)} ;
          response.sendRedirect (j1.redirectURL (response, o)) ;
        }
        else {
          if (condGid && det.id () == gid) {														// Frist wird gelöscht
          
            List lrf = Helper.afterToday (db.dateFromID (gid)) ? l1 : l2 ;
            
            try {
              ref = Integer.parseInt (request.getParameter (param_ref)) ;
              for (Iterator i = lrf.iterator () ; i.hasNext () ; ) {
              	if (((Option) i.next ()).key () == ref) condRef = true ;
              }
            } catch (Exception e) {}
          
            if (condRef ? (ref == 1 || ref == 2) : false) {							// Mit Fortsetzung ...
            
              AutoContinuation ap = db.autoContinuation (gid) ;
              typ = ap.type () ;
              condPro = (ap != null) ;
              
              if (condPro) {																						// Fortsetzung zulässig ...
              	
                try {
          	      bas = ap.mutable () ? Integer.parseInt (request.getParameter (param_bas)) : ap.base () ;
                  for (Iterator i = l3.iterator () ; i.hasNext () ; ) {
              	    if (((Option) i.next ()).key () == ref) condBas = true ;
                  }
                } catch (Exception e) {}
              
                try {
          	      off = ap.mutable () ? Integer.parseInt (request.getParameter (param_off)) : ap.offset () ;
          	      if (off > 0) {
          	      	condOff = true ;
          	        Calendar cal = Calendar.getInstance () ;	
          	        if (ref == 2) cal.setTime (det.date ()) ;
                    cal.add (bas, off) ;
                    due = Helper.parseDate (new Date (cal.getTime ().getTime ()).toString ()) ;
                    condDue = Helper.afterToday (due) && due.after (det.date ()) ;
          	      }
                } catch (Exception e) {}
              }
            } else {
            	condBas = true ;
            	condPro = true ;
            	condOff = true ;
            	condDue = true ;
            }
          } else {
          	ref = 0 ;
            condRef = true ;
            condPro = true ;
            condBas = true ;
            condOff = true ;
            condDue = true ;
          }
          
// Fertig Parameter prüfen.

          if (condGid && condRef && condBas && condOff && condPro && condDue && condCmm) {
          	
          	DataSourceSchedule d = new DataSourceSchedule (getInitParameter ("schedule")) ;
          	
            if (ref == 1 || ref == 2) {
            	d.insertDueEntry (due, 1, typ, det.file (), det.subject (), u.uid (), det.comment (), meta.compress (det.subject ())) ;
            }

            if (cmm == null) d.hideDeadline (gid, u.uid ()) ;
            else d.hideDeadline (gid, u.uid (), cmm) ;
            
            Object o [] = {Integer.toString (gid)} ;
            response.sendRedirect (j1.redirectURL (response,o)) ;
          }
          else {
           if (condGid && condRef && condBas && condPro) {
           	 Object o [] = { new Boolean (condOff).toString (),
           	                 new Boolean (condDue).toString (),
           	                 new Boolean (condCmm).toString (),
                             Integer.toString (gid)} ;
             response.sendRedirect (j3.redirectURL (response,o)) ;
           }
           else if (condGid) {
             Object o [] = { new Boolean (condGid).toString (),
                             new Boolean (condRef).toString (),
                             new Boolean (condBas).toString (),
                             new Boolean (condOff).toString (),
                             new Boolean (condDue).toString (),
                             new Boolean (condCmm).toString (),
                             new Boolean (condPro).toString (),
                             Integer.toString (gid)} ;
              response.sendRedirect (j5.redirectURL (response,o)) ;
            }
            else {
            	Object o [] = { new Boolean (condGid).toString ()} ;
              response.sendRedirect (j6.redirectURL (response,o)) ;
            }
          }
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
      }
    }
  }
}
