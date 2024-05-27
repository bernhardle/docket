// (c) Bernhard Schupp 2001-2002

import java.util.Set ;
import java.util.Map ;
import java.util.HashSet ;
import java.util.Iterator ;
import java.util.Collections ;
import java.util.Locale ;
import java.util.Calendar ;
import java.util.Properties ;
import java.util.ResourceBundle ;
import java.util.GregorianCalendar ;
import java.util.StringTokenizer ;

import java.text.MessageFormat ;

import java.sql.Date ;

import javax.servlet.* ;
import javax.servlet.http.* ;

import misc.Ticket ;

import data.DataSourceConfiguration ;

abstract class MyBasicHttpServlet extends HttpServlet {
  
  final private static int [] max = {31,28,31,30,31,30,31,31,30,31,30,31} ;
  final private static String major = "basic" ;
  final static Locale def = Locale.getDefault () ;
  final private static Set instances = Collections.synchronizedSet (new HashSet ()) ;
  final private static MessageFormat f1 = new MessageFormat ("error while parsing {0} as date value") ;
  final private static MessageFormat f2 = new MessageFormat ("error while retrieving date field {0} from response") ;
  
  private GregorianCalendar cal = new GregorianCalendar () ;
  private ResourceBundle r1 ;
  private Properties p1 ;

  private int maxYear, minYear ;
  protected final static int maxCmmLen = 255 ;

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    try {
      DataSourceConfiguration d = new DataSourceConfiguration (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      p1 = d.properties (major) ;
      maxYear = Integer.parseInt (p1.getProperty ("maxYear")) ;
      minYear = Integer.parseInt (p1.getProperty ("minYear")) ;
      instances.add (this) ;
    }
    catch (Exception e) {
    	throw new UnavailableException (e.getMessage ()) ;
    }
  }

  final Locale locale () {
    return def ;
  }
/*
  final Date parseDate (String s) throws IllegalArgumentException {
    StringTokenizer t = new StringTokenizer (s, "-") ;
    if (t.hasMoreTokens()) {
      int y = Integer.parseInt (t.nextToken ()) ;
      if (minYear <= y && y <= maxYear && t.hasMoreTokens ()) {
        int m = Integer.parseInt (t.nextToken ()) ;
        if (0 < m && m < 13 && t.hasMoreTokens ()) {
          int d = Integer.parseInt (t.nextToken ()) ;
          if (1 <= d && d <= max [m-1] + (m == 2 && cal.isLeapYear (y) ? 1 : 0)) return Date.valueOf (y + "-" + m + "-" + d) ;
        }
      }
    }
    Object r [] = {s} ;
    throw new IllegalArgumentException (f1.format (r)) ;
  }
*/
  final Date parseDate (HttpServletRequest request, String x) throws IllegalArgumentException {
    String yyyy = request.getParameter ("yyyy" + x) ;
    String mm = request.getParameter ("mm" + x) ;
    String dd = request.getParameter ("dd" + x) ;
    if (request != null && x != null && yyyy != null) {
      int y = Integer.parseInt (yyyy) ;
      if (minYear <= y && y <= maxYear && mm != null) {
        int m = Integer.parseInt (mm) ;
        if (0 < m && m < 13 && dd != null) {
          int d = Integer.parseInt (dd) ;
          if (1 <= d && d <= max [m-1] + (m == 2 && cal.isLeapYear (y) ? 1 : 0)) return Date.valueOf (y + "-" + m + "-" + d) ;
        }
      }
    }
    Object r [] = {x} ;
    throw new IllegalArgumentException (f2.format (r)) ;
  }

  final Date parseDate (HttpServletRequest request) throws IllegalArgumentException {
    return parseDate (request, "") ;
  }

  final static void refresh () throws ServletException {
    for (Iterator i = instances.iterator () ; i.hasNext () ; ((MyBasicHttpServlet)i.next ()).reload ()) ;
  }
 
  protected abstract void reload () throws ServletException ;
}