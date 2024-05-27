// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.List ;
import java.util.LinkedList ;
import java.util.Iterator ;
import java.util.Calendar ;

import java.text.SimpleDateFormat ;

import java.sql.Date ;

import misc.Pair ;
import misc.Style ;
import misc.Option ;

final public class DateInput extends InputBase {

  private SelectInput sel ;
  private String s1a, s1b, s1c, s3a, s3b, s3c ;
  private List mon = new LinkedList () ;

  public DateInput (Style s, String n) {
    super (n) ;
    if (s == null) throw new IllegalArgumentException (me2) ;
    s1a = incomm (mi1) + "<input type=\"text\" size=\"2\" style=\"" + s.format () + "\" maxlength=\"2\" name=\"dd" + name () + "\" value=\"" ;
    s1c = "\">\n" ;
    s3a = "\n<input type=\"text\" size=\"4\" style=\"" + s.format () + "\" maxlength=\"4\" name=\"yyyy" + name () + "\" value=\"" ;
    s3c = "\">\n" + incomm (mi2) ;
    String [] m = new SimpleDateFormat ().getDateFormatSymbols().getMonths () ;
    for (int i = 0 ; i < 12 ; i++) mon.add (new Option (i + 1, m [i])) ;
    sel = new SelectInput (s,"mm" + name (), true) ;
  }

  public String format () {
    StringBuffer b = new StringBuffer () ;
    b.append (s1a) ;
    b.append (s1c) ;
    b.append (sel.format (new Pair (mon.iterator (), new Integer (0)))) ;
    b.append (s3a) ;
    b.append (s3c) ;
    return b.toString () ;
  }

  public String format (Object o) {
    try {
      StringBuffer b = new StringBuffer () ;
      Calendar c = (Calendar) o ;
      b.append (s1a) ;
      b.append (c.get (Calendar.DAY_OF_MONTH)) ;
      b.append (s1c) ;
      b.append (sel.format (new Pair (mon.iterator (), new Integer (c.get (Calendar.MONTH) + 1)))) ;
      b.append (s3a) ;
      b.append (c.get (Calendar.YEAR)) ;
      b.append (s3c) ;
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
