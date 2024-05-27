// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.Date ;
import java.util.Calendar ;

final public class HiddenDateInput extends InputBase {

  private String s1, s2, s3, s4 ;

  public HiddenDateInput (String a) {
    super (a) ;
    s1 = incomm (mi1) + "<input type=\"hidden\" name=\"dd" + name () + "\" value=\"" ;
    s2 = "\">\n<input type=\"hidden\" name=\"mm" + name () + "\" value=\"" ;
    s3 = "\">\n<input type=\"hidden\" name=\"yyyy" + name () + "\" value=\"" ;
    s4 = "\">\n" + incomm (mi2) ;
  }

  public String format (Object val) {
    try {
      Date d = (Date) val ;
      Calendar c = Calendar.getInstance () ;
      c.setTime (d) ;
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append (c.get (Calendar.DATE)) ;
      b.append (s2) ;
      b.append (Integer.toString (c.get (Calendar.MONTH) + 1)) ;
      b.append (s3) ;
      b.append (c.get (Calendar.YEAR)) ;
      b.append (s4) ;
      return b.toString () ;
    }
    catch (NullPointerException e) {
      StringBuffer b = new StringBuffer () ;
      b.append (me4) ;
      b.append (e.getMessage ()) ;
      return b.toString () ;
    }
    catch (ClassCastException e) {
      StringBuffer b = new StringBuffer () ;
      b.append (me3) ;
      b.append (e.getMessage ()) ;
      return b.toString () ;
    }
  }
}