// (c) Bernhard Schupp; Frankfurt-M�nchen; 2001-2003

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
import java.util.Properties ;
import java.util.ResourceBundle ;

import html.FormListPage ;

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceScheduleRead ;

import misc.Helper ;
import misc.Pair ;
import misc.Ticket ;
import misc.Jump ;

final public class ShowUserServlet extends MyBasicHttpServlet {
	
  private final static String param_lgn = "lgn" ;			// Parameter mit der uid
  private final static String param_bns = "label3" ;	// Bezeichnung der Buttons im Formular
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			//

  private String major ;
  private String s1, s2 ;
  private FormListPage p1 ;
  private Properties y1 ;
  private ResourceBundle r1 ;
  private Jump j1, j2, j3, j4, j5 ;

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      y1 = d.properties (major) ;
      p1 = d.formListPage (def, y1.getProperty ("form")) ;
      s2 = r1.getString ("caption") ;
      j1 = d.jump (Integer.parseInt (y1.getProperty ("forward"))) ;	
      j2 = d.jump (Integer.parseInt (y1.getProperty ("back"))) ;	
      j3 = d.jump (Integer.parseInt (y1.getProperty ("error"))) ;
      j4 = d.jump (310) ;
      j5 = d.jump (311) ;
    }
    catch (Exception e) {
    	throw new UnavailableException (e.getClass () + " " + e.getMessage ()) ;
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
    	response.sendRedirect (j4.redirectURL (response,new Object [0])) ;
    } else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j5.redirectURL (response,new Object [0])) ;
    }
    else {
      try {
        Map m = new HashMap () ;
        m.put (param_bns, s1) ;
        m.put (param_lgn, new Pair (new DataSourceScheduleRead (getInitParameter("schedule")).loginNameList (false,true,true).iterator (), new Integer (0))) ;
        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;      
        out.println (p1.format (s2, m)) ;
        out.close () ;
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ;
      }
    }
  }

  public void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    if (u == null) {
    	response.sendRedirect (j4.redirectURL (response,new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j5.redirectURL (response,new Object [0])) ;
    } 
    else {
      
      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      try {
      	if (cnl) {
          response.sendRedirect (j2.redirectURL (response,new Object [0])) ;
      	}
      	else {
          int uid = Integer.parseInt (request.getParameter (param_lgn)) ;
          if (uid == 0) {
            response.sendRedirect (j3.redirectURL (response,new Object [0])) ;
          }
          else {
            Object [] o = {Integer.toString (uid)} ;
            response.sendRedirect (j1.redirectURL (response,o)) ;
          }
        }
      }
      catch (Exception e) {
        response.sendError (HttpServletResponse.SC_BAD_REQUEST, e.getClass ().getName () + " " + e.getMessage ()) ;
      }
    }
  }
}
