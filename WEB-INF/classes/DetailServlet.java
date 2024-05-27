// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

import java.io.IOException ;
import java.io.PrintWriter ;
import javax.servlet.ServletConfig ;
import javax.servlet.ServletException ;
import javax.servlet.UnavailableException ;
import javax.servlet.http.HttpSession ;
import javax.servlet.http.HttpServletRequest ;
import javax.servlet.http.HttpServletResponse ;

import java.sql.Date ;

import java.util.List ;
import java.util.Locale ;
import java.util.Iterator ;
import java.util.Properties ;
import java.util.ResourceBundle ;

import java.text.DateFormat ;

import misc.Pair ;
import misc.Jump ;
import misc.Image ;
import misc.Ticket ;
import misc.Event ;
import misc.Detail ;
import misc.JumpTarget ;
import misc.ObjectWrapper ;
import misc.Notification ;

import html.BodyPage ;
import html.text.IconHook ;
import html.text.EventFormat ;
import html.text.DetailFormat ;

import data.DataSourceException ;
import data.DataSourceLayout ;
import data.DataSourceScheduleRead ;
import data.DataSourceConfiguration ;

final public class DetailServlet extends MyBasicHttpServlet {

  private final static String param__id = "id" ;			//	Frist, ID
  private final static String param_bck = "back" ;		//	Rücksprung

  private DateFormat f2 = DateFormat.getDateInstance (DateFormat.LONG) ;
  private DateFormat f3 = DateFormat.getDateInstance (DateFormat.FULL) ;
  private DateFormat f4 = DateFormat.getDateTimeInstance (DateFormat.LONG, DateFormat.MEDIUM) ;
  private DetailFormat f1 = DetailFormat.getInstance (DetailFormat.LONG) ;
  private Image m1 ;
  private IconHook h1, h2, h3 ;
  private BodyPage p1 ;
  private ResourceBundle r1 ;
  private Properties x1 ;
  private String major, s1, s2 ;
  private Jump j1, j2, j4 ;
  private final int max1 = 65 ;
  private String [] inm = {"", "eventlog.void", "eventlog.newd", "eventlog.newn", "eventlog.deld", "eventlog.deln", "eventlog.newc" } ;

  protected void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      x1 = d.properties (major) ;
      m1 = d.image (128) ;
      p1 = d.bodyPage (def,getInitParameter("layout")) ;
      h1 = p1.iiconHook ("detail.noti") ;
      h2 = p1.iiconHook ("detail.blank") ;
      h3 = p1.iiconHook ("detail.file") ;
      j1 = d.jump (44) ;		// Übersicht mit Highlight nach ID
      j2 = d.jump (45) ;		// Formular Kommentar hinzufügen
      j4 = d.jump (46) ;		// Formular Wiedervorlage hinzufügen
      s1 = r1.getString ("nHeading") ;
      s2 = r1.getString ("eHeading") ;
    }
    catch (Exception e) {
    	throw new UnavailableException (e.toString () + " " + e.getMessage ()) ;
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

    try {

      DataSourceScheduleRead dbs = new DataSourceScheduleRead (getInitParameter("schedule")) ;

      String bck = request.getParameter (param_bck) ;
      int id = Integer.parseInt (request.getParameter (param__id)) ;
            
      Detail det = dbs.detail (id) ;
      
      boolean pin = (u == null) ? false : (u.permissions ().permCrt () ? ! det.done () : false) ;

      String caption = f3.format (det.date ()) ;
      StringBuffer contents = new StringBuffer () ;
      
      {
        Object r [] = {Integer.toString (id)} ;
      	contents.append (f1.format (det, j1.get (response, r))) ;
      }

      List ntf = dbs.notificationList (det) ;
      boolean add = pin && ntf.size () < det.type ().maxn () ;
      if (! ntf.isEmpty () || add) {
        contents.append ("<table cellspacing=\"4\" cellpadding=\"2\"><tr><td valign=\"bottom\">") ;
        if (add) {
          if (false /* bck != null ? (bck.length () > 0 ? true : false) : false */) {
      	    Object r [] = {Integer.toString (id),
												   Integer.toString (36),
												   Integer.toString (id),
												   bck} ;
					  contents.append (h1.format (j2.get (response, r))) ;
		      }
		      else {
		        Object r [] = {Integer.toString (id),
												   Integer.toString (27),
												   Integer.toString (id)} ;
            contents.append (h1.format (j2.get (response, r))) ;
          }
        }
        else {
          contents.append (p1.iconHook ("detail.blank")) ;
        }
        contents.append ("</td><td valign=\"bottom\"><strong>") ;
        contents.append (misc.Helper.htmlConvert (s1)) ;
        contents.append ("</strong></td></tr>\n") ;
        contents.append ("<tr><td></td><td>\n") ;
        contents.append ("<table cellspacing=\"4\" cellpadding=\"0\" border=\"0\">\n") ;
        for (Iterator j = ntf.iterator () ; j.hasNext () ; ) {
          Notification n = (Notification) j.next () ;
          Object r [] = {Integer.toString (n.id ())} ;
          contents.append ("<tr><td valign=\"middle\">") ;
          contents.append (p1.iconHook ("detail.triangle", j1.get (response, r))) ;
          contents.append ("</td><td valign=\"middle\"><font class=\"ndate\">") ;
          if (n.done ()) contents.append ("<strike>") ;
          contents.append (misc.Helper.htmlConvert (f2.format (n.due ()))) ;
          if (n.done ()) contents.append ("</strike>") ;
          contents.append ("</font></td></tr>\n") ;
        }
        contents.append ("</table></td></tr></table>\n") ;
      }
  
      List eve = dbs.eventList (det) ;
      
      if (!eve.isEmpty () || pin) {
        contents.append ("<table cellspacing=\"4\" cellpadding=\"2\"><tr><td valign=\"bottom\">") ;
        if (pin) {
          Object x [] = {Integer.toString (id)} ;
      	  Object r [] = {Integer.toString (id),
      	                 bck == null ? "" : bck} ;
//      	                 new ObjectWrapper (new Pair (new Integer (27), x))} ;
          contents.append (p1.iconHook ("detail.comm", j4.get (response, r))) ;
        }
        else {
          contents.append (h2.format ()) ;
        }
        contents.append ("</td><td valign=\"bottom\"><strong>") ;
        contents.append (misc.Helper.htmlConvert (s2)) ;
        contents.append ("</strong></td></tr>\n") ;
        for (Iterator i = eve.iterator () ; i.hasNext () ; ) {
        	Event e = (Event) i.next () ;
        	contents.append ("<tr><td></td><td>\n") ;
        	contents.append ("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\">") ;
        	contents.append ("<tr><td valign=\"top\">") ;
// Hier ist das Icon.
          contents.append (p1.iconHook (inm [e.typ ()])) ;
  	      contents.append ("</td><td valign=\"top\">") ;
  	      contents.append ("<table cellspacing=\"0\" cellpading=\"0\" border=\"0\">") ;
// Datum des Events  	      
  	      contents.append ("<tr><td colspan=\"2\"><font class=\"etimestamp\">") ;
  	      contents.append (misc.Helper.htmlConvert (f4.format (e.timestamp ()))) ;
  	      contents.append (" (") ;
  	      contents.append (misc.Helper.htmlConvert (e.creator ())) ;
  	      contents.append (")") ;
  	      contents.append ("</font></td></tr>") ;
// Beschreibung des Eventtyps
//  	      contents.append ("<tr><td colspan=\"2\"><font class=\"edescription\">") ;
//         	contents.append (e.description ()) ;
//         	contents.append (e.nevent () ? " (" + f2.format (e.ndue ()) + ")" : ""); 
//  	      contents.append ("</font></td></tr>") ; 

  	      String s = e.comment () ;
  	      if  (s != null ? (s.trim ().length () > 0 ? true : false) : false) {
  		      s = s.trim () ;
  		      int beg = 0 ;
  	        int len = s.length () ;
  		      contents.append ("<tr><td valign=\"top\" background=\"") ;
  		      contents.append (m1.url ()) ;
  		      contents.append ("\"></td>") ;
  		      contents.append ("<td valign=\"top\" align=\"left\" width=\"100%\">") ;
  		      contents.append ("<table width=\"100%\"><tr><td><font class=\"ecomment\">") ;
  		      while (len - beg > max1) {
  			      contents.append (misc.Helper.htmlConvert (s.substring (beg, beg + max1))) ;
  			      contents.append ("</font></td></tr><tr><td><font class=\"ecomment\">") ;
  			      beg += max1 ;
  		      }
  		      contents.append (misc.Helper.htmlConvert (s.substring (beg, len))) ;
  	        contents.append ("</font></td></tr></table></td></tr>") ;
  	      }
  	      contents.append ("</table>\n") ;
  	      contents.append ("</td></tr></table>") ;
        	contents.append ("</td></tr>\n") ;
        }
        contents.append ("</table>\n") ;
      }
//
// Backtracking zurück in die Übersicht, den Suchbericht bzw. in den Arbeitsreport.
// Voraussetzung: Die Weitergabe der Argumente 'b1' und 'b2' im Innenrahmentreiber.
//
      {
        response.setContentType ("text/html") ;
        response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
        PrintWriter out = response.getWriter () ;

        if (bck == null ? true : bck.length () == 0) {
          out.println (p1.format (contents.toString (), caption)) ;
        }
        else {
// Icon mit Verküpfung zurück anbringen
    	  	Pair p = (Pair) ObjectWrapper.fromString (bck).getObject () ;
  		    DataSourceConfiguration d = new DataSourceConfiguration (getInitParameter("config")) ;
  		    Jump j = d.jump (((Integer) p.first ()).intValue ()) ;
  		    Object r [] = (Object []) p.second () ;
  		    out.println (p1.format (contents.toString (), caption, p1.iconHook ("detail.exit", j.get (response, r)))) ;
        }
        out.close () ;
      }
    }
    catch (Exception e) {
      response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getClass ().getName () + e.getMessage ()) ;
    }
  }
}