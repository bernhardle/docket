// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.List ;
import java.util.Iterator ;
//import java.util.ResourceBundle ;

import html.ListPage ;

import misc.Item ;
import misc.Ticket ;
import misc.Jump ;
import misc.Menue ;
import misc.Helper ;
import misc.Permissions ; 

import data.DataSourceException ;
import data.DataSourceLayout ;
import data.DataSourceConfiguration ;

final public class MenueServlet extends MyBasicHttpServlet {

  private String major ;
  private ListPage p1 ;
//  private ResourceBundle r1 ;

  protected void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      p1 = d.listPage (def, getInitParameter ("layout")) ;
//      r1 = d.resourceBundle (major) ;
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
    Permissions n = u == null ? new Permissions () : u.permissions () ;
    try {
    	Menue m = new DataSourceConfiguration (getInitParameter("config")).menue (major, n) ;
      List l = new java.util.LinkedList () ;
      for (Iterator i = m.items () ; i.hasNext () ; ) {
        Item p = (Item) i.next () ;
        Jump t = (Jump) p.jump () ;
        l.add (p1.iconTextRow (p.icon (), Helper.htmlConvert (p.label ()), t.get (response))) ;
      }
      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      PrintWriter out = response.getWriter () ;
      out.println (p1.format (l, m.title ())) ;
      out.close () ;
    }
    catch (Exception e) {
  	  response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ;
    }
  }
}
