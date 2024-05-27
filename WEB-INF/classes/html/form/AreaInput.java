// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import misc.Color ;
import misc.Style ;
import misc.Helper ;

public final class AreaInput extends InputBase {

  private String s1, s2, s3 ;

  public AreaInput (Style s, int rows, int cols, String a, String val) throws IllegalArgumentException {
    super (a) ;
    if (rows < 1)  throw new IllegalArgumentException ("html.form.AreaInput: Illegal Argument. /rows=" + rows + "/") ;
    if (cols < 1)  throw new IllegalArgumentException ("html.form.AreaInput: Illegal Argument. /cols=" + cols + "/") ;
    if (s == null) throw new IllegalArgumentException ("html.form.AreaInput: Illegal Argument. /void style/") ;
    
    s1 = incomm (mi1) +  "<textarea name=\"" + name () + "\" rows=\"" + rows + "\" cols=\"" + cols + "\" style=\"" + s.format () + "\">" ;
    s2 = "</textarea>\n" + incomm (mi2) ;
    s3 = val ;
  }

  public String format () {
    return format (s3) ;
  }

  public String format (Object a) {
    try {
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append ((String)a) ;
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