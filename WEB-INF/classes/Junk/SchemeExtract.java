// (c) Bernhard Schupp

import java.io.* ;
import java.sql.* ;
import java.util.SortedSet ;
import java.util.Map ;
import java.util.Set ;
import java.util.Iterator ;
import java.util.List ;
import java.util.LinkedList ;
import java.util.Collections ;

import java.text.Format ;
import java.text.DateFormat ;
import java.text.MessageFormat ;
import java.util.StringTokenizer ;

import data.ConnectionHandler ;
import data.DataSourceException ;
import data.DataSourceConfiguration ;

public class SchemeExtract extends ConnectionHandler {

  class Comparison implements java.util.Comparator {
  	
    public int compare (Object a, Object b) {
      String sa = (String) a ;
      String sb = (String) b ;
      if (m2.containsKey (sb) ? ((Set) m2.get (sb)).contains (sa) : false) { return 1 ; }
      else if (m2.containsKey (sa) ? ((Set) m2.get (sa)).contains (sb) : false) { return -1 ; }
      else { return sb.compareTo (sa) ; }
    }
  }

  final class Reverse extends Comparison {
    public int compare (Object a, Object b) {
    	int i = super.compare (a,b) ;
//    	System.out.println ((String) a + " " + (String) b + " " + Integer.toString (i)) ;
      return - i ; 
    }
  }

	private static final html.text.TableFormat f1 = new html.text.TableFormat () ;
  private Map m1 = new java.util.HashMap () ;
  private Map m2 = new java.util.HashMap () ;
  private List l1 = new java.util.LinkedList () ;
//  private SortedSet s1 = new java.util.TreeSet () ;
  
  private SchemeExtract (String s) throws DataSourceException {
  	super (s) ;
  }

  private void doIt (PrintWriter pw) throws SQLException {
  	
  	PreparedStatement p = con.prepareStatement ("select szObject, szColumn, szReferencedObject, szReferencedColumn from MSysRelationships") ;
  	ResultSet r = p.executeQuery () ;
  	while (r.next ()) {
  		String s1 = r.getString (1) ;
  		String s2 = r.getString (2) ;
  		String s3 = r.getString (3) ;
  		String s4 = r.getString (4) ;
  		if (!m1.containsKey (s1)) m1.put (s1, new java.util.HashMap ()) ;
  	  ((Map) m1.get (s1)).put(s2, new misc.Pair (s3, s4)) ;
  	  
  	  if (!m2.containsKey (s1)) m2.put (s1, new java.util.TreeSet ()) ;
  	  ((Set) m2.get (s1)).add (s3) ;
//  	  System.out.println (s1 + " + " + s3) ;
  	  
  	}
  	r.close () ;
  	p.close () ;
  	

  	
  	pw.println ("--") ;
  	pw.println ("-- (c) Bernhard Schupp; Frankfurt-München; 2001-2003") ;
  	pw.println ("--") ;
  	pw.println ("--") ;
  	
  	{
  		List l = new java.util.LinkedList () ;
  	  Set c = new java.util.TreeSet () ;
  	  
  	  p = con.prepareStatement ("select name from MsysObjects where Flags=0 and Type=1") ;
  	  r = p.executeQuery () ;
    	while (r.next ()) {
  		  String s = r.getString (1) ;
  	    l.add (s) ;
  	  }
  	  r.close () ;
  	  p.close () ;
  	  
  	  while (l.size () > 0) {
  	    for (Iterator i = l.iterator () ; i.hasNext () ; ) {
  	      String s = (String) i.next () ;
  	      if (m2.containsKey (s)) {
  	      	Set u = (Set) m2.get (s) ;
  	      	if (c.containsAll (u)) {
  	      		l1.add (s) ;
  	      		c.add (s) ;
  	      	  i.remove () ;
  	      	}
  	      }
  	      else {
  	      	l1.add (s) ;
  	      	c.add (s) ;
  	      	i.remove () ;
  	      }
  	    }
  	  }
    }
    {
    	Collections.reverse (l1) ;
      for (Iterator i = l1.iterator () ; i.hasNext () ; ) {
    	  String s = (String) i.next () ;
        pw.println ("IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = \'" + s + "\') DROP TABLE " + s) ;
      }
      Collections.reverse (l1) ;
    }  
    
    
  	pw.println ("--") ;
  	pw.println ("GO") ;
  	pw.println ("PRINT \'Alle Tabellen gelöscht.\'") ; 
  	pw.println ("") ;
  	
  	for (Iterator i = l1.iterator () ; i.hasNext () ; ) {
  		
  		String table = (String) i.next () ;
  		
  		pw.println ("--") ;
  		
  	  p = con.prepareStatement ("select * from " + table) ;
  	  r = p.executeQuery () ;
  	  
  	  ResultSetMetaData rmd = r.getMetaData () ;
      int col = rmd.getColumnCount () ;
      
      StringBuffer a = new StringBuffer () ;
      StringBuffer c = new StringBuffer () ;
      
      boolean pkinsert = false ;
      
      {
        a.append ("INSERT INTO ") ;
  	    a.append (table) ;
        a.append (" (") ;
        
        pw.println ("CREATE TABLE " + table + " (") ;
        
        
        
        for (int k = 0 ; k < col ; k++) {
        	if (k > 0) {
        		a.append (",") ;
        	}
        	String s = rmd.getColumnName (k+1) ;
        	
        	if (k == 0 && s.compareTo ("id") == 0) pkinsert = true ;
        	
          a.append (s) ;
          if (m1.containsKey (table) ? ((Map) m1.get (table)).containsKey (s) : false) {
           	misc.Pair y = (misc.Pair) ((Map) m1.get (table)).get (s) ;
           	pw.println ("          " + s + " INT NOT NULL REFERENCES " + y.first () + " (" + y.second () + ")" + (col - k == 1 ? "" : ",")) ;
//          	  System.out.println ("In Tabelle: " + table + " zeigt Spalte: " + s + " auf " + (String) y.first () + "-" + (String) y.second ()) ;
          }
          else {
            pw.println ("          " + s + (k == 0 && s.compareTo ("id") == 0 ? " INT IDENTITY (1,1) PRIMARY KEY" : "") + (col - k == 1 ? "" : ",")) ;
          }
        }
        a.append (")") ;
        a.append (" VALUES (") ;
        pw.println (") ;") ;
        pw.println ("GO") ;
        pw.println ("--") ;
        if (pkinsert) pw.println ("SET IDENTITY_INSERT " + table + " ON") ;
      }

  	  while (r.next ()) {
  	  	StringBuffer b = new StringBuffer () ;
        b.append (a.toString ()) ;
  	    for (int k = 0 ; k < col ; k ++ ) {
  	    	if (k > 0) b.append (", ") ;
  	    	b.append ("\'") ;
  	    	b.append (r.getString (k+1)) ;
  	    	b.append ("\'") ;
  	    }
  	    b.append (") ;") ;
  	    pw.println (b.toString ()) ;
  	  }
  	  r.close () ;
  	  p.close () ;
  	
  	  if (pkinsert) pw.println ("SET IDENTITY_INSERT " + table + " OFF") ;
  	  pw.println ("--") ;
  	  pw.println ("PRINT \'Tabelle " + table + " erstellt und gefüllt.\'") ;
  	  pw.println ("GO") ;
  	  pw.println ("") ;
  	  pw.println ("") ;

  	}
  	{
      for (Iterator i = l1.iterator () ; i.hasNext () ; ) {
    	  String s = (String) i.next () ;
        pw.println ("GRANT SELECT ON " + s + " TO cfg") ;
      }
    }
  	pw.println ("--") ;
  	pw.println ("PRINT \'Fertig\'") ;
  	pw.println ("") ;
  }

	public static void main (String [] args) throws SQLException, DataSourceException {
	  try {
			PrintWriter p = new PrintWriter (new FileOutputStream ("C:\\Temp\\scheme.sql")) ;
      new SchemeExtract ("ServletConfig").doIt (p) ;
      p.flush () ;
    }
    catch (Exception e) { System.exit (1) ; }
    
  }

}


