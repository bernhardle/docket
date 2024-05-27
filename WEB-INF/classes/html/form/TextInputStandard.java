// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import misc.Style ;

public final class TextInputStandard extends TextInput {

  private String s1, s2, s3 ;

  public TextInputStandard (Style a, int b, int c, String d, String e) {
    super (a,b,c,d) ;
    StringBuffer x = new StringBuffer () ;
    x.append (incomm (mi1)) ;
    x.append ("<input type=\"text\" style=\"") ;
    x.append (style ().format ()) ;
    x.append ("\" size=\"") ;
    x.append (Integer.toString (len ())) ;
    x.append ("\" maxlength=\"") ;
    x.append (Integer.toString (max ())) ;
    x.append ("\" name=\"") ;
    x.append (name ()) ;
    x.append ("\" value=\"") ;
    s1 = x.toString () ;
    s2 = "\" >\n" + incomm (mi2) ;
    s3 = e ;
  }

  public String format () {
    return format (s3) ;
  }

  public String format (Object value) {
    try {
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append ((String)value) ;
      b.append (s2) ;
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