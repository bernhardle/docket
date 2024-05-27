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
import java.util.Iterator ;
import java.util.ResourceBundle ;

import misc.Detail ;
import misc.Ticket ;
import misc.Jump ;
import misc.Helper ;

import html.FormListPage ;

import data.DataSourceForm ;
import data.DataSourceSchedule ;
import data.DataSourceScheduleRead ;
import data.DataSourceException ;

final public class AddCommentServlet extends MyBasicHttpServlet {

  private final static String form1 = "addcomment" ;
  private final static String param__id = "id" ;			//	Frist, ID
  private final static String param_det = "detail" ;	//	Detail-Pseudo-Input
  private final static String param_key = "key" ;			//
  private final static String param_txt = "cmm" ;			//	Kommentar
  private final static String param_bck = "back" ;		//	Rücksprung
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//

  private ResourceBundle r1 ;
  private FormListPage p2 ;
  private String major, s1, s2 ;
  private Jump j1, j2, j3, j4 ;

  public void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p2 = d.formListPage (def, form1) ;
      j1 = d.jump (36) ;							// Detail nach ID mit Rücksprung
      j2 = d.jump (63) ;							// Fehlerblatt
      j3 = d.jump (310) ;
      j4 = d.jump (312) ;
      s1 = r1.getString ("errmsg1") ;
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

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null) {
    	response.sendRedirect (j3.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permCrt ()) {
    	response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
      	
        int i = Integer.parseInt (request.getParameter (param__id)) ;
        String cmm = request.getParameter (param_txt) ;
        
        Map m = new HashMap () ;
        m.put (param__id, Integer.toString (i)) ;
        m.put (param_bck, request.getParameter (param_bck)) ;
        m.put (param_det, new DataSourceScheduleRead (getInitParameter("schedule")).detail (i)) ;
        if (cmm != null) m.put (param_txt, cmm) ;
        
        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;
        out.println (p2.format (s2, m)) ;
        out.close () ;
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
    	response.sendRedirect (j3.redirectURL (response, new Object [0])) ;
    }
    else if (!u.permissions ().permCrt ()) {
    	response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
    }
    else {
      try {
      	
        DataSourceSchedule ddb = new DataSourceSchedule (getInitParameter("schedule")) ;

        int id = Integer.parseInt (request.getParameter (param__id)) ;
        String cmm = request.getParameter (param_txt) ;
        
// Eingabe prüfen:
        
        boolean condNul = cmm == null ? false : cmm.length () != 0 ;
        boolean condCmm = cmm == null ? true : cmm.length () <= maxCmmLen ;
        boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;
        
        if (cnl) {
          Object r [] = {Integer.toString (id),
                         request.getParameter (param_bck)} ;
          response.sendRedirect (j1.redirectURL(response, r)) ;
        }
        else {
        	
          if (condNul && condCmm) {
            ddb.insertEventComment (id, u.uid (), cmm) ;
            Object r [] = {Integer.toString (id),
                           request.getParameter (param_bck)} ;
            response.sendRedirect (j1.redirectURL(response, r)) ;
          }
          else {
//
// Fehler im Kommentar aber die 'id' ist bekannt, deshalb das
// das Fehlerblatt anzeigen und von dort den Sprung in dieses
// Formular eröffnen zum Nachbessern ...
//
            Object [] r = {Boolean.toString (condNul),
                           Boolean.toString (condCmm),
            	             Integer.toString (id),
            	             request.getParameter (param_bck),
            	             cmm == null ? "" : cmm} ;
            response.sendRedirect (j2.redirectURL(response, r)) ;	
          }
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }
}
