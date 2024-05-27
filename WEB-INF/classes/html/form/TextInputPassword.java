// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import misc.Style ;

public final class TextInputPassword extends TextInput {

  private String s1, s2 ;

  public TextInputPassword (Style a, int b, int c, String d) {
    super (a,b,c,d) ;
    StringBuffer y = new StringBuffer () ;
    y.append (mi1) ;
    y.append (" Style: ") ;
    y.append (a.key ()) ;
    
    StringBuffer x = new StringBuffer () ;
    x.append (incomm (y.toString ())) ;
    x.append ("<input type=\"password\" style=\"") ;
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
  }

  public String format () {
    return format ("") ;
  }

  public String format (Object value) {
    try {
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append ((String) value) ;
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