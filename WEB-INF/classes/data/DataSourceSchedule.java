// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package data ;

import java.sql.Date ;
import java.sql.Timestamp ;
import java.sql.Statement ;
import java.sql.ResultSet ;
import java.sql.Connection ;
import java.sql.SQLException ;
import java.sql.PreparedStatement ;
import java.sql.CallableStatement ;

import java.util.List ;
import java.util.Vector ;
import java.util.LinkedList ;

import java.security.SecureRandom ;

import dynamic.meta.Meta ;

public class DataSourceSchedule extends DataSourceScheduleRead {

  private SecureRandom rnd = new SecureRandom () ;

  public DataSourceSchedule (String s) throws DataSourceException {
    super (s) ;
  }

  final public void hideDeadline (int i, int uid, String com) throws DataSourceException {
    String q = fetchStatement ("query_4010") ;
    try {
      synchronized (con) {    	
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,i) ;
      	p.setInt (2,uid) ;
      	p.setString (3,com) ;
      	p.execute () ;
      	p.close () ;    	
      }
    } catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public void hideDeadline (int i, int uid) throws DataSourceException {
    hideDeadline (i, uid, "") ;
  }

  final public void hideNotification (int i, int uid, String com) throws DataSourceException {
    String q = fetchStatement ("query_4010") ;
    try {
      synchronized (con) {    	
      	CallableStatement p = con.prepareCall (q) ;
        p.setInt (1,i) ;
      	p.setInt (2,uid) ;
      	p.setString (3,com) ;
      	p.execute () ;
      	p.close () ;
      }
    } catch (SQLException e) {
    	Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public void hideNotification (int i, int uid) throws DataSourceException {
    hideNotification (i, uid, "") ;
  }

  final public boolean setPassword (int uid, String w) throws DataSourceException {
  	String q = fetchStatement ("query_4020") ;
    try {
      synchronized (con) {    	
        String s = Integer.toHexString (rnd.nextInt ()) ;
        String h = Integer.toHexString (new String (w + s).hashCode ()) ;
        CallableStatement p = con.prepareCall (q) ;
        p.setString (1,s) ;
        p.setString (2,h) ;
        p.setInt (3,uid) ;
        boolean b1 = (p.executeUpdate () == 1) ? true : false ;
        p.close () ;
        return b1 ;
      }
    }
    catch (SQLException e) {
    	Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public int createLogin (String k, String n, String w) throws DataSourceException {
  	String q = fetchStatement ("query_4030") ;
    try {
      synchronized (con) {    	
       String s = Integer.toHexString (rnd.nextInt ()) ;
        String h = Integer.toHexString (new String (w + s).hashCode ()) ;
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setString (2,k) ;
        p.setString (3,n) ;
        p.setString (4,s) ;
        p.setString (5,h) ;
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
 

  void seclog (String msg, int typ) throws DataSourceException {
  	String q = fetchStatement ("query_4080") ;
    try {
      synchronized (con) {    	
        CallableStatement p = con.prepareCall (q) ;
        p.setInt (1, typ) ;
        p.setString (2, msg) ;
        p.executeUpdate () ;
        p.close () ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  public void traceFailure (String shd, String ipaddr) {
    try {
      seclog ("invalid attempt to login as user " + shd + " from " + ipaddr, 3) ;
    }
    catch (DataSourceException e) {
      System.err.println (e.getMessage ()) ;
    }
  }

  public void logInfo (String s) {
    try {
      seclog (s,1) ;
    }
    catch (DataSourceException e) {
    	System.err.println (e.getMessage ()) ;
    }
  }

  public void logWarning (String s) {
    try {
      seclog (s,2) ;
    }
    catch (DataSourceException e) {
    	System.err.println (e.getMessage ()) ;
    }
  }

  public void logError (String s) {
    try {
      seclog (s,3) ;
    }
    catch (DataSourceException e) { System.err.println (e.getMessage ()) ; }
  }

  public int insertDueEntry (Date due, int asd, int typ, String fil, String sub, int uid, String msg, String mta) throws DataSourceException {
    String q = fetchStatement ("query_4070") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setTimestamp (2, new Timestamp (due.getTime ())) ;
        p.setInt (3,uid) ;
        p.setInt (4,typ) ;
        p.setInt (5,asd) ;
        p.setString (6,fil) ;
        p.setString (7,sub) ;
        p.setString (8,msg) ;
        p.setString (9,mta) ;
        p.execute () ;
        int id = p.getInt (1) ;
        if(id == -1) {
        	p.close () ;
        	Object [] o = {q, "update failed"} ;
        	throw new DataSourceException (f2.format (o)) ;
        }
        p.close () ;
        return id ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  public void insertNotificationEntry (Date due, int id) throws DataSourceException {
    insertNotificationEntry (due, id, -1, null) ;
  }

  public void insertNotificationEntry (Date due, int id, int uid, String txt) throws DataSourceException {
    String q = fetchStatement ("query_4060") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setInt (2, id) ;
        p.setTimestamp (3, new Timestamp (due.getTime ())) ;
        p.setInt (4, uid) ;
        p.setString (5, txt == null ? "" : txt) ;
        p.execute () ;
        p.close () ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
  
  final public void insertEventComment (int id, int uid, String txt) throws DataSourceException {
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (fetchStatement ("query_4050")) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setInt (2, id) ;
        p.setInt (3, uid) ;
        p.setString (4, txt == null ? "" : txt) ;
        p.execute () ;
        p.close () ;
      }
    } catch (SQLException e) {
    	throw new DataSourceException (e.getMessage ()) ;
    }
  }

  final public int addType (String mni, String lbl, int rnk, int col, int mxn, int mxc, int cxt, String dsc, boolean neu) throws DataSourceException {
  	return modType (-1, mni, lbl, rnk, col, mxn, mxc, cxt, dsc, neu) ;
  }
  
  final public int modType (int tid, String mni, String lbl, int rnk, int col, int mxn, int mxc, int cxt, String dsc, boolean neu) throws DataSourceException {
  	String q = fetchStatement ("query_4110") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setInt (2, tid) ;
        p.setString (3,mni) ;
        p.setString (4,lbl) ;
        p.setInt (5,rnk) ;
        p.setInt (6,col) ;
        p.setInt (7,mxn) ;			//
        p.setInt (8,mxc) ;			//
        p.setInt (9,cxt) ;			// Kontext
        p.setString (10,dsc) ;	// Beschreibung
        p.setBoolean (11,neu) ;	// Den Typ zu allen bestehenden Formularen hinzufügen ?
        p.execute () ;
        int id = p.getInt (1) ;
        p.close () ;
        return id ;
      }
    } catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public void modUser (int uid, boolean a, boolean b, boolean c, boolean d) throws DataSourceException {
    String q = fetchStatement ("query_4090") ;
    try {
      synchronized (con) {
      	CallableStatement p = con.prepareCall (q) ;
      	p.setInt (1, uid) ;
      	p.setBoolean (2, a) ;
      	p.setBoolean (3, b) ;
      	p.setBoolean (4, c) ;
      	p.setBoolean (5, d) ;
      	p.executeUpdate () ;
      	p.close () ;
      }
    } catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
  
  final public boolean delUser (int uid, int rea) throws DataSourceException {
  	String q = fetchStatement ("query_4040") ;
    try {
      synchronized (con) {    	
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setInt (2,uid) ;
        p.setInt (3,rea) ;
        p.executeUpdate () ;
        int id = p.getInt (1) ;
        p.close () ;
        return id == 1 ;
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
  
  final public int addAsd (int uid, String lbl, String dsc, boolean neu) throws DataSourceException {
  	return modAsd (-1, uid, lbl, dsc, neu) ;
  }
  
  final public int modAsd (int aid, int uid, String lbl, String dsc, boolean neu) throws DataSourceException {
  	String q = fetchStatement ("query_4210") ;
    try {
      synchronized (con) {
        CallableStatement p = con.prepareCall (q) ;
        p.registerOutParameter (1,java.sql.Types.INTEGER) ;
        p.setInt (2, aid) ;
        p.setInt (3, uid) ;
        p.setString (4,lbl) ;
        p.setString (5,dsc) ;
        p.setBoolean (6,neu) ;
        p.execute () ;
        int id = p.getInt (1) ;
        p.close () ;
        return id ;
      }
    } catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }
}