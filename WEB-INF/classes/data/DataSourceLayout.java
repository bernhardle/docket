// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package data ;

import java.sql.PreparedStatement ;
import java.sql.CallableStatement ;
import java.sql.ResultSet ;
import java.sql.SQLException ;

import java.util.Map ;
import java.util.List ;
import java.util.LinkedList ;
import java.util.Iterator ;
import java.util.Collections ;
import java.util.TreeMap ;
import java.util.HashMap ;
import java.util.Locale ;

import java.text.Format ;
import java.text.MessageFormat ;
import java.text.NumberFormat ;

import misc.Color ;
import misc.Image ;
import misc.Style ;
import misc.Event ;
import misc.Icon ;
import misc.Pair ;
import misc.JumpTarget ; 

import html.BasePage ;
import html.BasePageImpl ;
import html.BodyPage ;
import html.BodyPageImpl ;
import html.ListPage ;
import html.ListPageImpl ;
import html.LoginPage ;
import html.CaptionPage ;

import html.frame.Description ;

public class DataSourceLayout extends DataSourceConfiguration { 

  private Locale l1 = Locale.getDefault () ;
  
  private Map styleCache = java.util.Collections.synchronizedMap (new HashMap ()) ;
  private Map baseCache = java.util.Collections.synchronizedMap (new HashMap ()) ;
  private Map bodyCache = java.util.Collections.synchronizedMap (new HashMap ()) ;

  public DataSourceLayout (String s) throws DataSourceException {
    super (s) ;
    String q = fetchStatement ("query_2031") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        ResultSet r = p.executeQuery () ;
        while (r.next ()) {
        	String s1 = r.getString (1) ;
          int i2 = r.getInt (2) ;
          int i3 = r.getInt (3) ;
          int i4 = r.getInt (4) ;
          boolean b1 = r.getBoolean (5) ;
          boolean b2 = r.getBoolean (6) ;
          boolean b3 = r.getBoolean (7) ;
          boolean b4 = r.getBoolean (8) ;
          int i1 = r.getInt (9) ;
          int i5 = r.getInt (10) ;
          styleCache.put (new Integer (i1), new Style (i1, s1, color (i2), i3, i4, i5, b1, b2, b3, b4)) ;
        }
        r.close () ;
        p.close () ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public Description frameDescription (Locale loc, String key) throws DataSourceException {
    String q = fetchStatement ("query_2011") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        p.setString (2,loc.getLanguage ()) ;
        p.setString (3,loc.getLanguage ()) ;

        ResultSet r = p.executeQuery () ;
        if (r.next ()) {
          int i1 = r.getInt (1) ;														//
          int i2 = r.getInt (2) ;														//
          int i3 = r.getInt (3) ;														//
          int i4 = r.getInt (4) ;														//
          
          String s1 = r.getString (5) ;											//
          String s2 = r.getString (6) ;											// Titel
          String s3 = r.getString (7) ;											// Base URL
          String s4 = r.getString (8) + r.getString (9) ; 	//
          String s5 = r.getString (10) + r.getString (11) ;	//
          String s6 = r.getString (12) + r.getString (13) ;	//
          String s7 = r.getString (14) + r.getString (15) ;	//
          String s8 = r.getString (16) ;										//
          String s9 = r.getString (17) ;										// Metadaten
          int i5 = r.getInt (18) ;													//
          String sa = r.getString (19) + r.getString (20) ;	// Caption URL
          
          List l1 = new LinkedList () ;											// Argumentnamenliste

          r.close () ;
          p.close () ;

          p = con.prepareStatement (fetchStatement ("query_2012")) ;
          p.setInt (1, i5) ;
          r = p.executeQuery () ;

          while (r.next ()) {
            String s10 = r.getString (1) ;
            boolean b1 = r.getBoolean (2) ;
            String s11 = r.getString (3) ;
            l1.add (new html.frame.Argument (s10, s11, b1)) ;
          }
          r.close () ;
          p.close () ;

          return new Description (i5, i1, i2, i3, i4, s1, s2, s3, s4, s5, s6, s7, s8, s9, sa, Collections.unmodifiableList (l1)) ;
        }
        else {
          Object o [] = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final Map icons (int key) throws DataSourceException {
  	String q = fetchStatement ("query_2021") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setInt (1,key) ;
        ResultSet r = p.executeQuery () ;
        HashMap m = new HashMap () ;
        while (r.next ()) {
          String s1 = r.getString (1) ;								//
          String s2 = r.getString (2) ;								//
          Integer i1 = new Integer (r.getInt (3)) ;		//

          m.put (s1,new Pair (i1,s2)) ;
        }

        r.close () ;
        p.close () ;

        for (Iterator i = m.entrySet ().iterator () ; i.hasNext () ; ) {
          Map.Entry x = (Map.Entry) i.next () ;
          Pair y = (Pair) x.getValue () ;
          m.put (x.getKey (), new Icon (image (((Integer) y.first ()).intValue ()), (String) y.second ())) ;
        }

        return Collections.unmodifiableMap (m) ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  public Style style (int key) throws DataSourceException {
    Integer x = new Integer (key) ;
    if (!styleCache.containsKey (x)) {
      Object [] o = {"Style", Integer.toString (key)} ;
      throw new DataSourceException (f3.format (o)) ;
    }
    return (Style) styleCache.get (x) ;
  }

  final Map classes (int key) throws DataSourceException {
  	String q = fetchStatement ("query_2036") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setInt (1,key) ;
        ResultSet r = p.executeQuery () ;
        TreeMap m = new TreeMap () ;
        while (r.next ()) {
          
          String s1 = r.getString (1) ;					//
          int i1 = r.getInt (2) ;								//

          m.put (s1, new Integer (i1)) ;
        }
        r.close () ;
        p.close () ;

        for (Iterator i = m.entrySet ().iterator () ; i.hasNext () ; ) {
          Map.Entry x = (Map.Entry) i.next () ;
          m.put (x.getKey (), style (((Integer) x.getValue ()).intValue ())) ;
        }

        return Collections.unmodifiableMap (m) ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public BasePage basePage (Locale loc, int key) throws DataSourceException {
    Integer x = new Integer (key) ;
    String q = fetchStatement ("query_2041") ;
    if (!baseCache.containsKey (x)) {
      try {
        synchronized (con) {
          PreparedStatement p = con.prepareStatement (q) ;
          p.setInt (1,key) ;
          p.setString (2,loc.getLanguage ()) ;
          ResultSet r = p.executeQuery () ;
          if (r.next ()) {

            String s1 = r.getString (1) ;			// Metadaten
            String s2 = r.getString (2) ;			// Titel
            int i1 = r.getInt (3) ;						// Rand oben
            int i2 = r.getInt (4) ;						// Rand links

            int i3 = r.getInt (5) ;						// Hintergrundfarbe
            int i4 = r.getInt (6) ;						// Link Farbe
            int i5 = r.getInt (7) ;						// Besuchter Link Farbe
            
            int i6 = r.getInt (8) ;						// Hintergrundbild
            String s3 = r.getString (9) ;			// Beschreibung
            
            r.close () ;
            p.close () ;

            Map m1 = Collections.unmodifiableMap (classes (key)) ;
            Map m2 = Collections.unmodifiableMap (icons (key)) ;

            Color c1 = color (i3) ;
            Color c2 = color (i4) ;
            Color c3 = color (i5) ;
            Image g1 = image (i6) ;

            baseCache.put (x, new BasePageImpl (s3, s1, s2, i1, i2, c1, c2, c3, g1, m1, m2, key)) ;
          }
        }
      }
      catch (SQLException e) {
        Object [] o = {q, e.getMessage ()} ;
        throw new DataSourceException (f2.format (o)) ;
      }
    }
    if (!baseCache.containsKey (x)) {
      Object [] o = {q, x.toString ()} ;
      throw new DataSourceException (f1.format (o)) ;
    }
    return (BasePage) baseCache.get (x) ;
  }

  final public BasePage basePage (Locale loc, String key) throws DataSourceException {
    String q = fetchStatement ("query_2046") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {
          int i1 = r.getInt (1) ;			//
          r.close () ;
          p.close () ;
          return basePage (loc,i1) ;
        }
        else {
          Object [] o = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public CaptionPage captionPage (Locale loc, String key) throws DataSourceException {
    String q = fetchStatement ("query_2061") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {
          int i1 = r.getInt (1) ;		// Basislayout
          int i2 = r.getInt (2) ; 	// Höhe
          int i3 = r.getInt (3) ; 	// Breite des Icon
          int i4 = r.getInt (4) ; 	// Breite des ersten Zwischenraums
          int i5 = r.getInt (5) ; 	// Breite des Texts
          int i6 = r.getInt (6) ; 	// Breite des zweiten Zwischenraums
          int i7 = r.getInt (7) ; 	// Breite des Randes
          int i8 = r.getInt (8) ;		// ID

          r.close () ;
          p.close () ;

          BasePage p1 = basePage (loc, i1) ;

          return new CaptionPage (p1, i8, i2, i3, i4, i5, i6, i7) ;
        }
        else {
          Object [] o = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public BodyPage bodyPage (Locale loc, int key) throws DataSourceException {
    Integer x = new Integer (key) ;
    String q = fetchStatement ("query_2051") ;
    if (!bodyCache.containsKey (x)) {
    try {
      synchronized (con) {
       
        PreparedStatement p = con.prepareStatement (q) ;
        p.setInt (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {

          Color c1 = color (r.getInt (1)) ;	// Rahmenfarbe
          Color c2 = color (r.getInt (2)) ;	// Linienfarbe (Umrandung)
         
          int i1 = r.getInt (3) ;						// Breite
          int i2 = r.getInt (4) ;						// Höhe
          int i3 = r.getInt (5) ;						// Rahmenstärke
          int i4 = r.getInt (6) ;						//
          int i5 = r.getInt (7) ;						//
          int i6 = r.getInt (8) ;						//
          int i7 = r.getInt (9) ;						// Basis-ID
          int i8 = r.getInt (10) ;					// ID

          r.close () ;
          p.close () ;

          BasePage p1 = basePage (loc, i7) ;

          bodyCache.put (x, new BodyPageImpl (p1, c1, c2, i1, i2, i3, i4, i5, i6, i8)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
    }
    if (!bodyCache.containsKey (x)) {
      Object [] o = {q, Integer.toString(key)} ;
      throw new DataSourceException (f1.format (o)) ;
    }
    return (BodyPage) bodyCache.get (x) ;
  }

  final public BodyPage bodyPage (Locale loc, String key) throws DataSourceException {
    String q = fetchStatement ("query_2056") ; 
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {         

          int i1 = r.getInt (1) ;

          r.close () ;
          p.close () ;

          return bodyPage (loc, i1) ;
        }
        else {
          Object [] o = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public ListPage listPage (Locale loc, int i) throws DataSourceException {
  	String q = fetchStatement ("query_2066") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setInt (1,i) ;
//        p.setString (2,loc.getLanguage ()) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {         

          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;
          int i3 = r.getInt (3) ;
          int i4 = r.getInt (4) ;
          int i5 = r.getInt (5) ;
          int i6 = r.getInt (6) ;
          String s1 = r.getString (7) ;

          r.close () ;
          p.close () ;

          BodyPage p1 = bodyPage (loc,i1) ;

          return new ListPageImpl (p1, s1, i2, i3, i4, i5, i6) ;
        }
        else {
          Object o [] = {q, Integer.toString (i)} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
  
  final public ListPage listPage (Locale loc, String key) throws DataSourceException {
    String q = fetchStatement ("query_2067") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {         

          int i1 = r.getInt (1) ;

          r.close () ;
          p.close () ;

          return listPage (loc, i1) ;
        }
        else {
          Object [] o = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
  
  final public int addLayoutStyle (int layout, int color) throws DataSourceException {
    String q = fetchStatement ("query_2068") ; 
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setInt (2,layout) ;
        p.setInt (3,color) ;
        p.execute () ;
        int uid = p.getInt (1) ;
        p.close () ;
        return uid ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
  
  final public int updateLayoutStyle (int color) throws DataSourceException {
    String q = fetchStatement ("query_2069") ; 
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setInt (2,color) ;
        p.execute () ;
        int uid = p.getInt (1) ;
        p.close () ;
        return uid ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
}