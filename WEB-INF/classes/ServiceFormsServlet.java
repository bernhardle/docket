// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

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
import java.util.List ;
import java.util.Calendar ;
import java.util.ResourceBundle ;

import java.text.MessageFormat ;

import html.FormListPage ;

import misc.Pair ;
import misc.Detail ;
import misc.Ticket ;
import misc.Option ;

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceScheduleRead ;

final public class ServiceFormsServlet extends MyBasicHttpServlet {

  private MessageFormat f1 ; 
  private String major ;
  private ResourceBundle r1 ;
  private FormListPage p1 ;
  private Object [] r0 = new Object [0] ;
  
  private String workloadForm (DataSourceScheduleRead d, Ticket u) throws DataSourceException {
    Calendar c1 = Calendar.getInstance (def) ;
    Calendar c2 = Calendar.getInstance (def) ;
    c2.add (Calendar.MONTH, 1) ;
    Map g = new java.util.HashMap () ;
    g.put ("1", c1) ;
    g.put ("2", c2) ;
    g.put ("asd", new Pair (d.loginNameList (false,false,true).iterator (), new Integer (u.uid()))) ;
    return p1.format (f1.format (r0), g) ;	
  }

  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.formListPage (def,getInitParameter ("layout.workload")) ; 
      f1 = new MessageFormat (r1.getString ("caption.workload")) ;
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

    if (u != null) {
    
      try {
      	
      	int key = Integer.parseInt (request.getParameter ("key")) ;
      	
      	switch (key) {
      		case 1:
      		  {
              response.setContentType ("text/html") ;
              PrintWriter out = response.getWriter () ;
              out.println (workloadForm (new DataSourceScheduleRead (getInitParameter("schedule")), u)) ;
              out.close () ;
            }
            break ;
          default :
           	response.sendError (HttpServletResponse.SC_BAD_REQUEST) ;
           	break ;
        }
      }
      catch (Exception e) {
      	response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass () + " " + e.getMessage ()) ;
      }
    }
    else {
    	response.sendError (HttpServletResponse.SC_FORBIDDEN) ;
    }
  }
}