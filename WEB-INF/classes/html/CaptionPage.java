// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import java.util.Date ;

import misc.Color ;
import misc.Style ;
import misc.Icon ;
import misc.Caption ;
import misc.JumpTarget ;

final public class CaptionPage extends BasePageAdapter {

  private Date crt = new Date () ;
  private int id, height, wIcon, wSpaceA, wSpaceB, wCaption, wBorder, wTable ;
  private String s1, s2, s3 ;

  public CaptionPage (BasePage a, int i, int b, int c, int d, int e, int f, int g) {
    super (a) ;
    id = i ;
    height = b ;
    wIcon = c ;
    wSpaceA = d ;
    wCaption = e ;
    wSpaceB = f ;
    wBorder = g ;

    wTable = wSpaceA + wIcon + wSpaceB + wCaption ;

    s1 = incomm ("INFO: begin section formatted by: html.PageLayoutCaption loaded on: " + crt.toString ()) +
         "<table border=\"" + wBorder + "\" width=\"" + wTable + "\" cellspacing=\"0\" cellpadding=\"0\">\n" +
         "<tr>\n" +
         "<td valign=\"center\" height=\"" + height + "\" width=\"" + wSpaceA + "\">" +
         "<img src=\"../images/null.gif\" width=\"" + wSpaceA + "\" height=\"" + height + "\">" +
         "</td>\n" +
         "<td valign=\"center\" width=\"" + wIcon + "\">" ;

    s2 = "</td>\n" +
         "<td valign=\"center\" width=\"" + wSpaceB + "\"></td>\n" +
         "<td valign=\"center\" width=\"" + wCaption + "\">\n<font class=\"caption\">" ;

    s3 = "</font>\n" +
         "</td>\n" +
         "</tr>\n" +
         "</table>\n" +
         incomm ("INFO: end section formatted by: html.PageLayoutCaption") ;
  }

  public int id () {
  	return id ;
  }

  public String format (Caption c) {
  	StringBuffer b = new StringBuffer () ;
  	b.append (s1) ;
  	b.append (iconHook (c.icon ())) ;
  	b.append (s2) ;
  	b.append (misc.Helper.htmlConvert (c.title ())) ;
  	b.append (s3) ;
    return super.format (b.toString ()) ;
  }
}