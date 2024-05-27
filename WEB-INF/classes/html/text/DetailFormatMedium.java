// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.text ;

import java.text.DateFormat ;
import java.text.MessageFormat ;

import misc.Helper ;
import misc.Detail ;
import misc.JumpTarget ;

public class DetailFormatMedium extends DetailFormat {

  private static DateFormat df = DateFormat.getDateInstance (DateFormat.MEDIUM) ;

  private String s1a, s1b, s2a, s2b, s3a, s3b, s4a, s4b, s5a, s5b, sXa, sXb, sAa, sAb ;
  private int i1 = 2 ;
  private int i2 = 0 ;
  private int i3 = 24 ;
  private int i4 = 55 ;
  private int i5 = 70 ;
  private int i6 = 60 ;
  private int iX = 90 ;
  private MessageFormat m1 = new MessageFormat ("<!-- Fehler in DetailFormatMedium --!>") ;

  public DetailFormatMedium (String prefix) {
  	
    String s0a = " class=\"" + prefix + "1x1x" ;
    String s0b = " class=\"" + prefix + "1x0x" ;
    String s0e = " class=\"" + prefix + "0x1x1\">" ;
    String s0f = " class=\"" + prefix + "0x0x1\">" ;

    String s1 = "<table " + "cellspacing=\"" + i1 + "\" cellpadding=\"" + i2 + "\">" +
                "<tr>\n<!--\n\thtml.text.DetailFormatMedium: single row table\n// -->" +
                "<td height=\"" + i3 + "\" width=\"" + i4 + "\"" ;
    
    sAa = s1 + s0b ;
    sAb = s1 + s0b ;

    s1a = "\">" ;
    s1b = "\">" ;

    String s2 = "</td><td width=\"" + i5 + "\"" ;
    s2a = s2 + s0f + "(" ;
    s2b = s2 + s0f + "(" ;

    String sX = "</td><td width=\"" + iX + "\"" ;
    sXa = ")" + sX + s0f ;
    sXb = ")" + sX + s0f ;

    String s3 = "</td><td" ;
    s3a = s3 + s0e ;
    s3b = s3 + s0f ;

    String s4 = "<td" ;
    s4a = s4 + s0e ;
    s4b = s4 + s0f ;

    String s5 = "</td></tr></table>\n" ;
    s5a = s5 ;
    s5b = s5 ;

  }

  public String format (Detail d) {
    return format (d, null) ; 
  }

  public String format (Detail d, JumpTarget jmp) {

    String a1 = jmp == null ? misc.Helper.nameConvert (d.file ()) : jmp.wrap (d.file ()) ;
    String aX = misc.Helper.nameConvert (d.assigned ()) ;
    String a2 = misc.Helper.nameConvert (df.format (d.date ())) ;
    String a3 = misc.Helper.nameConvert (d.subject ()) ;
    String a4 = misc.Helper.nameConvert (d.comment ()) ;

    if (0 > (i6 - d.subject ().length ())) {
      StringBuffer x = new StringBuffer (d.subject ()) ;
      x.setLength (i6) ;
      a3 = jmp == null ? x.toString () : jmp.wrap (x.toString ()) ;
      a4 = "" ;
    }
    else {
      if (0 > (i6 - d.subject ().length () - d.comment ().length ())) {
        StringBuffer x = new StringBuffer (d.comment ()) ;
        x.setLength (i6 - d.subject ().length ()) ;
        a4 = jmp == null ? x.toString () : jmp.wrap (x.toString ()) ;
      }
    }

    StringBuffer b = new StringBuffer () ;
    b.append (d.done () ? sAa : sAb) ;
    b.append (d.type().colorID ()) ;
    b.append (d.done () ? s1a : s1b) ;
    b.append (a1) ;
    b.append (d.done () ? s2a : s2b) ;
    b.append (aX) ;
    b.append (d.done () ? sXa : sXb) ;
    b.append (a2) ;
    b.append (d.done () ? s3a : s3b) ;
    b.append (a3) ;
    b.append (d.done () ? s4a : s4b) ;
    b.append (a4) ;
    b.append (d.done () ? s5a : s5b) ;
    return b.toString () ;
  }
}