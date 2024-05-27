// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import misc.Icon ;

final public class ImageInput extends InputBase {

  private Icon i1 ;
  private String s1, s10, s11, s2, s3, s4, s5, s6, s7, s8 ;

  public ImageInput (Icon i, String n, String val) {
    super (n) ;
    if (i == null) throw new IllegalArgumentException (me2) ;
    i1 = i ;
    s1 = incomm (mi1) + "<input src=\"" ;
    s10 = "\" onMouseOver=\"window.status='" ;
    s11 = "';return true;\" onMouseOut=\"window.status='';return true;\"" ;
    s2 = " name=\"" ;
    s3 = "\" value=\"" ;
    s4 = "\" alt=\"" ;
    s5 = "\" type=\"image\" width=\"" ;
    s6 = "\" height=\"" ;
    s7 = "\">\n" + incomm (mi2) ;
    s8 = val ;
  }

  public String format () {
    return format (s8) ;
  }

  public String format (Object val) {
    try {
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append (i1.url ()) ;
      b.append (s10) ;
      b.append (i1.alt ()) ;
      b.append (s11) ;
      b.append (s2) ;
      b.append (name ()) ;
      b.append (s3) ;
      b.append ((String) val) ;
      b.append (s4) ;
      b.append (misc.Helper.htmlConvert (i1.alt ())) ;
      b.append (s5) ;
      b.append (i1.xsize ()) ;
      b.append (s6) ;
      b.append (i1.ysize ()) ;
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