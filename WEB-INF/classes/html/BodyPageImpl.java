// (c) Bernhard Schupp; Frankfurt-München-München; 2001-2004

package html ;

import java.util.Date ;

import misc.Style ;
import misc.Color ;
import misc.Image ;
import misc.Helper ;
import misc.JumpTarget ;

final public class BodyPageImpl extends BasePageAdapter implements BodyPage {

  private int pageWidth, pageHeight, headHeight, captionWidth, bodyPadding, borderWidth ;

  private BasePage b1 ;
  private Color borderColor, boxColor ;
  private final Date crt = new Date () ;
  private String s1, s2, s3, s4 ;
  private int key ;

  public BodyPageImpl (BasePage a, Color b, Color c, int e, int f, int g, int h, int i, int j, int k) {
    super (a) ;
    b1 = a ;
    borderColor = b ;
    boxColor = c ;
    pageWidth = e ;
    pageHeight = f ;
    bodyPadding = g ;
    borderWidth = h ;
    captionWidth = i ;
    headHeight = j ;
    key = k ;
    s1 = incomm ("INFO: begin section formatted by: html.PageLayoutBody /" + key + "/ loaded " + crt.toString ()) +
         "<table border=\"0\" width=\"" + pageWidth + "\" height=\"" + pageHeight + "\">\n" +
         "<tr>\n" +
         "<td valign=\"middle\" align=\"left\" height=\"" + headHeight + "\" width=\"" + captionWidth + "%\">" +
         "<font class=\"head\">" ;
    s2 = "</font></td>\n" +
         "<td valign=\"middle\" align=\"right\" height=\"" + headHeight + "\" width=\"" + (100 - captionWidth) + "%\">\n" ;
    s3 = "</td>\n" +
         "</tr>\n" +
         "<tr>\n" +
         "<td colspan=\"2\">\n" +
         "<table bgcolor=\"" + borderColor.hex () + "\" cellpadding=\"" + bodyPadding + "\" cellspacing=\"" + borderWidth + "\" width=\"100%\">\n" +
         "<tr>\n" +
         "<td width=\"100%\" bgcolor=\"" + boxColor.hex () +"\">\n" ;
    s4 = "</td>\n" +
         "</tr>\n" +
         "</table>\n" +
         "</td>\n" +
         "</tr>\n" +
         "</table>\n" +
         incomm ("INFO: end section formatted by: html.PageLayoutBody") ;
  }

  public int id () {
  	return key ;
  }

  public String format (String a) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (s2) ;
    b.append (s3) ;
    b.append (a) ;
    b.append (s4) ;
    return b1.format (b.toString ()) ;
  }
 
  public String format (String contents, String caption) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (caption) ;
    b.append (s2) ;
    b.append (s3) ;
    b.append (contents) ;
    b.append (s4) ;
    return b1.format (b.toString ()) ;
  }
  
  public String format (String contents, String caption, String toolchest) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (caption) ;
    b.append (s2) ;
    b.append (toolchest) ;
    b.append (s3) ;
    b.append (contents) ;
    b.append (s4) ;
    return b1.format (b.toString ()) ;
  }
}