// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.text ;

import java.text.DateFormat ;

import misc.Event ;

public class EventFormatLong extends EventFormat {

  private static DateFormat da = DateFormat.getDateInstance (DateFormat.LONG) ;
  private static DateFormat df = DateFormat.getDateTimeInstance (DateFormat.LONG, DateFormat.MEDIUM) ;
  private static String descLoc = "Bemerkung:" ;
  private int maxlen = 65 ;
  
  final public String htmlFormat (Event e) {
  	StringBuffer b = new StringBuffer () ;
  	b.append ("<table><tr><td valign=\"top\">") ;
  	// Hier muss das Icon rein.
  	b.append ("</td><td valign=\"top\">") ;
  	b.append ("<table><tr><td colspan=\"2\">") ;
  	b.append (misc.Helper.nameConvert (e.description ())) ;
  	b.append (e.nevent () ? " (" + misc.Helper.nameConvert (da.format (e.ndue ())) + ")" : ""); 
  	b.append ("</td></tr><tr><td colspan=\"2\">Von: ") ;
  	b.append (misc.Helper.nameConvert (e.creator ())) ;
  	b.append (" am: ") ;
  	b.append (misc.Helper.nameConvert (df.format (e.timestamp ()))) ;
  	b.append ("</td></tr>") ;
  	String s = e.comment () ;
  	if  (s != null ? (s.trim ().length () > 0 ? true : false) : false) {
  		s = s.trim () ;
  		int beg = 0 ;
  	  int len = s.length () ;
  		b.append ("<tr><td valign=\"top\">") ;
  		b.append (misc.Helper.htmlConvert (descLoc)) ;
  		b.append ("</td><td valign=\"top\" align=\"left\" width=\"100%\">") ;
  		b.append ("<table><tr><td><strong>") ;
  		while (len - beg > maxlen) {
  			b.append (misc.Helper.htmlConvert (s.substring (beg, beg + maxlen))) ;
  			b.append ("</strong></td></tr><tr><td><strong>") ;
  			beg += maxlen ;
  		}
  		b.append (misc.Helper.htmlConvert (s.substring (beg, len))) ;
  	  b.append ("</strong></td></tr></table></td></tr>") ;
  	}
  	b.append ("</table>\n") ;
  	b.append ("</td></tr></table>") ;
  	return b.toString () ;
  }
}