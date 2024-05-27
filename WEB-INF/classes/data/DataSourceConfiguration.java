// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package data ;

import java.sql.SQLException ;
import java.sql.PreparedStatement ;
import java.sql.Statement ;
import java.sql.ResultSet ;

import java.sql.SQLWarning ;

import misc.Color ;
import misc.Image ;
import misc.Option ;
import misc.Caption ;
import misc.Jump ;
import misc.JumpTarget ;
import misc.Permissions ;

import html.template.Description ;

import java.util.Map ;
import java.util.List ;
import java.util.Locale ;
import java.util.HashMap ;
import java.util.Iterator ;
import java.util.TreeMap ;
import java.util.Vector ;
import java.util.Properties ;
import java.util.ResourceBundle ;
import java.util.Collections ;
import java.util.LinkedList ;

final class ListResourceBundleImpl extends java.util.ListResourceBundle {
  Object [][] contents = new Object [0][] ;

  ListResourceBundleImpl (Object [][] a) {
    if (a != null) contents = a ;
  }

  public Object [][] getContents() {
    return contents;
  }
}

public class DataSourceConfiguration extends DataSourceBase {

  private Map imageCache = Collections.synchronizedMap (new HashMap ()) ;
  private Map colorCache = Collections.synchronizedMap (new HashMap ()) ;
  private Map jumpsCache = Collections.synchronizedMap (new HashMap ()) ;
  
  public DataSourceConfiguration (String s) throws DataSourceException {
    super (s) ;
    synchronized (con) {
    	String q = fetchStatement ("query_1041") ;
      try { 
        Statement p = con.createStatement () ;
        ResultSet r = p.executeQuery (q) ;
        while (r.next ()) {
          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;
          int i3 = r.getInt (3) ;
          int i4 = r.getInt (4) ;
          String s1 = r.getString (5) ;
           
          colorCache.put (new Integer (i4), new Color (i4, s1, i1, i2, i3)) ;
        }
        {
          SQLWarning w = p.getWarnings () ;
          while (w != null) {
            System.err.println (w) ;
            w = w.getNextWarning () ;
          }
        }
        r.close () ;
        p.close () ;
        
        q = fetchStatement ("query_1051") ;
        p = con.createStatement () ;
        r = p.executeQuery (q) ;
        while (r.next ()) {
          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;
          int i3 = r.getInt (3) ;
          int i4 = r.getInt (4) ;
          String s1 = r.getString (5) + r.getString (6) ;
        
          imageCache.put (new Integer (i1), new Image (i1,s1,i2,i3,i4)) ;
        }

        r.close () ;
        p.close () ;
        
        q = fetchStatement ("query_1052") ;
        p = con.createStatement () ;
        r = p.executeQuery (q) ;
        while (r.next ()) {
          int i1 = r.getInt (1) ;				// id
          String s1 = r.getString (2) ;	// name
          String s2 = r.getString (3) ;	// base
          String s3 = r.getString (4) ;	// url
          String s4 = r.getString (5) ;	// target
        
          jumpsCache.put (new Integer (i1), new Jump (s1, s2, s3, s4)) ;
        }

        r.close () ;
        p.close () ;
      }
      catch (SQLException e) {
    	  Object o [] = {q, e.getMessage ()} ;
        throw new DataSourceException (f3.format (o)) ;
      }
    }
  }

  public Properties properties (String major) throws DataSourceException {
  	String q = fetchStatement ("query_1011") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,major) ;
        
        ResultSet r = p.executeQuery () ;

        Properties x = new Properties () ;

        while (r.next ()) {
          x.setProperty (r.getString (1), r.getString (2)) ;
        }

        r.close () ;
        p.close () ;
          
        return x ;
      }
    }
    catch (SQLException e) {
    	Object o [] = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }

  public ResourceBundle resourceBundle (String major) throws DataSourceException {
  	String q = fetchStatement ("query_1021") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,major) ;
        p.setString (2,Locale.getDefault ().getLanguage ()) ;

        ResultSet r = p.executeQuery () ;
        Vector v = new Vector (0,50) ;

        while (r.next ()) {
          Object [] x = new Object [2] ;
          x [0] = r.getString (1) ;
          x [1] = r.getString (2) ;
          v.add (x) ;
        }

        r.close () ;
        p.close () ;

        Object [][] y = new Object [v.size ()][] ;

        for (int i = 0 ; i < v.size () ; i++) y [i] = (Object []) v.get (i) ;
          
        return new ListResourceBundleImpl (y)  ;
      }
    }
    catch (SQLException e) {
    	Object o [] = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }

  public Color color (int key) throws DataSourceException {
    Integer x = new Integer (key) ;
    if (!colorCache.containsKey (x)) {
    	Object o [] = {"color", x.toString ()} ;
      throw new DataSourceException (f4.format (o)) ;
    } 
    return (Color) colorCache.get (x) ;
  }

  public List colors () throws DataSourceException {
  	List l = new LinkedList () ;
    for (Iterator i = colorCache.entrySet ().iterator () ; i.hasNext () ; ) {
    	Map.Entry e = (Map.Entry)i.next () ;
    	Integer k = (Integer) e.getKey () ;
    	Color c = (Color) e.getValue () ;
      l.add (new misc.Option (k.intValue (), c.label (), c)) ; 
    }
    return Collections.unmodifiableList (l) ;
  }

  public Image image (int key) throws DataSourceException {
    Integer x = new Integer (key) ;
    if (!imageCache.containsKey (x)) {
    	Object o [] = {"image", x.toString ()} ;
      throw new DataSourceException (f4.format (o)) ;
    }
    return (Image) imageCache.get (x) ;
  }

  public Jump jump (int key) throws DataSourceException {
  	Integer x = new Integer (key) ;
    if (!jumpsCache.containsKey (x)) {
    	Object o [] = {"jump", x.toString ()} ;
      throw new DataSourceException (f4.format (o)) ;
    }
    return (Jump) jumpsCache.get (x) ;
  }
  
  public Caption caption (Locale loc, String key) throws DataSourceException {
  	String q = fetchStatement ("query_1061") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        p.setString (2,loc.getLanguage ()) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {

          String s1 = r.getString (1) ;
          String s2 = r.getString (2) ;
          String s3 = r.getString (3) ;

          r.close () ;
          p.close () ;
        
          return new Caption (s1, s2, s3) ;
        }
        else {
   	      Object o [] = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
    	Object o [] = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }

  public List getMonths (Locale loc) throws DataSourceException {
  	String q = fetchStatement ("query_1071") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,loc.getLanguage ()) ;
        ResultSet r = p.executeQuery () ;
        List x = new LinkedList () ;
        while (r.next ()) {
        	int i1 = r.getInt (1) ;
        	String s1 = r.getString (2) ;
        	Color c1 = new Color (0,0,0) ;
        	x.add (new Option (i1, s1, c1)) ;
        }
        r.close () ;
        p.close () ;

        return Collections.unmodifiableList (x) ;
      }
    }
    catch (SQLException e) {
     	Object o [] = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }

  public misc.Menue menue (String key, Permissions pms) throws DataSourceException {
  	String q = fetchStatement ("query_1076") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,Locale.getDefault ().getLanguage ()) ;
        p.setString (2,key) ;
        p.setBoolean (3, pms.permLgn ()) ;
        p.setBoolean (4, pms.permAdm ()) ;
        p.setBoolean (5, pms.permCrt ()) ;
        p.setBoolean (6, pms.permDel ()) ;
        ResultSet r = p.executeQuery () ;
        List x = new LinkedList () ;
        while (r.next ()) {
        	int i1 = r.getInt (1) ;
        	String s1 = r.getString (2) ;
        	String s2 = r.getString (3) ;
        	x.add (new misc.Item (jump (i1), s1, s2)) ;
        }
        r.close () ;
        p.close () ;
       
        q = fetchStatement ("query_1077") ;
        p = con.prepareStatement (q) ;
        p.setString (1,Locale.getDefault ().getLanguage ()) ;
        p.setString (2,key) ;
        r = p.executeQuery () ;
        
        String s3 = r.next () ? r.getString (1) : "" ;

        r.close () ;
        p.close () ;
        
        return new misc.Menue (Collections.unmodifiableList (x), s3) ;
      }
    }
    catch (SQLException e) {
    	Object o [] = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }

  public Description templateDescription (Locale loc, String key) throws DataSourceException {
  	String q = fetchStatement ("query_1081") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        p.setString (2,loc.getLanguage ()) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {

          String s1 = r.getString (1) ;
          StringBuffer b1 = new StringBuffer () ;
          b1.append (r.getString (2)) ;
          b1.append (r.getString (3)) ;
          String s2 = b1.toString () ;
          
          r.close () ;
          p.close () ;

          return new Description (s1,s2) ;
        }
        else {
   	      Object o [] = {q, key} ;
          throw new DataSourceException (f3.format (o)) ;
       }
      }
    }
    catch (SQLException e) {
    	Object o [] = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    } 
  }
}