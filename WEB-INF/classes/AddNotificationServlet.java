// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

import java.io.IOException ;
import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.ServletConfig ;
import javax.servlet.ServletException ;
import javax.servlet.UnavailableException ;
import javax.servlet.http.HttpSession ;
import javax.servlet.http.HttpServletRequest ;
import javax.servlet.http.HttpServletResponse ;

import java.sql.Date ;

import java.util.Map ;
import java.util.HashMap ;
import java.util.List ;
import java.util.Iterator ;
import java.util.Calendar ;
import java.util.ResourceBundle ;

import misc.Pair ;
import misc.Helper ;
import misc.Detail ;
import misc.Option ;
import misc.Ticket ;
import misc.Notification ;
import misc.Jump ;
import misc.JumpTarget ;

import data.DataSourceConfiguration ;
import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceException ;
import data.DataSourceScheduleRead ;

import html.FormListPage ;

final public class AddNotificationServlet extends MyBasicHttpServlet {

  private final static String form1 = "addnotification" ;
  private final static String param_ddn = "ddn" ;			//	Akt. Tag
  private final static String param_mmn = "mmn" ;			//	Akt. Monat
  private final static String param_yyn = "yyyyn" ;		//	Akt. Jahr
  private final static String param_ddx = "ddx" ;			//	Fristende, Tag
  private final static String param_mmx = "mmx" ;			//	Fristende, Monat
  private final static String param_yyx = "yyyyx" ;		//	Fristende, Jahr
  private final static String param__id = "id" ;			//	Frist, ID
  private final static String param_dte = "1" ;				//	Postfix Datumeingabe
  private final static String param_det = "det" ;			//	Detail-Pseudo-Input
  private final static String param_txt = "cmm" ;			//	Kommentar
  private final static String param_bck = "back" ;		//	Rücksprung
  private final static String param_cnl = "cancel" ;	//	Parameter zum Abbruch
  private final static String param__ok = "go" ;			//	Unbenutzt
  
  private ResourceBundle r1 ;
  private FormListPage p1 ;
  private String major ;
  private Jump /* j1,*/ j3, j4, j5, j6 ;
  private String s1 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.formListPage (def, form1) ;
//      j1 = d.jump (36) ;								// Detail nach ID mit Rücksprung
      j3 = d.jump (48) ;								// WV erstellen gescheitert (lange Liste)
      j4 = d.jump (49) ;								// WV erstellen gescheitert (kurze Liste)
      j5 = d.jump (310) ;
      j6 = d.jump (312) ;
      s1 = r1.getString ("caption") ;
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
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permCrt ()) {
    	response.sendRedirect (j6.redirectURL (response, new Object [0])) ;
    }
    else {
      try {

        int id = Integer.parseInt (request.getParameter (param__id)) ;
        String cmm = request.getParameter (param_txt) ;
        
        Detail d = new DataSourceScheduleRead (getInitParameter("schedule")).detail (id) ;
        
        Map m = new HashMap () ;
        m.put (param__id, Integer.toString (id)) ;
        Calendar c = Calendar.getInstance (def) ;
        m.put (param_ddn, Integer.toString(c.get (Calendar.DAY_OF_MONTH))) ;
        m.put (param_mmn, Integer.toString(c.get (Calendar.MONTH) + 1)) ;
        m.put (param_yyn, Integer.toString(c.get (Calendar.YEAR))) ;
        m.put (param_dte, c.clone ()) ;
        c.setTime (d.date ()) ;
        m.put (param_ddx, Integer.toString(c.get (Calendar.DAY_OF_MONTH))) ;
        m.put (param_mmx, Integer.toString(c.get (Calendar.MONTH) + 1)) ;
        m.put (param_yyx, Integer.toString(c.get (Calendar.YEAR))) ;
        m.put (param_det, d) ;
        m.put (param_bck, request.getParameter (param_bck)) ;
        if (cmm != null) m.put (param_txt, cmm) ;
        
        response.setContentType ("text/html") ;
        response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
        PrintWriter out = response.getWriter () ;
        out.println (p1.format (s1, m)) ;
        out.close () ;
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
      }
    }
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null) {
    	response.sendRedirect (j5.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permCrt ()) {
    	response.sendRedirect (j6.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
      	  
        boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;
        int id = Integer.parseInt (request.getParameter (param__id)) ;
        Jump jb = new DataSourceConfiguration (getInitParameter("config")).jump (Integer.parseInt (request.getParameter (param_bck))) ;
        
        if (cnl) {
        	Object r [] = {Integer.toString (id)} ;
          response.sendRedirect (jb.redirectURL (response, r)) ;
        }
        else {
        	
          Date tdy = misc.Helper.parseDate (new Date (new java.util.Date ().getTime ()).toString ()) ;

          DataSourceSchedule ddb = new DataSourceSchedule (getInitParameter("schedule")) ;

          String cmm = request.getParameter (param_txt) ;

          Detail det = ddb.detail (id) ;
          Date due = det.date () ;
          List ntf = ddb.notificationList (det) ;
          
          boolean maxOK = det.type().maxn () > ntf.size () ;
          boolean aaaOK = true ;
          boolean dueOK = true ;
          boolean tdyOK = true ;
          boolean dstOK = true ;
          boolean cmmOK = cmm == null ? true : cmm.length () <= maxCmmLen ;
          
          Date no = null ;
          
          try {
            no = parseDate (request, param_dte) ;
            tdyOK &= tdy.before (no) ;
            dueOK &= no.before (due) ;
            for (Iterator i = ntf.iterator () ; i.hasNext () ; dstOK &= (0 != no.compareTo (((Notification) i.next ()).due ()))) ;
          }
          catch (Exception e) {
          	aaaOK = false ;
          	dueOK = false ;
          	tdyOK = false ;
          	dstOK = false ;
          }

          boolean allOK = aaaOK && dueOK && maxOK && dstOK && tdyOK && cmmOK ;

          if (allOK) {
            ddb.insertNotificationEntry (no, id, u.uid (), cmm) ;
            Object r [] = {Integer.toString (id)} ;
            response.sendRedirect (jb.redirectURL (response, r)) ;
          } 
          else {

            if (aaaOK) {
              Object [] r = {Boolean.toString (aaaOK),
                             Boolean.toString (cmmOK),
                             Boolean.toString (dueOK),
                             Boolean.toString (tdyOK),
                             Boolean.toString (dstOK),
                             Boolean.toString (maxOK),
                             Integer.toString (id),
                             request.getParameter (param_bck)} ;
              response.sendRedirect (j3.redirectURL (response, r)) ;
            }
            else {
          	  Object [] r = {Boolean.toString (aaaOK),
          	                 Boolean.toString (cmmOK),
                             Boolean.toString (maxOK),
                             Integer.toString (id),
                             request.getParameter (param_bck)} ;
              response.sendRedirect (j4.redirectURL (response, r)) ;
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

