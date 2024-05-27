//
// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004
//

import java.io.IOException ;
import java.io.PrintWriter ;

import java.sql.Date ;

import javax.servlet.ServletConfig ;
import javax.servlet.ServletException ;
import javax.servlet.UnavailableException ;
import javax.servlet.http.HttpSession ;
import javax.servlet.http.HttpServletRequest ;
import javax.servlet.http.HttpServletResponse ;

import java.util.List ;
import java.util.LinkedList ;
import java.util.Map ;
import java.util.HashMap ;
import java.util.Locale ;
import java.util.Iterator ;
import java.util.Calendar ;
import java.util.Comparator ;
import java.util.TreeSet ;
import java.util.Properties ;
import java.util.ResourceBundle ;

import java.text.Format ;
import java.text.MessageFormat ;

import misc.Helper ;
import misc.Pair ;
import misc.Detail ;
import misc.Option ;
import misc.Ticket ;
import misc.Notification ;
import misc.Jump ;
import misc.AutoDeadline ;
import misc.AutoDeadline ;

import html.FormListPage ;

import dynamic.meta.Meta ;
import dynamic.inputchecker.InputChecker ;

import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;
import data.DataSourceException ;

final public class InsertServlet extends MyBasicHttpServlet {

  final static class Comparison implements Comparator {
    public int compare (Object a, Object b) {
      Date i = (Date) a ;
      Date j = (Date) b ;
      return i.before (j) ? -1 : (j.before (i) ? 1 : 0) ; 
    }
  }

  private final static String param_ddn = "ddn" ;			//
  private final static String param_mmn = "mmn" ;			//
  private final static String param_yyn = "yyyyn" ;		//
  private final static String param_key = "key" ;			//
  private final static String param_fil = "fil" ;			//
  private final static String param_typ = "typ" ;			//
  private final static String param_asd = "asd" ;			//
  private final static String param_sub = "sub" ;			//
  private final static String param_txt = "cmm" ;			//
  private final static String param_due = "1" ;				//
  private final static String param_wv1 = "2" ;				//
  private final static String param_wv2 = "3" ;				//
  private final static String param_wv3 = "4" ;				//
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//

  private final static String defaultcomment = "--" ;	//	Der Name sagt's schon.
  
  private Map p = new java.util.HashMap () ;
  private InputChecker c1 ;
  private ResourceBundle r1 ;
  private Properties y1 ;
  private Jump j1, j2, j3, j4, j5, j6, j7, j8 ;
  private Meta m1 ;
  private String major ;

  public void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      y1 = d.properties (major) ;
      p.put (new Integer (1), d.formListPage (def,"inserta")) ;
      p.put (new Integer (2), d.formListPage (def,"insertb")) ;
      p.put (new Integer (3), d.formListPage (def,"insertc")) ;
      p.put (new Integer (4), d.formListPage (def,"insertd")) ;
      p.put (new Integer (5), d.formListPage (def,"inserti")) ;
      j1 = d.jump (31) ;			// Frist erstellen gescheitert (kurze Liste)
      j2 = d.jump (32) ;			// Frist erstellen gescheitert (lange Liste)
      j3 = d.jump (27) ;			// Detail nach ID
      j4 = d.jump (101) ;			// 'Formulare zum Erstellen'-Menue
      j5 = d.jump (310) ;			// Fehler: Nicht angemeldet
      j6 = d.jump (312) ;			// Fehler: Keine Berechtigung
      j7 = d.jump (300) ;
      j8 = d.jump (302) ;
      c1 = (InputChecker) Class.forName (y1.getProperty ("inputchecker")).newInstance () ;
      m1 = (Meta) Class.forName (y1.getProperty ("meta")).newInstance () ;
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
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null) {
    	response.sendRedirect (j7.redirectURL (response, new Object [0])) ;
    }
    else if (! u.permissions ().permCrt ()) {
      response.sendRedirect (j8.redirectURL (response, new Object [0])) ;
    }
    else {

      try {
        int key = Integer.parseInt (request.getParameter (param_key)) ;
        int typ = 0, asd = 0 ;
        
        try {
        	typ = Integer.parseInt (request.getParameter (param_typ)) ;
        } catch (Exception e) {}
        try {
        	asd = Integer.parseInt (request.getParameter (param_asd)) ;
        } catch (Exception e) {}
        
        boolean dueOK = false, wv1OK = false, wv2OK = false, wv3OK = false ;
        Date due = null, wv1 = null, wv2 = null, wv3 = null ;
        try {
          due = misc.Helper.parseDate (request.getParameter (param_due)) ;
          dueOK = true ;
        } catch (Exception e) {}
        try {
          wv1 = misc.Helper.parseDate (request.getParameter (param_wv1)) ;
          wv1OK = true ;
        } catch (Exception e) {}
        try {
          wv2 = misc.Helper.parseDate (request.getParameter (param_wv2)) ;
          wv2OK = true ;
        } catch (Exception e) {}
        try {
          wv3 = misc.Helper.parseDate (request.getParameter (param_wv3)) ;
          wv3OK = true ;
        } catch (Exception e) {}
        
        DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter("schedule")) ;
        AutoDeadline ad = db.autoDeadline (key) ;
        Calendar c = Calendar.getInstance (def) ;
        
        Map m = new HashMap () ;
        m.put (param_ddn, Integer.toString(c.get (Calendar.DAY_OF_MONTH))) ;
        m.put (param_mmn, Integer.toString(c.get (Calendar.MONTH) + 1)) ;
        m.put (param_yyn, Integer.toString(c.get (Calendar.YEAR))) ;
        m.put (param_key, Integer.toString (key)) ;
        m.put (param_typ, new Pair (ad.types (), new Integer (typ))) ;
        m.put (param_asd, new Pair (ad.assign (), new Integer (asd))) ;
// Notlösung.
        m.put (param_fil, key == 5 ? "0" : request.getParameter (param_fil)) ;
        m.put (param_sub, request.getParameter (param_sub)) ;
        m.put (param_txt, request.getParameter (param_txt)) ;
        if (dueOK) {
        	Calendar c1 = Calendar.getInstance (def) ;
        	c1.setTime (due) ;
        	m.put (param_due, c1) ;
        }
        if (wv1OK) {
        	Calendar c1 = Calendar.getInstance (def) ;
        	c1.setTime (wv1) ;
        	m.put (param_wv1, c1) ;
        }
        if (wv2OK) {
        	Calendar c1 = Calendar.getInstance (def) ;
        	c1.setTime (wv2) ;
        	m.put (param_wv2, c1) ;
        }
        if (wv3OK) {
        	Calendar c1 = Calendar.getInstance (def) ;
        	c1.setTime (wv3) ;
        	m.put (param_wv3, c1) ;
        }
        {
          response.setContentType ("text/html") ;
          response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
          PrintWriter out = response.getWriter () ;
          out.println (((FormListPage) p.get (new Integer (key))).format (ad.label (), m)) ;
          out.close () ;
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null) {
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    }
    else if (! u.permissions ().permCrt ()) {
      response.sendRedirect (j6.redirectURL (response, new Object [0])) ;
    }
    else {
      try {

        boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

        if (cnl) {
        	response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
        }
        else {

          DataSourceSchedule ddb = new DataSourceSchedule (getInitParameter("schedule")) ;
          
          AutoDeadline ad = ddb.autoDeadline (Integer.parseInt (request.getParameter (param_key))) ;

          int typ = Integer.parseInt (request.getParameter (param_typ)) ;
          int asd = Integer.parseInt (request.getParameter (param_asd)) ;
          
          String txt = request.getParameter (param_txt) ;
          boolean txtOK = txt == null ? false : (txt.length () > 0 ? true : false) ;
          if (!txtOK) txt = defaultcomment ;

          Date tdy = Helper.parseDate (new Date (new java.util.Date ().getTime ()).toString ()) ;

          boolean typOK = false ;
          boolean asdOK = false ;
          
          for (Iterator i = ad.types () ; i.hasNext () ; typOK |= ((Option) i.next ()).key () == typ) ;
          for (Iterator i = ad.assign () ; i.hasNext () ; asdOK |= ((Option) i.next ()).key () == asd) ;
          
          String fil = request.getParameter (param_fil) ;
          String sub = request.getParameter (param_sub) ;

          boolean filOK = c1.isValidFileID (fil) ;
          boolean subOK = c1.isValidSubject (sub) ;

							// Bedeutung der logischen Werte bei 'true':
							// 'dueOK' - Das Fristende ist ein Tag nach dem Kalender

          boolean dueOK = false ;
          Date due = null ;

          try {
            due = parseDate (request, Integer.toString (1)) ;
            dueOK = tdy.before (due) ;
          } catch (Exception e) { dueOK = false ; }

          TreeSet set = new TreeSet (new Comparison ()) ;

							// Bedeutung der logischen Werte bei 'true':
							// 'notis' - Es sollten Wiedervorlagen aus dem Argumentstring geladen werden
							// 'noxOK' - Alle Wiedervorlagen sind an verschiendenen Tagen
							// 'norOK' - Alle Wiedervorlagen liegen vor dem Fristende (setzt 'dueOK' voraus) 

          boolean notis = false ;
          boolean noxOK = true ;
          boolean norOK = dueOK ;

							// Alle Wiedervorlagefristen werden aus dem
							// Argument geladen, und es wird jeweils
							// geprüft, ob die neu geladene Wiedervorlage
							// mit einer bereits erfassten zusammenfällt.

          try {
            int n = 1 ;
            for (Iterator i = ad.notis () ; i.hasNext () ; n ++ ) {
              notis = true ;
              i.next () ;
              noxOK &= set.add (parseDate (request, Integer.toString (n + 1))) ;
            }
          } catch (Exception e) { noxOK = false ; }

						// Falls das Fristenden ok ist, wird geprüft,
						// ob die späteste Wiedervorlage (Sortierung)
						// noch vor dem Fristende liegt: Wert 'norOK'.

          if (dueOK) norOK = set.isEmpty () ? noxOK : ((Date) set.last ()).before (due) && tdy.before ((Date) set.first ()) ;

          boolean allOK = typOK && asdOK && filOK && subOK && dueOK && noxOK && norOK ;

          if (allOK) {
            int id = ddb.insertDueEntry (due, asd, typ, fil, sub, u.uid (), txt, m1.compress (sub)) ;
            for (Iterator i = set.iterator () ; i.hasNext () ; ddb.insertNotificationEntry ((Date) i.next (), id)) ;
            Object [] r = {Integer.toString (id) } ;
            response.sendRedirect (j3.redirectURL (response, r)) ;
          }
          else {
						// Falls eine Fehlerbedingung erfüllt war.
        	
        	  if (!notis) {
        		
        		// Fehlerblatt, falls keine Wiedervorlagen gesendet wurden.
        		
        		  Object r [] = { new Boolean (dueOK).toString (),
                              new Boolean (filOK).toString (),
                              new Boolean (subOK).toString (),
                              new Boolean (typOK).toString (),
                              new Boolean (asdOK).toString (),
                              request.getParameter (param_key),
                              asdOK ? Integer.toString (asd) : "",
                              filOK ? fil : "",
                              subOK ? sub : "",
                              txtOK ? txt : "",
                              typOK ? Integer.toString (typ) : "",
                              dueOK ? due.toString () : ""} ;
        		
        		  response.sendRedirect (j1.redirectURL (response,r)) ;
        	  }
        	  else {
        		
        		// Fehlerblatt, falls Wiedervorlagen gesendet wurden.
        		
        		  Iterator i = set.iterator () ;
        		  
        		  Object r [] = { new Boolean (dueOK).toString (),
        		                  new Boolean (norOK).toString (),
        		                  new Boolean (noxOK).toString (),
                              new Boolean (filOK).toString (),
                              new Boolean (subOK).toString (),
                              new Boolean (typOK).toString (),
                              new Boolean (asdOK).toString (),
                              request.getParameter (param_key),
                              asdOK ? Integer.toString (asd) : "",
                              filOK ? fil : "",
                              subOK ? sub : "",
                              txtOK ? txt : "",
                              typOK ? Integer.toString (typ) : "",
                              dueOK ? due.toString () : "",
                              i.hasNext () ? ((Date) i.next ()).toString () : "",
                              i.hasNext () ? ((Date) i.next ()).toString () : "",
                              i.hasNext () ? ((Date) i.next ()).toString () : ""} ;
        		
        		  response.sendRedirect (j2.redirectURL (response,r)) ;
            }
          }
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }
}
