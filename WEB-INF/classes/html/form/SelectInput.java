// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.List ;
import java.util.Iterator ;

import misc.Pair ;
import misc.Style ;
import misc.Option ;
import misc.Helper ;

final public class SelectInput extends InputBase {

  private String s0, s1, s3, s4, s5, s5a, s6, s7 ;
  private boolean b1 ;

  public SelectInput (String n, boolean b) {
    super (n) ;
    s0 = "<option value=\"0\" style=\"color: #000000\" selected>??</option>\n" ;
    s1 = incomm (mi1) + "<select name=\"" + name () + "\" size=\"1\">\n" ;
    s3 = "<option value=\"" ;
    s4 = "\" style=\"color: " ;
    s5 = "\">" ;
    s5a = "\" selected >" ;
    s6 = "</option>\n" ;
    s7 = "</select>\n" + incomm (mi2) ;
    b1 = b ;
  }

  public SelectInput (Style s, String n, boolean b) {
    super (n) ;
    StringBuffer y = new StringBuffer () ;
    y.append (mi1) ;
    y.append (" Style: ") ;
    y.append (s.key ()) ;
    if (s == null) throw new IllegalArgumentException (me2) ;
    s0 = "<option value=\"0\" style=\"color: #000000\" selected>??</option>\n" ;
    s1 = incomm (y.toString ()) + "<select name=\"" + name () + "\" style=\"" + s.format () + "\" size=\"1\">\n" ;
    s3 = "<option value=\"" ;
    s4 = "\" style=\"color: " ;
    s5 = "\">" ;
    s5a = "\" selected >" ;
    s6 = "</option>\n" ;
    s7 = "</select>\n" + incomm (mi2) ;
    b1 = b ;
  }

  public String format (Object a) {
    try {
      Pair p = (Pair) a ;
      Iterator i = (Iterator) p.first () ;
      int j = ((Integer) p.second ()).intValue () ;
      StringBuffer b = new StringBuffer (s1) ;
      if (b1) b.append (s0) ;
      for ( ; i.hasNext () ; ) {
        Option t = (Option) i.next () ;
        b.append (s3) ;
        b.append (t.key ()) ;
//        b.append (s4) ;
//        b.append (t.color ().hex ()) ;
        b.append (t.key () == j ? s5a : s5) ;
        b.append (Helper.nameConvert (t.label())) ;
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

