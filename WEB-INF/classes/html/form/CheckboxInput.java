// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.Iterator ;

final public class CheckboxInput extends InputBase {

  private String s1, s2, s3, v1 ;

  public CheckboxInput (String n, String v) {
    super (n) ;
    s1 = incomm (mi1) + "<input type=\"checkbox\" name=\"" + name () + "\" value=\"" ;
    s2 = "\" checked >\n" + incomm (mi2) ;
    s3 = "\">\n" + incomm (mi2) ;
    v1 = v ;
  }

  public String format () {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (v1) ;
    b.append (s3) ;
    return b.toString () ;
  }

  public String format (Object a) {
    try {
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append (v1) ;
      b.append (v1.compareTo ((String)a) == 0 ? s2 : s3) ;
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
