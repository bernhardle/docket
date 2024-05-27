// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

import java.io.IOException ;
import java.io.PrintWriter ;
import javax.servlet.ServletConfig ;
import javax.servlet.ServletException ;
import javax.servlet.UnavailableException ;
import javax.servlet.http.HttpServletRequest ;
import javax.servlet.http.HttpServletResponse ;

import java.util.List ;
import java.util.Iterator ;
import java.util.LinkedList ;
import java.util.ResourceBundle ;
import java.util.StringTokenizer ;

import html.ListPage ;
import html.text.DetailFormat ;

import misc.Pair ;
import misc.Jump ;
import misc.Detail ;
import misc.JumpTarget ;
import misc.ObjectWrapper ;

import data.DataSourceException ;
import data.DataSourceLayout ;
import data.DataSourceScheduleRead ;
import data.DataSourceConfiguration ;

final public class ListServlet extends MyBasicHttpServlet {

  final private String a1 = "ids", a2 = "prv", a3 = "nxt", a4 = "tst" ;

  private ResourceBundle r1 ;
  private ListPage p1 ;
  private int max, i1 ;
  private String major ;
  private Jump j1 ;
  private String s1, s2 ;

  protected void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.listPage (def,getInitParameter("layout")) ;
      j1 = d.jump (Integer.parseInt (getInitParameter("url.1"))) ;	// 36: Detail Ansicht mit Rückweg
      s1 = r1.getString ("prevLoc") ;
      s2 = r1.getString ("nextLoc") ;
      i1 = Integer.parseInt (getInitParameter("url.2")) ;						// 43: Selbstlink
    }
    catch (Exception e) {
      throw new UnavailableException (e.toString () + e.getMessage ()) ;
    }
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    major = getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    try {

      List ids = new LinkedList () ;
      for (StringTokenizer s = new StringTokenizer (request.getParameter (a1), ",") ; s.hasMoreTokens() ; ids.add (new Integer (s.nextToken ()))) ;
      
      List prv = new LinkedList () ;
      for (StringTokenizer s = new StringTokenizer (request.getParameter (a2), ",") ; s.hasMoreTokens() ; prv.add (s.nextToken ())) ;
    
      List nxt = new LinkedList () ;
      for (StringTokenizer s = new StringTokenizer (request.getParameter (a3), ",") ; s.hasMoreTokens() ; nxt.add (s.nextToken ())) ;

      String tst [] = (String []) ObjectWrapper.fromString (request.getParameter (a4)).getObject () ;

      DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter("schedule")) ;
      DataSourceConfiguration dc = new DataSourceConfiguration (getInitParameter("config")) ;
      
      List l = new LinkedList () ;

      l.add (p1.textRow (tst [1])) ;

      if (prv.size () > 0) {
      	Iterator i = prv.iterator () ;
      	int j = Integer.parseInt ((String) i.next ()) ;
      	Object r [] = new Object [prv.size () - 1] ;
      	for (int k = 0 ; i.hasNext () ; r [k ++] = i.next ()) ;
      	JumpTarget lnk = dc.jump (j).get (response, r) ;
        l.add (p1.iconTextRow ("list.prev",lnk.wrap (s1),lnk)) ;
      }

      for (Iterator i = ids.iterator () ; i.hasNext () ; ) {
      	
        Detail det = db.detail (((Integer)i.next ()).intValue ()) ;

        Object x [] = {request.getParameter (a1),
                       request.getParameter (a2),
                       request.getParameter (a3),
                       request.getParameter (a4)} ;

        Object r [] = {Integer.toString (det.id ()),
                       new ObjectWrapper (new Pair (new Integer (i1), x))} ;
                        
        l.add (p1.iconDetailRow (det.done () ? "list.hitdone" : "list.hit", det, j1.get (response, r))) ;
      }

      if (nxt.size () > 0) {
       	Iterator i = nxt.iterator () ;
      	int j = Integer.parseInt ((String) i.next ()) ;
      	Object r [] = new Object [nxt.size () - 1] ;
      	for (int k = 0 ; i.hasNext () ; r [k ++] = i.next ()) ;
      	JumpTarget lnk = dc.jump (j).get (response, r) ;
        l.add (p1.iconTextRow ("list.next",lnk.wrap (s2),lnk)) ;
      }

      response.setContentType ("text/html") ;
      PrintWriter out = response.getWriter () ;
      out.println (p1.format (l, tst [0])) ;
      out.close () ;
    }
    catch (IllegalArgumentException e) {
      response.sendError (HttpServletResponse.SC_BAD_REQUEST) ; 
    }
    catch (Exception e) { 
      response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
    }
  }
}
