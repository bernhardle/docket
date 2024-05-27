// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

import java.util.Locale ;
import java.util.GregorianCalendar ;
import java.util.StringTokenizer ;

public class Date extends java.sql.Date {

  final static int minYear = 1930, maxYear = 2050, max [] = {31,28,31,30,31,30,31,31,30,31,30,31} ;
  final static GregorianCalendar cal = new GregorianCalendar () ;

  public Date (long millis) {
    super (millis) ;
  }

  static Date parseDate (String s) throws IllegalArgumentException {
    StringTokenizer t = new StringTokenizer (s, "-") ;
    if (t.hasMoreTokens()) {
      int y = Integer.parseInt (t.nextToken ()) ;
      if (minYear <= y && y <= maxYear && t.hasMoreTokens ()) {
        int m = Integer.parseInt (t.nextToken ()) ;
        if (0 < m && m < 13 && t.hasMoreTokens ()) {
          int d = Integer.parseInt (t.nextToken ()) ;
          if (1 <= d && d <= max [m-1] + (m == 2 && cal.isLeapYear (y) ? 1 : 0)) return new Date (Date.valueOf (y + "-" + m + "-" + d).getTime ()) ;
        }
      }
    }
    throw new IllegalArgumentException (s) ; // DateFormatException (s) ;
  }

}