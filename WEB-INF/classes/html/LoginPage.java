// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import java.util.Date ;
import java.util.List ;

import misc.Pair ;
import misc.Color ;
import misc.Style ;
import misc.Image ;
import misc.Helper ;
import misc.Ticket ;
import misc.JumpTarget ;

import html.form.Input ;
import html.form.Form ;

public class LoginPage {

  private String userLoc, logoLoc, passLoc ;
  private String s1, s2, s3, s4 ;
  private Date crt = new Date () ;
  private BasePage b1 ;
  private Input f1, f2, f3 ;
  private int i1, i2, i3, i4, i5, i6, i7, i8 ;

  public LoginPage (FormBasePage a, String userLoc, String passLoc, String logoLoc, int bottomMargin) {
    b1 = a ;
    Form b = a.form () ;
    f2 = b.input ("login") ;
    f3 = b.input ("passwd") ;
    f1 = b.input ("go") ;
    
    i1 = 16 ;         // Höhe der 1. Zeile in der nicht-angemeldeten Ansicht
    i2 = 24 ;	       	//          2.
    i3 = 16 ;         //          3.
    i4 = 24 ;         //          4.
    
    i5 = 16 ;         // Höhe der 1. Zeile in der angemeldeten Ansicht
    i6 = 30 ;		      //          2.
    i7 = 6 ;          //          3.
    i8 = 16 ;         //          4.
    
    String t1 = f1.format ("Go!") ;
    {
      StringBuffer x = new StringBuffer () ;
      x.append ("<!--\n\tINFO: begin section formatted by: html.PageLayoutLogin loaded on: ") ;
      x.append (crt.toString ()) ;
      x.append ("\n//-->\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" height=\"") ;
      x.append (Integer.toString (i1 + i2 + i3 + i4)) ;
      x.append ("\" width=\"100%\">\n<tr><td colspan=\"2\" height=\"") ;
      x.append (Integer.toString (i1)) ;
      x.append ("\" width=\"100%\">") ;
      x.append (Helper.nameConvert (userLoc)) ;
      x.append ("</td></tr>\n<tr><td colspan=\"2\" height=\"") ;
      x.append (Integer.toString (i2)) ;
      x.append ("\">\n") ;
      s1 = x.toString () ;
    }
    {
    	StringBuffer x = new StringBuffer () ;
    	x.append ("</td></tr>\n<tr><td colspan=\"2\" height=\"") ;
      x.append (Integer.toString (i3)) ;
      x.append ("\" >") ;
      x.append (Helper.nameConvert (passLoc)) ;
      x.append ("</td></tr>\n<tr><td height=\"") ;
      x.append (Integer.toString (i4)) ;
      x.append ("\" valign=\"bottom\">\n") ;
      x.append (f3.format ("")) ;
      x.append ("</td><td valign=\"bottom\" align=\"right\">") ;
      x.append (t1) ;
      x.append ("</td></tr>\n</table>\n<!--\n\tINFO: end section formatted by: html.PageLayoutLogin\n//-->\n") ;
      s2 = x.toString () ;
    }
    {
    	StringBuffer x = new StringBuffer () ;
    	x.append ("<!--\n\tINFO: begin section formatted by: html.PageLayoutLogin loaded on: ") ;
      x.append (crt.toString ()) ;
      x.append ("\n//-->\n<input type=\"hidden\" name=\"action\" value=\"logout\">\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" height=\"") ;
      x.append (Integer.toString (i5 + i6 + i7 + i8)) ;
      x.append ("\" width=\"100%\">\n<tr><td colspan=\"2\" height=\"") ;
      x.append (Integer.toString (i5)) ;
      x.append ("\" width=\"100%\">") ;
      x.append (Helper.nameConvert (userLoc)) ;
      x.append ("</td></tr>\n<tr><td colspan=\"2\"height=\"") ;
      x.append (Integer.toString (i6)) ;
      x.append ("\"><font class=\"user\">\n") ;

      s3 = x.toString () ;
    }
    {
      StringBuffer x = new StringBuffer () ;
      x.append ("</font></td></tr>\n<tr><td colspan=\"2\" height=\"") ;
      x.append (Integer.toString (i7)) ;
      x.append ("\" width=\"100%\">&nbsp;</td></tr>\n<tr><td valign=\"bottom\" height=\"") ;
      x.append (Integer.toString (i8)) ;
      x.append ("\">") ;
      x.append (Helper.nameConvert (logoLoc)) ;
      x.append ("</td><td valign=\"bottom\" align=\"right\">") ;
      x.append (t1) ;
      x.append ("</td></tr>\n</table>\n<!--\n\tINFO: end section formatted by: html.PageLayoutLogin\n//-->\n") ;

      s4 = x.toString () ;
    }
  }

  public String format (List users) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (f2.format (new Pair (users.iterator (), new Integer (0)))) ;
    b.append (s2) ;
    return b1.format (b.toString ()) ;
  }

  public String format (Ticket t) {
    StringBuffer b = new StringBuffer () ;
    b.append (s3) ;
    b.append (Helper.nameConvert (t.name ())) ;
    b.append (s4) ;
    return b1.format (b.toString ()) ;
  }
}