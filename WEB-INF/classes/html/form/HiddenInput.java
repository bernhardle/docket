// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

final public class HiddenInput extends InputBase {

  private String s1, s2, s3 ;

  public HiddenInput (String a, String b) {
    super (a) ;
    if (b == null) throw new IllegalArgumentException (me4) ;
    s1 = incomm (mi1) + "<input type=\"hidden\" name=\"" + name () + "\" value=\"" ;
    s2 = "\">\n" + incomm (mi2) ;
    s3 = s1 + b + s2 ;
  }

  public String format () {
    return s3 ;
  }

  public String format (Object val) {
    try {
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append ((String) val) ;
      b.append (s2) ;
      return b.toString () ;
    }
    catch (NullPointerException e) {
      return incomm (me4) ;
    }
    catch (ClassCastException e) {
      return incomm (me3) ;
    }
  }
}