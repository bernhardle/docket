// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.frame ;

import java.util.List ;
import java.util.Iterator ;

public final class Description implements misc.comparison.ID {

  private int id, row, col, bor, mar ;
  private String title, message, basurl, logurl, navurl, driver, body, ometa, imeta, capurl ;
  private List l1 ;

  public Description (int aa, int a, int b, int c, int d, String e, String f, String g, String h, String i, String j, String k, String l, String m, String n, List o) {
    id = aa ;
    row = a ;
    col = b ;
    bor = c ;
    mar = d ;
    title = e ;
    message = f ;
    basurl = g ;
    logurl = h ;
    navurl = i ;
    driver = j ;
    body = k ;
    ometa = l ;
    imeta = m ;
    capurl = n ;
    l1 = o ;		// Argumente
  }
  
  public int id () { return id ; }
  public int rows () { return row ; }
  public int cols () { return col ; }
  public int border () { return bor ; }
  public int margin () { return mar ; }
  public String title () { return title ; }
  public String message () { return message ; }
  public String baseURL () { return basurl ; }
  public String loginURL () { return logurl ; }
  public String captionURL () { return capurl ; }
  public String navigatorURL () { return navurl ; }
  public String bodyURL () { return body ; }
  public String driverURL () { return driver ; }
  public String outerMeta () { return ometa ; }
  public String innerMeta () { return imeta ; }
  public Iterator arguments () { return l1.iterator () ; }
}