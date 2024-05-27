// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import misc.Style ;
import misc.Helper ;

public final class SubmitInput extends InputBase {
	
  public final static String s1 = "<!-- class = " ;
  public final static String s2 = " -->\n" ;
  public final static String s3 = "<input type=\"submit\" value=\"" ;
  public final static String s4 = "<input type=\"reset\" value=\"" ;
  public final static String s5 = "<input type=\"button\" value=\"" ;
  public final static String s6 = "\" name=\"" ;
  public final static String s7 = "\" style=\"" ;
  public final static String s8 = " \">\n" ;
  
  public final static int BUTTON = 0 ;
  public final static int SUBMIT = 1 ;
  public final static int RESET = 2 ;

  private String s9, s10, s11 ;

  public SubmitInput (Style sty, int action, String name, String value) {
    super (name) ;
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (Integer.toString (sty.key ())) ;
    b.append (s2) ;
    b.append (action == 1 ? s3 : (action == 2 ? s4 : s5 )) ;
    s9 = b.toString () ;
    b = new StringBuffer () ;
    b.append (s6) ;
    b.append (name ()) ;
    b.append (s7) ;
    b.append (sty.format ()) ;
    b.append (s8) ;
    s10 = b.toString () ;
    s11 = value ;
  }

  public String format () {
    return format (s11) ;
  }

  public String format (Object value) {
    try {
      StringBuffer b = new StringBuffer () ;
      b.append (incomm (mi1)) ;
      b.append (s9) ;
      b.append (Helper.htmlConvert ((String) value)) ;
      b.append (s10) ;
      b.append (incomm (mi2)) ;
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