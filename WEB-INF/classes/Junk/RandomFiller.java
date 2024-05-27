// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

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

public class RandomFiller extends Thread {
	
	private static int typ [] = {1, 2, 3, 4, 5, 6, 7} ;
	private static int asd [] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12} ;
	private static int uid [] = {1, 2, 3, 4, 5} ;
	private static String s15 = "Das Subject ..." ;
	private static String s50 = "Kurzer Kommentar mit 50 Zeichen..." ;
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
	
	private int n, m ;
	private PrintWriter log, err ;
	private String source ;
	
	private static Date getDate () {
	  return 	new Date (now.getTime () + 100000000 * (long) r.nextInt (365)) ;
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
	
	private RandomFiller (String a, int b, int c, PrintWriter d, PrintWriter e) {
	  source = a ;
	  n = b ;
	  m = c ;
	  log = d ;
	  err = e ;
	}
	
	public static void main (String [] args) throws IOException {
		Thread [] t = new Thread [10] ;
		if (args.length < 2) {
		  System.err.println ("usage: java RandomFiller <properties> <Number>") ;
		  System.exit (2) ;	
		}
		try {
			PrintWriter p = new PrintWriter (new FileOutputStream ("C:\\Temp\\filler.log")) ;
			PrintWriter q = new PrintWriter (new FileOutputStream ("C:\\Temp\\filler.err")) ;
			for (int i = 0 ; i < 10 ; i ++) {
        t [i] = new RandomFiller (args[0], Integer.parseInt (args [1]), i, p, q) ;
        t [i].start () ;
      }
    }
    catch (Exception e) { System.exit (1) ; }
  }

  public void run () {
      for (int i = 0 ; i < n ; i ++) {
    	  DataSourceSchedule d = null ;
        try {
        	log.println ("Neuanfang") ;
    	    d = new DataSourceSchedule (source) ;
    	
          for ( ; i < n; i ++) {
    	
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
    	      int u = uid [r.nextInt (uid.length)] ;
    	      int f = r.nextInt (32000) ;
    	      StringBuffer x = new StringBuffer () ;
    	      x.append (Integer.toString (m)) ;
    	      x.append (": ") ;
    	      x.append (df.format (new java.util.Date ())) ;
    	      x.append (" Lfd. Nr.: ") ;
    	      x.append (Integer.toString (i)) ;
    	      x.append (", ") ;
    	      x.append (due) ;
    	      x.append (", ") ;
    	      x.append (Integer.toString (t)) ;
    	      x.append (", ") ;
    	      x.append (Integer.toString (com.length ())) ;
    	      log.println (x.toString ()) ;
    	      int id = d.insertDueEntry (due, a, t, Integer.toString (f), s15, 1, com, mta) ;
      	    for (int j = 0 ; j < (int) r.nextInt (7) ; j ++) {
      		    Date wv = getDate () ;
    	  	    while (! wv.before (due)) wv = getDate () ;
    		      try {
    		        d.insertNotificationEntry (wv, id) ;
    		      } catch (data.DataSourceException e) {
    		      	err.println ("hups:" + e.getMessage ()) ;
    		      	err.flush () ;
    		      }
            }
            log.flush () ;
            if (i % 50 == 0) break ;
            try {
        	    sleep (1000) ;
            } catch (InterruptedException w) {}
          }
        }
        catch (Exception e) {
          err.println ("Mist " + e.getMessage ()) ;
          err.flush () ;
        }
        d = null ;
        log.println ("Kleine Pause") ;
        try {
        	sleep (20000) ;
        } catch (InterruptedException x) {}
      }
      log.println ("Fertig") ;
      System.exit (0) ;
    }
}


