// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

import java.sql.Date ;

import java.util.Set ;
import java.util.Map ;
import java.util.SortedSet ;
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

public class Helper {
		//
		// Nicht zu konvertierende Zeichen:
		//
  private final static char [] c1 = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                                     'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                                     '1','2','3','4','5','6','7','8','9','0',
                                     '/','.',' ','-','?','!','(',')'} ;
  private final static char [] c2 = {'(',')','+',' ',',',':',';','_','$','@','€','{','}','?','!','*','%','@','|'} ;
		//
		// Zu konvertierende Zeichen:
		//
  private final static char [] c3 = {'ä','ö','ü','Ä','Ö','Ü','ß'} ;
  private final static char [] c4 = {'§','<','>','°','&','\n','¹','²','³','©','¥','÷'} ;
  private final static char [] c5 = {'\''} ;
		// und die HTML Äquivalente
  private final static String [] s1 = {"&auml;", "&ouml;", "&uuml;", "&Auml;", "&Ouml;", "&Uuml;", "&szlig;"} ;
  private final static String [] s2 = {"&sect;", "&lt;", "&gt;", "&deg;","&amp;","<br>","&sup1;","&sup2;","&sup3;","&copy;","&yen;","&divide;"} ;
		// JavaScript String
  private final static String [] s3 = {"\\\'"} ;
  
  private final static int [] max = {31,28,31,30,31,30,31,31,30,31,30,31} ;
  private final static MessageFormat f1 = new MessageFormat ("FATAL: Error when trying to parse {0} into date value.") ;
  private final static int maxYear = 2030, minYear = 1970 ;
  
  private final static GregorianCalendar cal = new GregorianCalendar () ;
  private static SortedSet d1 = null, d2 = null, d3 = null ;
  private static Map m1 = null, m2 = null, m3 = null ;
  
  static {
  	{
      SortedSet s = new java.util.TreeSet () ;
      for (int i = 0 ; i < c1.length ; s.add (new Integer (c1 [i++]))) ;
      d1 = Collections.unmodifiableSortedSet (s) ;
    }
    {
    	SortedSet s = new java.util.TreeSet (d1) ;
      for (int i = 0 ; i < c2.length ; s.add (new Integer (c2 [i++]))) ;
    	d2 = Collections.unmodifiableSortedSet (s) ;
    }
    {
      Map m = new java.util.TreeMap () ;
      for (int i = 0 ; i < c3.length && i < s1.length ; i ++) m.put (new Integer (c3 [i]), s1 [i]) ;
      m1 = Collections.unmodifiableMap (m) ;
    }
    {
      Map m = new java.util.TreeMap (m1) ;
      for (int i = 0 ; i < c4.length && i < s2.length ; i ++) m.put (new Integer (c4 [i]), s2 [i]) ;
      m2 = Collections.unmodifiableMap (m) ;
    }
    {
      Map m = new java.util.TreeMap (m2) ;
      for (int i = 0 ; i < c4.length && i < s3.length ; i ++) m.put (new Integer (c5 [i]), s3 [i]) ;
      m3 = Collections.unmodifiableMap (m) ;
    }
  }
  
  public static Date parseDate (String s) throws IllegalArgumentException {
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

  public static boolean afterToday (Date d) throws IllegalArgumentException {
  	return d.after (parseDate (new Date (new java.util.Date ().getTime ()).toString ())) ;
  }
 
  static String convert (String s, SortedSet v1, Map v2) {
 		String x = s.trim () ;
    int l = x.length () ;
  	StringBuffer b = new StringBuffer (l) ;
  	for (int i = 0 ; i < l ; i ++) {
  		char c = x.charAt (i) ;
  		Integer j = new Integer (c) ;
  		if (v1.contains (j)) b.append (c) ;
  		else if (v2.containsKey (j)) {
  		  b.append ((String) v2.get (j)) ;
  		}
  	}
    return b.toString () ;
  }

  public static String nameConvert (String s) throws IllegalArgumentException {
  	if (s == null) {
  		throw new IllegalArgumentException ("FATAL: null argument not allowed in Helper.nameConvert") ;
  	}
    return convert (s, d1, m1) ;
  }
 
  public static String htmlConvert (String s) throws IllegalArgumentException {
  	if (s == null) {
  		return s ;
  	}
  	else {
      return convert (s, d2, m2) ;	
    }
  }
  
  public static String jsStringConvert (String s) throws IllegalArgumentException {
  	if (s == null) {
  		return s ;
  	}
  	else {
      return convert (s, d2, m3) ;	
    }
  }
  
  private static boolean check (String s, SortedSet a, Map b) {
  	for (int i = 0 ; i < s.length (); i ++) {
  		char c = s.charAt (i) ;
  		Integer x = new Integer (c) ;
  	  if ((! a.contains (x)) && (! b.containsKey (x))) return false ;
  	}
  	return true ;
  }
  
  public static boolean isValidMinilabel (String s) {
  	return check (s, d1, m1) ;
  }
  
  public static boolean isValidLabel (String s) {
  	return check (s, d1, m1) ;
  }
  
  public static boolean isValidName (String s) {
  	return check (s, d1, m1) ;
  }
  
  public static boolean isValidShorthand (String s) {
  	return check (s, d1, m1) ;
  }
  
  public static boolean isValidDescription (String s) {
    return check (s, d1, m1) ;	
  }
  
  public static boolean isValidComment (String s) {
    return true ;	
  }
  
}