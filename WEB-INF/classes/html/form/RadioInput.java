// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.List ;
import java.util.Iterator ;

import misc.Pair ;
import misc.Style ;
import misc.Option ;

final public class RadioInput extends InputBase {

  private String s1, s2, s3, s3a, s4, s5, s6, s7 ;

  public RadioInput (String name, Style sty) {
    super (name) ;
    s1 = incomm (mi1) + "<table>\n" ;
    s2 = "<tr><td><input type=\"radio\" value=\"" ;
    s3 = "\" name=\"" ;
    s3a = "\" checked name=\"" ;
    s4 = "\"></td><td><font style=\"" + sty.format () + "\">" ;
    s6 = "</font></td></tr>\n" ;
    s7 = "</table>\n" + incomm (mi2) ;
  }

  public String format (Object a) {
    try {
      StringBuffer b = new StringBuffer (s1) ;
      Pair p = (Pair) a ;
      int val = ((Integer) p.second ()).intValue () ;
      for (Iterator i = (Iterator) p.first () ; i.hasNext () ; ) {
        Option o = (Option) i.next () ;
        b.append (s2) ;
        b.append (o.key ()) ;
        b.append (o.key () == val ? s3a : s3) ;
        b.append (name ()) ;
        b.append (s4) ;
        b.append (o.label ()) ;
        b.append (s6) ;
      }
      b.append (s7) ;
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