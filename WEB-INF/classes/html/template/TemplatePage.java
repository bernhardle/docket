// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.template ;

import java.io.IOException ;
import java.io.InputStreamReader ;
import java.io.FileInputStream ;

import java.util.Date ;
import java.util.List ;
import java.util.LinkedList ;
import java.util.Map ;
import java.util.Iterator ;
import java.util.HashMap ;
import java.util.StringTokenizer ;
import java.util.Collections ;

import java.net.URL ;
import java.net.URLConnection ;
import java.net.MalformedURLException ;

final public class TemplatePage {

	// Anfang ersetzbarer Kommentare: <!-- begin dynamic item id=... -->
	// Ende ersetzbarer Kommentare:   <!-- end dynamic item -->

  private final static String c0 = "<>" ;
  private final static String c1 = "!-- begin dynamic item id=" ;
  private final static String c2 = " --" ;
  private final static String c3 = "!-- end dynamic item --" ;
  private final static String c4 = "<!--\n\tWARNING: PageLayoutTemplate ().format () item not replaced.\n//-->\n" ;
  private final static String c5 = "<!--\n\tFATAL: PageLayoutTemplate ().format () inconsistency in internal object state.\n//-->\n" ;
  private final static String c6a = "<!--\n\tNFO: PageLayoutTemplate ().replace () item replaced on " ;
  private final static String c6b = ".\n//-->\n" ;
  private final static String c7a = "<!--\n\tINFO: PageLayoutTemplate ().format () item replaced on " ;
  private final static String c7b = ".\n//-->\n" ;

  private Date crt = new Date () ;

  private List frags ;
  private Map fills = new HashMap () ;
  private Map nofills = Collections.unmodifiableMap (new HashMap ()) ;
  private int len = 0 ;

  public TemplatePage (Description d) throws Exception {

    try {

      InputStreamReader is = null ;
      final String x = "file://" ;

      if (d.url ().startsWith (x)) {

        FileInputStream fs = new FileInputStream (d.url ().substring (x.length ())) ;
        is = new InputStreamReader (fs) ;

      }
      else {

        URL url = new URL (d.url ()) ;
        URLConnection ucn = url.openConnection () ;
        is = new InputStreamReader (url.openStream ()) ;

      }

      StringBuffer buf = new StringBuffer () ;

      for (int i = is.read (); i != -1 ; i = is.read ()) buf.append ((char)i) ;
  
      LinkedList l = new LinkedList () ;
      
      StringTokenizer s = new StringTokenizer (buf.toString (), c0, true) ;
      StringBuffer out = new StringBuffer () ;
      boolean b = false ;				// true == "replace modus"

      while (s.hasMoreTokens()) {
        String t = s.nextToken () ;
  
        if (b == false) {
          if (t.startsWith (c1)) {
            try {
              int i = Integer.parseInt (t.substring (c1.length (), t.indexOf (c2, c1.length ()))) ;
  
              out.setLength (out.length () - 1) ; 	// das vorangehende '<' entfernen          
              Integer j = new Integer (i) ;
              l.add (out.toString ()) ;
              l.add (j) ;
              fills.put (j, c4) ;
              out.setLength (0) ;			// Buffer komplett entleeren            
  
              s.nextToken () ; 				// ist das nächste '>'
              
              b = true ;
          
            } catch (Exception e) {}
          }
          else { out.append (t) ; }
        }
        else {
          if (t.startsWith (c3)) {
            t = s.nextToken () ;
            b = false ;
          }
        }
      }
      l.add (out.toString ()) ;
      frags = Collections.unmodifiableList (l) ;
    }
    catch (MalformedURLException e) { throw new Exception (e.getMessage ()) ; }
    catch (IOException e) { throw new Exception (e.getMessage ()) ; }
  }

  public TemplatePage (TemplatePage t) {
    frags = t.frags ;
    fills = t.fills ;
    len = t.len ;
  }

  public boolean replace (int i, String s) {
    Integer key = new Integer (i) ;
    boolean exs = fills.containsKey (key) ;
    if (exs) { fills.put (key, c6a + new Date () + c6b + s) ; }
    return exs ;
  }

  public String format (Map m) {
    Date now = new Date () ;
    StringBuffer a = new StringBuffer (len) ;
    for (Iterator i = frags.iterator (); i.hasNext (); ) {
      a.append ((String) i.next ()) ;
      if (i.hasNext ()) {
        Integer k = (Integer) i.next () ;
        if (fills.containsKey (k)) {
          if (m.containsKey (k)) {
            try {
              a.append (c7a) ;
              a.append (now) ;
              a.append (c7b) ;
              a.append ((String) m.get (k)) ;
            } catch (Exception e) {a.append ((String) fills.get (k)) ; }
          }
          else { a.append ((String) fills.get (k)) ; }
        }
        if (! i.hasNext ()) { return c5 ; }
      }
    }
    return a.toString () ;
  }

  public String format () {
    return format (nofills) ;
  }
}