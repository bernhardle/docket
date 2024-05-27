// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

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
import java.util.ResourceBundle ;

import html.FormListPage ;

import data.DataSourceForm ;
import data.DataSourceLayout ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;

import misc.Helper ;
import misc.Ticket ;
import misc.Jump ;
import misc.DType ;

final public class AddTypeServlet extends MyBasicHttpServlet {

  private final static String form1 = "addtype" ;			// 
  private final static String form2 = "modtype" ;			// 
  
  private final static String param_ini = "init" ;		//
  private final static String param_mni = "mini" ; 		// Minilabel in der Übersicht
  private final static String param_lbl = "long" ;		// Label in den Formularen
  private final static String param_dsc = "desc" ;		// Bescreibung
  private final static String param_mxn = "maxn" ;		// Max. Anzahl WV
  private final static String param_mxc = "maxc" ;		// Max. Anzahl Kommentare
  private final static String param_rnk = "rank" ;		// Rang (alle Integer)
  private final static String param_tid = "tid" ;			// Type-ID (bei Neuerstellen -1)
  private final static String param_cxt = "cxt" ;			// Kontext-ID
  private final static String param_col = "col" ;			// Farbe-ID
  private final static String param_aty = "auto" ;		// Zu allen Formularen hinzufügen
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//
  private final static String value__on = "ON" ;
  private final static String value_off = "OFF" ;

  private String major, s1, s2 ;
  private FormListPage p1, p2 ;
  private ResourceBundle r1 ;
  private Jump j1, j2, j3, j4, j5, j6, j7, j8, j9 ;
  private List l1 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.formListPage (def, form1) ;
      p2 = d.formListPage (def, form2) ;
      j1 = d.jump (150) ;										// Zurück ins Statische Daten-Menue
      j2 = d.jump (85) ;										// Erstellen erfolgreich abgeschlossen
      j7 = d.jump (94) ;										// Bearbeiten erfolgreich abgeschlossen
      j3 = d.jump (86) ;										// Neu: Fehlerblatt alles außer Dublette
      j4 = d.jump (87) ;										// Neu: Fehlerblatt nur Dublette
      j8 = d.jump (95) ;										// Bearb.: Fehlerblatt alles außer Dublette
      j9 = d.jump (96) ;										// Bearb.: Fehlerblatt nur Dublette
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
    	
      int col = 0, cxt = 0, mxc = 0, mxn = 0, rnk = 0, tid = -1 ;
      
      boolean condCol = true ;
      boolean condCxt = true ;
      boolean condMxc = true ;
      boolean condMxn = true ;
      boolean condRnk = true ;
      boolean condTid = true ;
      
    	try {
    		col = Integer.parseInt (request.getParameter (param_col)) ;
    	} catch (Exception e) { condCol = false ; }
    	try {
    		cxt = Integer.parseInt (request.getParameter (param_cxt)) ;
    	} catch (Exception e) { condCxt = false ; }
    	try {
    		mxc = Integer.parseInt (request.getParameter (param_mxc)) ;
    	} catch (Exception e) { condMxc = false ; }
    	try {
    		mxn = Integer.parseInt (request.getParameter (param_mxn)) ;
    	} catch (Exception e) { condMxn = false ; }
    	try {
    		rnk = Integer.parseInt (request.getParameter (param_rnk)) ;
    	} catch (Exception e) { condRnk = false ; }
    	try {
    		tid = Integer.parseInt (request.getParameter (param_tid)) ;
    	} catch (Exception e) { condTid = false ; }
    	
    	String dsc = request.getParameter (param_dsc) ;
    	String lbl = request.getParameter (param_lbl) ;
    	String mni = request.getParameter (param_mni) ;
    	
    	boolean ini = Boolean.valueOf (request.getParameter (param_ini)).booleanValue () ;
    	boolean aty = Boolean.valueOf (request.getParameter (param_aty)).booleanValue () ;
    	
      try {
      	DataSourceScheduleRead sdb = new DataSourceScheduleRead (getInitParameter ("schedule")) ;
      	DataSourceLayout cdb = new DataSourceLayout (getInitParameter ("config")) ;
      	
      	Iterator in1 = sdb.contextList ().iterator () ;
      	Iterator in2 = cdb.colors ().iterator () ;
      	
      	Map m = new java.util.HashMap () ;
      	m.put (param_tid, Integer.toString (tid)) ;
      	
      	if (ini) {
      		if (!condTid) {
      			throw new IllegalArgumentException ("FATAL: ID missing") ;
      		}
      	  DType typ = sdb.dType (tid) ;
      	  m.put (param_mni, typ.mini ()) ;
      	  m.put (param_lbl, typ.label ()) ;
      	  m.put (param_dsc, typ.description ()) ;
      	  m.put (param_mxn, Integer.toString (typ.maxn())) ;
      	  m.put (param_mxc, Integer.toString (typ.maxc ())) ;
      	  m.put (param_rnk, Integer.toString (typ.rank ())) ;
      	  m.put (param_cxt, new misc.Pair (in1, new Integer (typ.context ().id ()))) ;
      	  m.put (param_col, new misc.Pair (in2, new Integer (typ.colorID ()))) ;
      	}
        else {
          m.put (param_cxt, new misc.Pair (in1, new Integer (condCxt ? cxt : 0))) ;
          m.put (param_col, new misc.Pair (in2, new Integer (condCol ? col : 0))) ;
          if (condMxc) m.put (param_mxc, Integer.toString (mxc)) ;
          if (condMxn) m.put (param_mxn, Integer.toString (mxn)) ;
          if (condRnk) m.put (param_rnk, Integer.toString (rnk)) ;
          if (dsc != null) m.put (param_dsc, dsc) ;
          if (lbl != null) m.put (param_lbl, lbl) ;
          if (mni != null) m.put (param_mni, mni) ;
        }
        {       
          String c = (tid == -1) ? s1 : s2 ;
          FormListPage p = (tid == -1) ? p1 : p2 ;
          
          response.setContentType ("text/html") ;
          PrintWriter out = response.getWriter () ;      
          out.println (p.format (c, m)) ;
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

      try {
      	if (cnl) {
          response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
      	}
      	else {
      		
      		int cxt = Integer.parseInt (request.getParameter (param_cxt)) ;
      		int col = Integer.parseInt (request.getParameter (param_col)) ;
     	    int tid = Integer.parseInt (request.getParameter (param_tid)) ;
     	    
      	  boolean condMxc = true ;
      	  boolean condMxn = true ;
      		boolean condRnk = true ;
      		
      		int mxc = 0, mxn = 0, rnk = 0 ;
      		
      		try {
      			mxc = Integer.parseInt (request.getParameter (param_mxc)) ;
      			condMxc = ! (mxc < 0) ;
      		} catch (Exception e) { condMxc = false ; }
      		try {
      		  mxn = Integer.parseInt (request.getParameter (param_mxn)) ;
      		  condMxn = ! (mxn < 0) ;
      		} catch (Exception e) { condMxn = false ; }
      		try {
      		  rnk = Integer.parseInt (request.getParameter (param_rnk)) ;
      		} catch (Exception e) { condRnk = false ; }
      		
      		String mni = request.getParameter (param_mni) ;
      		String lbl = request.getParameter (param_lbl) ;
      		String dsc = request.getParameter (param_dsc) ;
 
   		   	String s = request.getParameter (param_aty) ;
          boolean aty = s == null ? false : s.compareTo (value__on) == 0 ;
          
      		boolean condCxt = cxt > 0 ;
      		boolean condCol = col > 0 ;
      		boolean condNul = (mni != null ? mni.length () != 0 : false) && (lbl != null ? lbl.length () != 0 : false) && (dsc != null ? dsc.length () != 0 : false) ; // ? false : mni.length () > 0 ;
      		boolean condCst = Helper.isValidMinilabel (mni) && Helper.isValidLabel (lbl) && Helper.isValidDescription (dsc) ;
      		
      		boolean allOK = condCol && condCst && condCxt && condMxc && condMxn && condNul && condRnk ;

      		if (allOK) {
      			
      			DataSourceSchedule sdb = new DataSourceSchedule (getInitParameter ("schedule")) ;
      			DataSourceLayout cdb = new DataSourceLayout (getInitParameter("config")) ;
      			
      		  int ret = 0 ;
      		  
      			if (tid > -1) {
      				ret = sdb.modType (tid, mni, lbl, rnk, col, mxn, mxc, cxt, dsc, aty) ;
      				if (ret != -1) {
      			  	int erg = cdb.updateLayoutStyle (col) ;
      			  	
      				}
      			}
      			else {
      			  ret = sdb.addType (mni, lbl, rnk, col, mxn, mxc, cxt, dsc, aty) ;
      			  if (ret != -1) {
      			  	int erg = cdb.updateLayoutStyle (col) ;
      			  	
      			  }
      		  }
      		  
      		  Jump ja = tid > -1 ? j7 : j2 ;
      		  Jump jb = tid > -1 ? j9 : j4 ;
      		  
      		  if (ret != -1) {
      		  	response.sendRedirect (ja.redirectURL (response, new Object [0])) ;
      		  }
      		  else {
      		    Object [] o = {Integer.toString (col),
          	                 Integer.toString (cxt),
          	                 dsc,
          	                 lbl,
          	                 mni,
          	                 Integer.toString (mxc),
          	                 Integer.toString (mxn),
          	                 Integer.toString (rnk),
          	                 Integer.toString (tid)} ;
      		  	response.sendRedirect (jb.redirectURL (response, o)) ;
      		  }
          }
          else {
          	Jump jc = tid > -1 ? j8 : j3 ;
          	
          	Object [] o = {Boolean.toString (condCol),
          	               Boolean.toString (condCst),
          	               Boolean.toString (condCxt),
          	               Boolean.toString (condMxc),
          	               Boolean.toString (condMxn),
          	               Boolean.toString (condNul),
          	               Boolean.toString (condRnk),
          	               Integer.toString (col),
          	               Integer.toString (cxt),
          	               dsc != null ? dsc : "",
          	               lbl != null ? lbl : "",
          	               mni != null ? mni : "",
          	               condMxc ? Integer.toString (mxc) : "",
          	               condMxn ? Integer.toString (mxn) : "",
          	               condRnk ? Integer.toString (rnk) : "",
          	               Integer.toString (tid)
          	               } ;
            response.sendRedirect (jc.redirectURL (response, o)) ;
          }
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }
}
