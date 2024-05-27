// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.IOException ;
import java.io.PrintWriter ;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.List ;
import java.util.Iterator ;
import java.util.Locale ;
import java.util.ResourceBundle ;

import misc.Jump ;
import misc.Ticket ;
import misc.ConnectionInfo ;

import html.ListPage ;
import html.text.ConnectionInfoFormat ;

import data.DataSourceLayout ;
import data.ConnectionHandler ;

final public class ConnectionInfoServlet extends MyBasicHttpServlet {

  private String major ;
  private ResourceBundle r1 ;
  private ListPage p1 ;
  private Jump j1 ;

  protected void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.listPage (def, major) ;
      j1 = d.jump (300) ;
    }
    catch (Exception e) { throw new UnavailableException (e.getMessage ()) ; }
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    major = getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;
    
    if (u == null ? true : ! u.permissions ().permLgn ()) {
    	response.sendRedirect (j1.redirectURL (response,new Object [0])) ;
    }
    else {

      System.gc () ;

      List l = new java.util.LinkedList () ;

      for (Iterator i = ConnectionHandler.listOpenConnections ().iterator () ; i.hasNext () ; l.add (p1.iconConInfoRow ("database",(ConnectionInfo) i.next ()))) ;

      if (l.size () == 0) l.add (p1.textRow (r1.getString ("messageLoc"))) ;

      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      PrintWriter out = response.getWriter () ;
      out.println (p1.format (l,r1.getString ("captionLoc"))) ;
      out.close () ;
    }
  }
}