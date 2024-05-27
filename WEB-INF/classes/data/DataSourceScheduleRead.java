// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package data ;

import java.sql.Date ;
import java.sql.Timestamp ;
import java.sql.SQLException ;
import java.sql.Statement ;
import java.sql.ResultSet ;
import java.sql.PreparedStatement ;
import java.sql.CallableStatement ;

import java.util.Map ;
import java.util.List ;
import java.util.Vector ;
import java.util.Random ;
import java.util.TreeMap ;
import java.util.Iterator ;
import java.util.Properties ;
import java.util.LinkedList ;
import java.util.Collection ;
import java.util.Collections ;

import java.text.DateFormat ;

import misc.Pair ;
import misc.Assign ;
import misc.Color ;
import misc.DType ;
import misc.Context ;
import misc.Detail ;
import misc.Ticket ;
import misc.Option ;
import misc.Event ;
import misc.Result ;
import misc.Notification ;
import misc.AutoDeadline ;
import misc.AutoDeadlinePreview ;
import misc.AutoContinuation ;
import misc.AutoNotification ;
import misc.Deadline ;
import misc.Notification ; 

public class DataSourceScheduleRead extends DataSourceBase {

//  static Map colorCacheBucket = Collections.synchronizedMap (new java.util.HashMap ()) ;
  static Map contextCacheBucket = Collections.synchronizedMap (new java.util.HashMap ()) ;
  static Map dtypeCacheBucket = Collections.synchronizedMap (new java.util.HashMap ()) ;

  private Map /* colorCache, */ contextCache, dtypeCache ;

//  final Color color (int i) {
//    return (Color) colorCache.get (new Integer (i)) ;	
//  }
  
  final Context context (int i) {
    return (Context) contextCache.get (new Integer (i)) ;	
  }

  final public DType dType (int i) {
    return (DType) dtypeCache.get (new Integer (i)) ;	
  }

  public DataSourceScheduleRead (String s) throws DataSourceException {
    super (s) ;
    String q = "" ;
    try {
    	  synchronized (con) {
/*
    			if (! colorCacheBucket.containsKey (s)) {
    				q = fetchStatement ("query_3001") ;
            CallableStatement p = con.prepareCall (q) ;
            ResultSet r = p.executeQuery () ;
            Map c = new java.util.HashMap (10) ;
            while (r.next ()) {         	
              int i1 = r.getInt (1) ;				// ID
              String s1 = r.getString (2) ;	// Kurz-Label
              int i2 = r.getInt (3) ;				// R
              int i3 = r.getInt (4) ;				// G
              int i4 = r.getInt (5) ;				// B
              c.put (new Integer (i1), new Color (i1, s1, i2, i3, i4)) ;
            }
            r.close () ;
            p.close () ;
            colorCacheBucket.put (s, c) ;
          }
          colorCache = (Map) colorCacheBucket.get (s) ;
*/
          if (! contextCacheBucket.containsKey (s)) {
          	q = fetchStatement ("query_3002") ;
            CallableStatement p = con.prepareCall (q) ;
            ResultSet r = p.executeQuery () ;
            Map c = new java.util.HashMap () ;
            while (r.next ()) {
              int i1 = r.getInt (1) ;								// ID
              String s1 = r.getString (2) ;					// Kurz-Label
              String s2 = r.getString (3) ;					// Beschreibung
              int i2 = r.getInt (4) ;								// Farbe
              c.put (new Integer (i1), new Context (i1, i2, s1, s2)) ;
            }
            r.close () ;
            p.close () ;
            contextCacheBucket.put (s, c) ;
          }
          contextCache = (Map) contextCacheBucket.get (s) ;
          
          q = fetchStatement ("query_3003") ;
          CallableStatement p = con.prepareCall (q) ;
          ResultSet r = p.executeQuery () ;
          Map c = new java.util.HashMap () ;
          while (r.next ()) {
            int i1 = r.getInt (1) ;									// ID
            String s1 = r.getString (2) ;						// Mini-Label
            String s2 = r.getString (3) ;						// Label
            int i2 = r.getInt (4) ;									// Rang
            int i3 = r.getInt (5) ;									// Farbe
            int i4 = r.getInt (6) ;									// Max. WV
            int i5 = r.getInt (7) ;									// Max. Kommentare
            boolean b1 = r.getBoolean (8) ;					// 'predel'
            Context x1 = context (r.getInt (9)) ;		// Context-ID
            String s3 = r.getString (10) ;					// Beschreibung
            boolean b2 = r.getBoolean (11) ;				// Fixed
            c.put (new Integer (i1), new DType (i1, s1, s2, i2, i3, i4, i5, x1, s3,b2)) ;
          }
          r.close () ;
          p.close () ;
          dtypeCacheBucket.put (s, c) ;
    	  }
    	  dtypeCache = (Map) dtypeCacheBucket.get (s) ;
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List optionList (String s) throws DataSourceException {
  	String q = fetchStatement (s) ;
  	try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        ResultSet r = p.executeQuery () ;
        List l = new LinkedList () ;
        while (r.next ()) {
        	int i1 = r.getInt (1) ;
        	String s1 = r.getString (2) ;
        	l.add (new Option (i1, s1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List assignList () throws DataSourceException {
  	return optionList ("query_3011") ;
  }

  final public List typeboundedForms () throws DataSourceException {
    return optionList ("query_5010") ;	
  }

  final public List typeunboundedForms () throws DataSourceException {
    return optionList ("query_5020") ;	
  }

  final List autoAssignList (int i) throws DataSourceException {
  	String q = fetchStatement ("query_3021") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, i) ;
        ResultSet r = p.executeQuery () ;
        List l = new LinkedList () ;
        while (r.next ()) {
        	int i1 = r.getInt (1) ;
        	String s1 = r.getString (2) ;
        	l.add (new Option (i1, s1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final List autoNotificationList (int i) throws DataSourceException {
  	String q = fetchStatement ("query_3031") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, i) ;
        ResultSet r = p.executeQuery () ;
        List l = new LinkedList () ;
        while (r.next ()) {
        	int i1 = r.getInt (1) ;
        	int i2 = r.getInt (2) ;
        	boolean b1 = r.getBoolean (3) ;
        	l.add (new AutoNotification (i1, i2, b1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List typeList (int i) throws DataSourceException {
  	String q = fetchStatement ("query_3041") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, i) ;
        ResultSet r = p.executeQuery () ;
        List l = new LinkedList () ;
        while (r.next ()) {
     	    int i1 = r.getInt (1) ;
         	String s1 = r.getString (2) ;
/**********/     	    l.add (new Option (i1, s1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ; 
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

//  final public List colorList () {
//  	List l = new LinkedList () ;
//  	for (Iterator i = colorCache.entrySet ().iterator () ; i.hasNext () ; ) {
//  		Color c = (Color) ((Map.Entry) i.next ()).getValue () ;
//  	  l.add (new Option (c.id (), c.label (), c)) ;
//  	}
//  	return Collections.unmodifiableList (l) ;
//  }

  final public List contextList () {
  	List l = new LinkedList () ;
  	for (Iterator i = contextCache.entrySet ().iterator () ; i.hasNext () ; ) {
  		Context c = (Context) ((Map.Entry) i.next ()).getValue () ;
/**********/  	  l.add (new Option (c.id (), c.label () /*, c.color ()*/)) ;
  	}
  	return Collections.unmodifiableList (l) ;
  }

  final public List typeList (boolean includeFixed) throws DataSourceException {
    List l = new LinkedList () ;
    for (Iterator i = dtypeCache.entrySet ().iterator () ; i.hasNext () ; ) {
    	Map.Entry e = (Map.Entry) i.next () ;
    	DType b = (DType) e.getValue () ;
/************/    	if (! b.fixed () || includeFixed) l.add (new Option (b.id (), b.label () /*, b.color () */)) ;
    }
    return Collections.unmodifiableList (l) ;
  }

  final public AutoDeadline autoDeadline (int i) throws DataSourceException {
  	String q = fetchStatement ("query_3051") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, i) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) { 
          String label = r.getString (1) ;
          String desc = r.getString (2) ;
          r.close () ;
          p.close () ;
          return new AutoDeadline (i, label, desc, typeList (i), autoNotificationList (i), autoAssignList (i)) ;
        }
        else {
        	Object [] o = {q, Integer.toString (i)} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List autoDeadlinePreviewList (int i) throws DataSourceException {
  	String q = fetchStatement ("query_3061") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, i) ;
        ResultSet r = p.executeQuery () ;
        TreeMap m = new TreeMap () ;
        while (r.next ()) {
        	Integer i1 = new Integer (r.getInt (1)) ;
        	Integer i2 = new Integer (r.getInt (2)) ;
        	m.put (i1, i2) ;
        }
        r.close () ;
        p.close () ;

        q = fetchStatement ("query_3062") ;
        p = con.prepareCall (q) ;
        p.setInt (1, i) ;
        r = p.executeQuery () ;
        List l = new LinkedList () ;
        while (r.next ()) {
          Integer j = new Integer (r.getInt (1)) ;
          String s1 = r.getString (2) ;
          l.add (new AutoDeadlinePreview (j.intValue (), m.containsKey (j) ? ((Integer) m.get (j)).intValue () : 0, s1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List loginNameList (boolean showSystemUsers, boolean showInactiveUsers, boolean longFormat) throws DataSourceException {
    String q = fetchStatement ("query_3071") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        ResultSet r = p.executeQuery () ;
        List l = new LinkedList () ;
        while (r.next ()) {
          String s1 = r.getString (1) ;
          String s2 = r.getString (2) ;
          int i1 = r.getInt (3) ;
          boolean b1 = r.wasNull () ;
          boolean b2 = r.getBoolean (4) ;
          boolean b3 = r.getBoolean (5) ;
          int i2 = r.getInt (6) ;
          if (b1 ? (b3 || showInactiveUsers) : (b2 || showInactiveUsers) && showSystemUsers) l.add (new Option (i2, longFormat ? s2 : s1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List shiftBaseList () throws DataSourceException {
  	return optionList ("query_3081") ;
  }

  final public Assign assign (int aid) throws DataSourceException {
  	String q = fetchStatement ("query_3010") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,aid) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {
          int i1 = r.getInt (1) ;
          String s1 = r.getString (2) ;
          String s2 = r.getString (3) ;

          r.close () ;
          p.close () ;
          return new Assign (aid, i1, s1, s2) ;
        }
        else {
        	Object [] o = {q, Integer.toString (aid)} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public Ticket userTicket (int uid) throws DataSourceException {
  	String q = fetchStatement ("query_3091") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,uid) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {
          String h = r.getString (1) ;
          String i = r.getString (2) ;
        	boolean b1 = r.getBoolean (3) ;
        	boolean b2 = r.getBoolean (4) ;
        	boolean b3 = r.getBoolean (5) ;
        	r.getInt (6) ;
          boolean t = r.wasNull () ;
          boolean b4 = r.getBoolean (7) ;
          boolean b5 = r.getBoolean (8) ;
          boolean b6 = r.getBoolean (9) ;
          boolean b7 = r.getBoolean (10) ;
          String f = r.getString (11) ;
          String g = r.getString (12) ;
          int j = r.getInt (13) ;
          boolean b8 = r.getBoolean (14) ;
          int k = r.getInt (15) ;						// Anzahl der zugew. Bearbeiterkürzel
          boolean a = t ? b1 : b4 ;
          boolean b = t ? b2 : b5 ;
          boolean c = t ? b3 : b6 ;
          boolean d = t ? b8 : b7 ;
          boolean e = ! t ;

          r.close () ;
          p.close () ;
          return new Ticket (j, h, i, a, b, c, d, e, f, g, k) ;
        }
        else {
        	Object [] o = {q, Integer.toString (uid)} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public Date dateFromID (int i) throws DataSourceException {
  	String q = fetchStatement ("query_3100") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,i) ;
        ResultSet r = p.executeQuery () ;

        if (!r.next ()) {
          Object [] o = {q, Integer.toString (i)} ;
          throw new DataSourceException (f1.format (o)) ;
        }
        Date d1 = r.getDate (1) ; 
        r.close () ;
        p.close () ; 
        return d1 ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }	
  }

  final public Detail detail (int i)  throws DataSourceException {
  	String q = fetchStatement ("query_3101") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,i) ;

        ResultSet r = p.executeQuery () ;

        if (!r.next ()) {
        	Object [] o = {q, Integer.toString (i)} ;
          throw new DataSourceException (f1.format (o)) ;
        }

        Date d1 = r.getDate (1) ; 						// Datum
        String s1 = r.getString (2) ;					// Aktenzeichen
        String s2 = r.getString (3) ;					// Betreff
        String s3 = r.getString (4) ;					// Beschreibung
        DType t1 = dType (r.getInt (5)) ;	// Typ
        boolean b1 = r.getBoolean (6) ;				// Erledigt
        String s4 = r.getString (7) ;					// Bearbeiter
        String s5 = r.getString (8) ;					// Benutzer
        int i1 = r.getInt (9) ;								// ID-Basiseintrag
        r.close () ;
        p.close () ;

        return new Detail (i1, d1, t1, b1, s1, s2, s3, s4) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public Notification notification (int i) throws DataSourceException {
  	String q = fetchStatement ("query_3111") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,i) ;
        ResultSet r  = p.executeQuery () ;
        
        if (!r.next ()) {
        	r.close () ;
        	p.close () ;
        	throw new DataSourceException ("No matching row in \'notification\' for \'id\': " + i) ;
        }
        
        int i1 = r.getInt (1) ;									// WV-ID
        Date d1 = r.getDate (2) ;								// WV Datum
        boolean b1 = r.getBoolean (3) ;					// WV erledigt
        int i2 = r.getInt (4) ;									// Basis-ID
        Date d2 = r.getDate (5) ;								// Frist Datum
        String s1 = r.getString (6) ;						// Aktenzeichen
        StringBuffer s2 = new StringBuffer () ;	//
        s2.append (r.getString (7)) ;						//
        s2.append (" ") ;												//
        s2.append (r.getString (8)) ;						// Betreff + Bemerkung
        boolean b2 = r.getBoolean (9) ;					// Frist erledigt
        DType t1 = dType (r.getInt (10)) ;			// Typ

        r.close () ;
        p.close () ;
        
        return new Notification (new Deadline (i2, d2, s1, s2.toString (), b2, t1), i1, d1, b1) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List notificationList (Detail d) throws DataSourceException {
  	String q = fetchStatement ("query_3121") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, d.id ()) ;
        ResultSet r  = p.executeQuery () ;
        LinkedList x = new LinkedList () ;
        
        while (r.next ()) {
          int i1 = r.getInt (1) ;										// WV-ID
          Date d1 = r.getDate (2) ;									// WV Datum
          boolean b1 = r.getBoolean (3) ;						// WV erledigt
          int i2 = r.getInt (4) ;										// Basis-ID
          Date d2 = r.getDate (5) ;									// Fristende
          String s1 = r.getString (6) ;							// Aktenzeichen
          StringBuffer b = new StringBuffer () ;		//
          b.append (r.getString (7)) ;
          b.append ("/") ;
          b.append (r.getString (8)) ;							
          String s2 = b.toString () ;								// Betreff + Bemerkung
          boolean b2 = r.getBoolean (9) ;						// Frist erledigt
          DType t1 = dType (r.getInt (10)) ;				// Typ
          
          x.add (new Notification (new Deadline (i2, d2, s1, s2, b2, t1), i1, d1, b1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (x) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }
  
  final public List eventList (Detail d) throws DataSourceException {
  	String q = fetchStatement ("query_3131") ;
    try {
      synchronized (con) {
        q = fetchStatement ("query_3132") ;
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, d.id ()) ;
        ResultSet r = p.executeQuery () ;
        List x = new LinkedList () ;
        
        while (r.next ()) { 
          int i1 = r.getInt (1) ;							// Event-ID
          Timestamp d1 = r.getTimestamp (2) ;	// Datum
          String s1 = r.getString (3) ;				//
          String s2 = r.getString (4) ;				//
          String s3 = r.getString (5) ;				//
          String s4 = r.getString (6) ;				//
          int i2 = r.getInt (7) ;							// Typ-ID
          
          x.add (new Event (i1, i2, d1, s3, s2, s1, s4)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (x) ;
      }
    } catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public Date nextBefore (Date d) throws DataSourceException {
    String q = fetchStatement ("query_3141") ;
    try {
      synchronized (con) {      	
        CallableStatement p = con.prepareCall (q) ;
        p.setTimestamp (1, new Timestamp (d.getTime ())) ;
        ResultSet r  = p.executeQuery () ;
        Date d1 = r.next () ? r.getDate (1) : null ;
        r.close () ;
        p.close () ;
        return d1 ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List deadlineOV (Date d) throws DataSourceException {
  	String q = fetchStatement ("query_3151") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setTimestamp (1,new Timestamp(d.getTime())) ;
        ResultSet r  = p.executeQuery () ;
        LinkedList l = new LinkedList () ;
        while (r.next ()) {
          int i1 = r.getInt (1) ;									// Basis-ID
          Date d1 = r.getDate (2) ;								// Fristende
          String s1 = r.getString (3) ;						// Aktenzeichen
          StringBuffer s2 = new StringBuffer () ;	//
          s2.append (r.getString (4)) ;						//
          s2.append (" ") ;												//
          s2.append (r.getString (5)) ;						// Betreff + Bemerkung
          boolean b1 = r.getBoolean (6) ;					// Erledigt (j/n)
          DType t1 = dType (r.getInt (7)) ;		// Typ
          
          l.add (new Deadline (i1, d1, s1, s2.toString (), b1, t1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public List notificationOV (Date d) throws DataSourceException {
  	String q = fetchStatement ("query_3161") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setTimestamp (1, new Timestamp (d.getTime ())) ;
        ResultSet r  = p.executeQuery () ;
        LinkedList l = new LinkedList () ;
        while (r.next ()) {											
          int i1 = r.getInt (1) ;								// WV-ID
          Date d1 = r.getDate (2) ;							// WV Datum
          boolean b1 = r.getBoolean (3) ;				// WV erledigt (j/n)
          int i2 = r.getInt (4) ;								// Basis-ID
          Date d2 = r.getDate (5) ;							// Fristende
          String s1 = r.getString (6) ;					// Aktenzeichen
          StringBuffer s2 = new StringBuffer () ;
          s2.append (r.getString (7)) ;					//
          s2.append (" ") ;											//
          s2.append (r.getString (8)) ;					// Betreff + Bemerkung
          boolean b2 = r.getBoolean (9) ;				// Frist erledigt (j/n)
          DType t1 = dType (r.getInt (10)) ;	// Typ

          l.add (new Notification (new Deadline (i2, d2, s1, s2.toString (), b2, t1), i1, d1, b1)) ;
        }
        r.close () ;
        p.close () ;
        return Collections.unmodifiableList (l) ;
      }
    } 
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public Result eventByDate (Date bd, Date ed) throws DataSourceException {
  	String q = fetchStatement ("query_3162") ;
    try {
    	synchronized (con) {
    		
        CallableStatement p = con.prepareCall (q) ;
        
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setTimestamp (2, new Timestamp (bd.getTime ())) ;
        p.setTimestamp (3, new Timestamp (ed.getTime ())) ;
        
        ResultSet r = p.executeQuery () ;
        
        int i1 = p.getInt (1) ;		// Anzahl der Zeilen
        
        r.close () ;
        p.close () ;
        
        return null ; 						// new Result () ;
      }
   	} 
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public AutoContinuation autoContinuation (int id) throws DataSourceException {
  	String q = fetchStatement ("query_3171") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,id) ;
        ResultSet r  = p.executeQuery () ;
        AutoContinuation x = null ;
        if (r.next ()) {
        	int i1 = r.getInt (1) ;					//
        	int i2 = r.getInt (2) ;					//
        	String s1 = r.getString (3) ;		//
        	int i3 = r.getInt (4) ;					//
        	String s2 = r.getString (5) ;		//
        	boolean b1 = r.getBoolean (6) ;	//
          x = new AutoContinuation (i1, i2, s1, i3, s2, b1) ;
        }
        r.close () ;
        p.close () ;
        return x ;
      } 
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public Result search (String txt, String mta, int len, int cut, int max) throws DataSourceException {
			// Argumentprüfung
    if (max < 1 || len < 1 || cut < 0 || max < len || cut * len > max || txt == null || mta == null) {
      throw new IllegalArgumentException ("search") ;	
    }

    String q = fetchStatement ("query_3181") ;
    int beg = (len * cut) ;
    int tln = (len + beg) < max ? len : max - beg ;
    int end = beg + tln ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setString (2,txt) ;
        p.setString (3,mta) ;
        p.setInt (4, max + 1) ;
        
        ResultSet r = p.executeQuery () ;
        
        int all = 0 ;
        
        Vector x = new Vector (tln) ;
       
        boolean b = false ;
        
        for (int i = 0 ; (i < beg) ? r.next () : false ; i ++, all ++) ;

        int cnt = 0 ;
        
        for (int i = 0 ; (i < tln) ? r.next () : false ; i ++, cnt ++, all ++, x.add (new Integer (r.getInt (1)))) ;
        	
        for ( ; r.next () ; all ++, b = true) ;
      
        x.trimToSize () ;
        
        r.close () ;
        p.close () ;
        
        return new Result (x, all > max ? max : all, beg, beg + cnt, max, b) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public Result workload (Date begd, Date endd, int asd, boolean alld, int len, int cut) throws DataSourceException {
// Der Maximalwert steht auch fest in der Abfrage (aus technischen Gründen) - nicht mehr lange.
  	final int max = 1000 ;
  	
// Argumentprüfung
    if (max < 1 || len < 1 || cut < 0 || max < len || cut * len > max || begd == null || endd == null) {
      throw new IllegalArgumentException ("FATAL: Wrong argument in workload ()") ;
    }

    int beg = (len * cut) ;
    int tln = (len + beg) < max ? len : max - beg ;
    int end = beg + tln ;
    String q = fetchStatement ("query_3191") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        
        p.setTimestamp (1, new Timestamp (begd.getTime ())) ;
        p.setTimestamp (2, new Timestamp (endd.getTime ())) ;
        p.setInt (3, alld ? 1 : 0) ;
        p.setInt (4, asd) ;
        
        ResultSet r = p.executeQuery () ;
        
        Vector x = new Vector (tln) ;

// Vorlaufen bis zum Anfang ...
        int all = 0 ;
        boolean b = false ;
        
        for (int i = 0 ; (i < beg) ? r.next () : false ; i ++, all ++) ;

        int cnt = 0 ;
        for (int i = 0 ; (i < tln) ? r.next () : false ; i ++, all ++, cnt ++, x.add (new Integer (r.getInt (1)))) ;
        
        for ( ; r.next () ; all ++, b = true) ;

        x.trimToSize () ;
        
        r.close () ;
        p.close () ;
        
        return new Result (x, all > max ? max : all, beg, beg + cnt, max, b) ;
      }
    }
    catch (SQLException e) {
       Object [] o = {q, e.getMessage ()} ;
       throw new DataSourceException (f3.format (o)) ;
    }
  }
}