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
import java.util.ResourceBundle ;

import html.BodyPage ;
import html.FormListPage ;
import html.text.TableFormat ;

import misc.Pair ;
import misc.Jump ;
import misc.Ticket ;
import misc.Option ;

import data.DataSourceBase ;
import data.DataSourceForm ;
import data.DataSourceException ;

final public class SQLServlet extends MyBasicHttpServlet {

	private final static String form1 = "sql" ;					// Formularschlüssel
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			// 
  private final static String param_sql = "sql" ;			// SQL Statement
  private final static String param_dbe = "dbe" ;			// Datenbank

  private String major ;
  private String m1 ;
  private TableFormat f1 ;
  private BodyPage p1 ;
  private FormListPage p3 ;
  private Jump j1, j2, j3 ;
  private ResourceBundle r1 ;
  
  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      f1 = new TableFormat () ;
      p3 = d.formListPage (def, form1) ;
      p1 = d.bodyPage (def, "default") ;
      m1 = r1.getString ("errmsg1") ;
      j1 = d.jump (51) ;									// Zurück ins Menue
      j2 = d.jump (300) ;
      j3 = d.jump (301) ;
    }
    catch (Exception e) {
      throw new UnavailableException (e.getClass ().getName () + e.getMessage ()) ;
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
    	response.sendRedirect (j2.redirectURL (response,new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j3.redirectURL (response,new Object [0])) ;
    }
    else {
      try {
      	
  	    Map m = new java.util.HashMap () ;
        List l = new java.util.LinkedList () ;
        l.add (new Option (1, "Termindaten")) ;
        l.add (new Option (2, "Einstellungen")) ;
        m.put (param_dbe, new Pair (l.iterator (),new Integer (0))) ;
        m.put (param_sql, "SELECT;") ;

        response.setContentType ("text/html") ;
        PrintWriter out = response.getWriter () ;      
        out.println (p3.format (r1.getString ("caption.1"), m)) ;
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
    	response.sendRedirect (j2.redirectURL (response,new Object [0])) ;
    }
    else if (! u.permissions ().permAdm ()) {
    	response.sendRedirect (j3.redirectURL (response,new Object [0])) ;
    }
    else {

      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      if (cnl) {
        response.sendRedirect (j1.redirectURL (response, new Object [0])) ;
      }
      else {
      
        String q = request.getParameter (param_sql) ;
        String n = request.getParameter (param_dbe) ;
      
        if ((q == null ? false : (q.length () == 0 ? false : true)) && (n == null ? false : (n.length () == 0 ? false : getInitParameter (n) != null))) {
        
      	  response.setContentType ("text/html") ;
          PrintWriter out = response.getWriter () ;
          try {
        		out.println (p1.format (f1.format (new DataSourceBase (getInitParameter (n)).executeSQL (q)), r1.getString ("caption.2"))) ;
         	}
          catch (DataSourceException e) {
            out.println (p1.format (e.getMessage (), "Datenbankfehlermeldung")) ;
          }
          catch (Exception e) {
            response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
          }
          finally {
          	out.close () ;
          }
        }
        else {
        	response.sendError (HttpServletResponse.SC_BAD_REQUEST) ; 
        }
      }
    }
  }
}