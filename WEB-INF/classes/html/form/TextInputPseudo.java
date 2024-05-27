// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.text.Format ;
import java.text.MessageFormat ;

import misc.Style ;
import misc.Helper ;

public final class TextInputPseudo extends TextInput {
  
  private String s0 ;
  private MessageFormat f1 ;

  public TextInputPseudo (Style a, int b, int c, String d, String e, boolean f) {
				// a-d: siehe TextInput
				// e:   Defaultwert zur Anzeige
				// f:   Mit Rahmen ?
    super (a,b,c,d) ;
    s0 = e ;
    StringBuffer x = new StringBuffer () ;
    x.append (incomm (mi1)) ; 
    x.append ("<table cellpadding=\"0\" cellspacing=\"0\" ") ;
    if (f) {
      x.append ("style=\"border-left: medium groove; ") ;
      x.append ("border-right: 1px solid rgb(128,128,128); ") ;
      x.append ("border-top: medium groove; ") ;
      x.append ("border-bottom: 1px solid rgb(192,192,192)\"") ;
      x.append ("bgcolor=\"#FFFFFF\" border=\"1\"") ;
    }
    x.append (" border=\"0\">") ;
    if (f) {
    	x.append ("<tr><td style=\"border: medium none\">") ;
    }
    else {
    	x.append ("<tr><td>") ; 
    }
    x.append ("<font style=\"") ;
    x.append (style ().format ()) ;
    x.append ("\">") ;
    x.append ("{0}") ;
    x.append ("</font></td></tr></table>\n") ;
    x.append (incomm (mi2)) ;
    
    f1 = new MessageFormat (x.toString ()) ;
  }
  
  public String format () {
    return format (s0) ;
  }

  public String format (Object value) {
    try {
      Object x [] = {Helper.htmlConvert ((String)value)} ;
      return f1.format (x) ;
    }
    catch (NullPointerException e) {
      StringBuffer b = new StringBuffer () ;
      b.append (incomm (me4)) ;
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
