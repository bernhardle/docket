// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.text ;

import java.util.List ;
import java.util.Iterator ;

import misc.Helper ;

final public class TableFormat {

  private final static String m1 = "<!-- FATAL: null reference [list] in TableFormat.format () -->\n" ;
  private final static String m2 = "<!-- FATAL: null reference [item] in TableFormat.format () -->\n" ;

  private String s1, s2, s3, s4, s5, s6, s7 ;

  public TableFormat () {
    s1 = "<table>\n" ;
    s2 = "<tr>\n" ;
    s3 = "<td nowrap=\"nowrap\">" ;
    s4 = "</td>\n" ;
    s5 = "</tr>\n" ;
    s6 = "</table>" ;
    s7 = "&nbsp;" ;
  }

  public String  format (List l) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;      
    if (l == null) { b.append (m1) ; }
    else {
      for (Iterator i = l.iterator () ; i.hasNext () ; ) {
        b.append (s2) ;
        try {
          String [] x = (String []) i.next () ;
          int y = x.length ;
          for (int j = 0; j < y ; j ++) {
            b.append (s3) ;
            b.append (x [j] == null ? s7 : Helper.htmlConvert (x [j])) ;
            b.append (s4) ;
          }
        }
        catch (RuntimeException e) { b.append (m2) ; }
        b.append (s5) ;
      }
    }
    b.append (s6) ;
    return b.toString () ;
  }
}