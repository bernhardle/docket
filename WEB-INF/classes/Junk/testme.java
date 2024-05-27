// (c) Bernhard Schupp; 2004; Frankfurt; 

import java.io.* ;
import java.util.zip.ZipEntry ;
import java.util.zip.ZipOutputStream ;
import java.sql.Date ;
import java.util.Locale ;
import java.util.LinkedList ;
import java.util.Random ;
import java.util.GregorianCalendar ;

import java.text.Format ;
import java.text.DateFormat ;
import java.text.MessageFormat ;
import java.util.StringTokenizer ;

import misc.ObjectWrapper ;

import data.DataSourceSchedule ;

public class testme {
	
	private static int typ [] = {1, 2, 3, 9, 18, 19} ;
	private static int asd [] = {10, 11, 12, 13, 14} ;
	private static String s15 = "kjsuebsskssuejs" ;
	private static String s50 = "jshdgeoajs389sjskis93is42isdsdertz" ;
	private static String [] s250 = {"jshdgeoajs389sjsjshdgeoajs389sjskis93issdertz",
	                                 "jshdgeojshdgeoajs389sjskis93iskmsöioukis93iskmsdsdertzu3nbnisdsdertz",
	                                 "jshdgeoajs3jshdgeoajs389sjskis93iskmsöiou32342isdsdertznwzu2342iu3nbnwzu2342isdsdertz",
	                                 "jshdgeoajs389sjskis93iskmsöiou3nbnweoajs389sjskis93ijshdgeoajs389sjskis93iskmsöiou3nbnwzu2342isdsdertzertz",
	                                 "jshdgeoajs389sjskis93iskmsöiou3nbnwzu2342isöiou3nbnwzu2342isdsdertzjshdgeoajs389sjskis93iskmsöiou3nbnwzu2342isdsdertzjshdgeoajs389sjskis93isisdsdertz"} ;
	
	final private static int [] max = {31,28,31,30,31,30,31,31,30,31,30,31} ;
	
	private static GregorianCalendar cal = new GregorianCalendar () ;
	private static DateFormat df = DateFormat.getDateTimeInstance (DateFormat.LONG, DateFormat.MEDIUM) ;
	private static final Random r = new Random () ;
	private static final Date now = new Date (new java.util.Date ().getTime ()) ;
	private static final html.text.TableFormat f1 = new html.text.TableFormat () ;
	
	private static Date getDate () {
	  return 	new Date (now.getTime () + 175200000 * (long) r.nextInt (365)) ;
	}
	
	final Date parseDate (String s) throws IllegalArgumentException {
		int minYear = 1990 ;
		int maxYear = 2020 ;
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
    throw new IllegalArgumentException ("FATAL: testme.parseDate (" + s + ") failed.") ;
  }
	
	public static void main (String [] args) throws IOException {

    int n = Integer.parseInt (args [1]) ;
    try {
      PrintWriter log = new PrintWriter (new FileOutputStream ("C:\\Temp\\filler.log")) ;

      for (int i = 0 ; i < n ; i ++) {
    	  DataSourceSchedule d = null ;
        try {
        	log.println ("Neuanfang") ;
    	    d = new DataSourceSchedule (args [0]) ;
    	
          for ( ; i < 1000; i ++) {
    	
        	  Date due = getDate () ;
    	
      	    String sub = s15 ;
    	      String com = s50 ;
    	      String mta = s15 ;
    	  
   		      int l = r.nextInt (6) ;
  		      if (l < 1) {
    	    	  int k = r.nextInt (4) ;
    	        com = s250 [k] ;
    	      }
      	    int a = asd [r.nextInt (asd.length)] ;
    	      int t = typ [r.nextInt (typ.length)] ;
    	      int f = r.nextInt (32000) ;
      	    log.println (df.format (new java.util.Date ()) + " " + i + " " + due + " " + t + " " + com.length ()) ;
    	      int id = d.insertDueEntry (due, a, t, Integer.toString (f), s15, 6, com, mta) ;
      	    for (int j = 0 ; j < (int) r.nextInt (7) ; j ++) {
      		    Date wv = getDate () ;
    	  	    while (! wv.before (due)) wv = getDate () ;
    		      try {
    		        d.insertNotificationEntry (wv, id) ;
    		      } catch (data.DataSourceException e) {
    		      	log.println ("hups:" + e.getMessage ()) ;
    		      }
            }
            log.flush () ;
            if (i % 50 == 0) break ;
          }
        }
        catch (Exception e) {
          log.println ("Mist " + e.getMessage ()) ;
        }
        d = null ;
        System.gc () ;
        log.println ("Kleine Pause") ;
        try {
        	Thread.sleep (20000) ;
        } catch (InterruptedException x) {}
      }
      log.println ("Fertig") ;
      System.exit (0) ;
    }
    catch (IOException e) {
    	System.exit (1) ;
    }
	}
}


// Junk Area.
		/*
    String s = "Treffer 1 bis 34 von 250 (weitere Treffer unterdrückt)." ;
    LinkedList l = new LinkedList () ;
    for (int i = 0 ; i < 10 ; i++ ) l.add (s) ;
    
    ObjectWrapper w = new ObjectWrapper (l) ;
    String x = w.toString () ;
    System.out.println (x.length () + " " + x) ;

      MessageFormat f3 = new MessageFormat ("{0,date,long} {1,date,long} {2}") ;
      DateFormat df = DateFormat.getDateInstance (DateFormat.LONG) ;
      Format fm2 [] = {df,df,new MessageFormat("{0}")} ;
      f3.setFormats (fm2) ;
      Object r [] = {new Date (), new Date (), "Hallo"} ;
      System.out.println (f3.format (r)) ;
*/