// (c) Bernhard Schupp 2001-20024; Frankfurt-München-Frankfurt

package html ;

import java.util.Date ;
import java.util.List ;

import java.text.DateFormat ;

import misc.ObjectWrapper ;
import misc.Pair ;
import misc.Event ;
import misc.Detail ;
import misc.Notification ;

public final class DetailPageImpl {

  private DateFormat da = DateFormat.getDateInstance (DateFormat.LONG) ;
  private DateFormat df = DateFormat.getDateTimeInstance (DateFormat.LONG, DateFormat.MEDIUM) ;

  private class EventFormat {

    private int maxlen = 65 ;
  
    final public String htmlFormat (Event e) {
  	  StringBuffer b = new StringBuffer () ;
  	  b.append ("<table><tr><td valign=\"top\">") ;
  	// Hier muss das Icon rein.
  	  b.append (p1.iconHook ("eventlog.void")) ;
  	  b.append ("</td><td valign=\"top\">") ;
  	  b.append ("<table><tr><td colspan=\"2\">") ;
  	  b.append (e.description ()) ;
  	  b.append (e.nevent () ? " (" + da.format (e.ndue ()) + ")" : ""); 
  	  b.append ("</td></tr><tr><td colspan=\"2\">Von: ") ;
  	  b.append (e.creator ()) ;
  	  b.append (" am: ") ;
  	  b.append (df.format (e.timestamp ())) ;
  	  b.append ("</td></tr>") ;
  	  String s = e.comment () ;
  	  if  (s != null ? (s.trim ().length () > 0 ? true : false) : false) {
  		  s = s.trim () ;
  		  int beg = 0 ;
  	    int len = s.length () ;
  		  b.append ("<tr><td valign=\"top\">Bemerkung:</td><td valign=\"top\" align=\"left\" width=\"100%\">") ;
  		  b.append ("<table><tr><td><strong>") ;
  		  while (len - beg > maxlen) {
  	  		b.append (s.substring (beg, beg + maxlen)) ;
  	  		b.append ("</strong></td></tr><tr><td><strong>") ;
  			  beg += maxlen ;
  	  	}
  	  	b.append (s.substring (beg, len)) ;
  	    b.append ("</strong></td></tr></table></td></tr>") ;
  	  }
    	b.append ("</table>\n") ;
    	b.append ("</td></tr></table>") ;
    	return b.toString () ;
    }
  }

  private String hLine = "<hr align=\"left\" width=\"55%\" size=\"1\">\n" ;
  private BodyPage p1 ;
  
  public DetailPageImpl (BodyPage a) {
  	p1 = a ;
  	
  }
	
	public String format (Detail det, List ntf, List eve, boolean pin, String [] url) {
	  
	  String caption = df.format (det.date ()) ;
    StringBuffer contents = new StringBuffer () ;
    {
      Object r [] = {Integer.toString (det.id ())} ;
    	contents.append (f1.format (det, j1.get (response, r))) ;
    }
    contents.append (hLine) ;

    boolean add = pin && ntf.size () < det.maxnotis () ;
    if (! ntf.isEmpty () || add) {
      contents.append ("<table cellspacing=\"4\" cellpadding=\"2\"><tr><td valign=\"bottom\">") ;
      if (add) {
        Object x [] = {Integer.toString (det.id ())} ;
      	Object r [] = {Integer.toString (det.id ()),new ObjectWrapper (new Pair (new Integer (27), x))} ;
        contents.append (p1.iconHook ("detail.noti", url [1])) ;
      }
      else {
        contents.append (p1.iconHook ("detail.blank")) ;
      }
        contents.append ("</td><td valign=\"bottom\"><strong>") ;
        contents.append (r1.getString ("nHeading")) ;
        contents.append ("</strong></td></tr>\n") ;
        contents.append ("<tr><td></td><td>\n") ;
        contents.append ("<table cellspacing=\"4\" cellpadding=\"0\">\n") ;
        for (Iterator j = ntf.iterator () ; j.hasNext () ; ) {
          Notification n = (Notification) j.next () ;
          Object r [] = {Integer.toString (n.id ())} ;
          contents.append ("<tr><td valign=\"middle\">") ;
          contents.append (p1.iconHook ("detail.triangle", j3.get (response, r))) ;
          contents.append ("</td><td valign=\"middle\">") ;
          if (n.done ()) contents.append ("<strike>") ;
          contents.append (da.format (n.due ())) ;
          if (n.done ()) contents.append ("</strike>") ;
          contents.append ("</td></tr>\n") ;
        }
        contents.append ("</table></td></tr></table>\n") ;
      }

      if (!eve.isEmpty () || pin) {
        contents.append ("<table cellspacing=\"4\" cellpadding=\"2\"><tr><td valign=\"bottom\">") ;
        if (pin) {
          Object x [] = {Integer.toString (det.id ())} ;
      	  Object r [] = {Integer.toString (det.id ()),
      	                 new ObjectWrapper (new Pair (new Integer (27), x))} ;
          contents.append (p1.iconHook ("detail.comm", j4.get (response, r))) ;
        }
        else {
          contents.append (p1.iconHook ("detail.blank")) ;
        }
        contents.append ("</td><td valign=\"bottom\"><strong>") ;
        contents.append (r1.getString ("eHeading")) ;
        contents.append ("</strong></td></tr>\n") ;
        for (Iterator i = eve.iterator () ; i.hasNext () ; ) {
        	contents.append ("<tr><td></td><td>\n") ;
        	contents.append (eventFormat.htmlFormat ((Event) i.next ())) ;
        	contents.append ("</td></tr>\n") ;
        }
        contents.append ("</table>\n") ;
      }
    return "" ;
	}
}