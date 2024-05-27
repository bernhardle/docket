// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import java.util.Date ;
import java.util.List ;

import misc.Color ;
import misc.Style ;
import misc.Icon ;
import misc.JumpTarget ;

import html.form.Form ;
import html.form.ImageInput ;

public final class NavigatorPage {

  public class IconTable {

    final String s1 = "<table border=\"0\" cellpadding=\"" + i1 + "\" cellspacing=\"" + i2 + "\">\n" ;
    final String s2 = "</table>\n" ;
    final String s3 = "<tr><td>" ;
    final String s4 = "</a></td></tr>\n" ;

    StringBuffer b = new StringBuffer (s1) ;

    public IconTable () { }

    public void addIcon (String key, JumpTarget url) {
      b.append (s3) ;
      b.append (b1.iconHook (key,url)) ;
      b.append (s4) ;
    }

    String format () {
      b.append (s2) ;
      return b.toString () ;
    }
  }

  private BasePage b1 ;
  private Date crt = new Date () ;
  private String s1, s2 ;
  private Form f1 ;
  private int i1, i2 ;

  public NavigatorPage (FormBasePage a , String b, int c, int d) {
    Form f = a.form () ;
    b1 = a ;
    f1 = f ;
    i1 = c ;
    i2 = d ;
    s1 = incomm ("begin section formatted by: html.PageLayoutNavigator loaded on: " + crt.toString ()) +
         "<table border=\"0\" cellpadding=\"0\" cellspacing=\"1\" height=\"505\">\n" + 
         "<tr><td align=\"left\" valign=\"top\">\n" + f1.input ("action").format () +
         "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n" + 
         "<tr><td valign=\"middle\" align=\"left\" height=\"20\">" + b + "</td></tr>\n" + 
         "<tr><td valign=\"middle\" align=\"left\" height=\"20\">" + f1.input ("token").format ("") + "<td></tr>\n" +
         "<tr><td></td></tr>\n" +
         "<tr><td valign=\"middle\" align=\"left\">" + f1.input ("search").format ("") + "</td></tr>\n" + 
         "</table>\n" + 
         "</td></tr>\n" + 
         "<tr><td></td></tr>\n" +
         "<tr><td valign=\"bottom\" height=\"10\" align=\"left\">\n"  ;

    s2 = "</td></tr></tr>\n<tr><td height=\"10\"></td></tr>\n" +
         "<tr><td align=\"center\" valign=\"bottom\" height=\"15\" width=\"100%\">\n" +
         "<font class=\"note\">&copy; Bernhard '03</font>\n" +
         "</td></tr>\n</table>\n" +
         incomm ("end section formatted by: html.PageLayoutNavigator\n") ;
  }

  public String incomm (String a) {
    return "\n<!--\n" + a + "\n//-->\n" ;
  }

  public String format (IconTable icons) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (icons.format ()) ;
    b.append (s2) ;
    return b1.format (b.toString ()) ;
  }

}