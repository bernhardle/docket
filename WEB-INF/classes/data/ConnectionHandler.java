// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package data ;

import java.io.IOException ;
import java.io.FileInputStream ;
import java.sql.Date ;
import java.sql.SQLWarning ;
import java.sql.SQLException ;
import java.sql.DriverManager ;
import java.sql.Connection ;
import java.sql.Statement ;
import java.sql.Savepoint ;
import java.sql.CallableStatement ;
import java.sql.PreparedStatement ;
import java.sql.DatabaseMetaData ;

import java.util.Map ;
import java.util.List ;
import java.util.Collections ;
import java.util.LinkedList ;
import java.util.TreeMap ;
import java.util.WeakHashMap ;
import java.util.Iterator ;
import java.util.Properties ;

import java.text.MessageFormat ;

import java.lang.ref.WeakReference ;

import misc.ConnectionInfo ;

public class ConnectionHandler {

  final static String path = System.getProperty ("tomcat.home") + "\\webapps\\terminebeta\\WEB-INF\\classes\\data\\" ;
  final static String extension = ".properties" ;
  final static Properties statements = new Properties () ;
  final static Properties messages = new Properties () ;
  final static MessageFormat f1, f2, f3 ;

  static {
  	f1 = new MessageFormat ("FATAL: ConnectionHandler.fetchStatement not found: {0}") ;
  	f2 = new MessageFormat ("FATAL: Handle.Handle () exception caught when trying to connect {0} {1}") ;
  	f3 = new MessageFormat ("FATAL: Handle.getInstance () no valid database specified: {0}") ;
    try {
      statements.load (new FileInputStream (path + "Statements.properties")) ;
      messages.load (new FileInputStream (path + "Strings.properties")) ;
    }
    catch (Exception e) {}
  }

  protected static class Handle implements Connection, Runnable {

	// der erste Teil ist ein Adapter an die Schnittstelle 'Connection'

    private Connection con ;

    public void clearWarnings () throws SQLException { con.clearWarnings () ; }
    public void close () throws SQLException { con.close () ; }
    public void commit () throws SQLException { con.commit () ; }
    public Statement createStatement () throws SQLException { return con.createStatement () ; }
    public Statement createStatement (int i, int j) throws SQLException { return con.createStatement (i,j) ; }
    public Statement createStatement (int i, int j, int k) throws SQLException { return con.createStatement (i,j,k) ; }
    public boolean getAutoCommit () throws SQLException { return con.getAutoCommit () ; }
    public String getCatalog () throws SQLException { return con.getCatalog () ; }
    public DatabaseMetaData getMetaData () throws SQLException { return con.getMetaData () ; }
    public int getTransactionIsolation () throws SQLException { return con.getTransactionIsolation () ; }
    public Map getTypeMap () throws SQLException { return con.getTypeMap () ; }
    public SQLWarning getWarnings () throws SQLException { return con.getWarnings () ; }
    public boolean isClosed () throws SQLException { return con.isClosed () ; }
    public boolean isReadOnly () throws SQLException { return con.isReadOnly () ; }
    public String nativeSQL (String s) throws SQLException { return con.nativeSQL (s) ; }
    public CallableStatement prepareCall (String s) throws SQLException { return con.prepareCall (s) ; }
    public CallableStatement prepareCall (String s, int i, int j) throws SQLException { return con.prepareCall (s,i,j) ; }
    public CallableStatement prepareCall (String s, int i, int j, int k) throws SQLException { return con.prepareCall (s,i,j,k) ; }
    public PreparedStatement prepareStatement (String s) throws SQLException { return con.prepareStatement (s) ; }
    public PreparedStatement prepareStatement (String s, int i) throws SQLException { return con.prepareStatement (s,i) ; }
    public PreparedStatement prepareStatement (String s, int i, int j) throws SQLException { return con.prepareStatement (s,i,j) ; }
    public PreparedStatement prepareStatement (String s, int i, int j, int k) throws SQLException { return con.prepareStatement (s,i,j,k) ; }
    public PreparedStatement prepareStatement (String s, int [] i) throws SQLException { return con.prepareStatement (s,i) ; }
    public PreparedStatement prepareStatement (String s, String [] t) throws SQLException { return con.prepareStatement (s,t) ; }
    public void rollback () throws SQLException { con.rollback () ; }
    public void setAutoCommit (boolean b) throws SQLException { con.setAutoCommit (b) ; }
    public void setCatalog (String s) throws SQLException { con.setCatalog (s) ; }
    public void setReadOnly (boolean b) throws SQLException { con.setReadOnly (b) ; }
    public void setTransactionIsolation (int i) throws SQLException { con.setTransactionIsolation (i) ; }
    public void setTypeMap (Map m) throws SQLException { con.setTypeMap (m) ; }
    public void setHoldability (int i) throws SQLException { con.setHoldability (i) ; }
    public int getHoldability () throws SQLException { return con.getHoldability () ; }
    public Savepoint setSavepoint () throws SQLException { return con.setSavepoint () ; }
    public Savepoint setSavepoint (String s) throws SQLException { return con.setSavepoint (s) ; }
    public void releaseSavepoint (Savepoint x) throws SQLException { con.releaseSavepoint (x) ; }
    public void rollback (Savepoint x) throws SQLException { con.rollback (x) ; }

	// der zweite Teil die eigentliche Definition des Handle

    private static Map handles = Collections.synchronizedMap (new WeakHashMap ()) ;

    private Properties p = new Properties () ;
    private String key ;
    private Thread thr ;
    private int tmo ;

    synchronized void activate () {
      if (thr == null) {
        thr = new Thread (this) ;
        thr.setDaemon (true) ;
        thr.setPriority (Thread.MIN_PRIORITY) ;
        thr.start () ;
      }
    }

    public void run () {
      try {
      	Thread.yield () ;
      	Thread.sleep (tmo) ;
      }
      catch (InterruptedException e) {}
      thr = null ;
    }
    
    Handle (String d) throws DataSourceException {
      key = d ;
      try {
        p.load (new FileInputStream (path + key + extension)) ;
        tmo = Integer.parseInt (p.getProperty ("timeout")) ;
        Class.forName (p.getProperty ("driver")) ;
        con = DriverManager.getConnection (p.getProperty ("database"),p.getProperty ("user"),p.getProperty ("password")) ;
      }
      catch (Exception e) {
      	Object [] o = {e.getClass ().getName (), e.getMessage ()} ;
      	throw new DataSourceException (f2.format (o)) ;
      }
    }

    protected void finalize () {
      try {
      	if (con != null) {
      		con.close () ;	//	möglicherweise ist das der Anlass für den 
													//	'infinitely looping garbage collector' ...
      		con = null ;
      	}
      }
      catch (SQLException e) {}
    }

    public ConnectionInfo getConnectionInfo () {
      return new ConnectionInfo (p.getProperty ("database"), p.getProperty ("user"), p.getProperty ("driver"), key + extension, tmo) ;
    }

    public synchronized static Handle getInstance (String d) throws DataSourceException {
      if (d == null) {
      	Object [] o = {d} ;
      	throw new DataSourceException (f3.format (o)) ;
      }
      else { 
        Handle x = handles.containsKey (d) ? (Handle)((WeakReference) handles.get (d)).get() : null ;
        if (x == null) {
          String s = new String (d) ;
          x = new Handle (s) ;
          handles.put (s, new WeakReference (x)) ;
        }
        x.activate () ;
        return x ;
      }
    }

    public static List listOpenConnections () {
      LinkedList l = new LinkedList () ;
      for (Iterator i = handles.entrySet().iterator () ; i.hasNext () ; ) {
        Handle h = (Handle) ((WeakReference)((Map.Entry) i.next ()).getValue ()).get () ;
        if (h != null) l.add (h.getConnectionInfo ()) ;
      }
      return l ;
    }
  }

  protected Handle con ;

  protected ConnectionHandler (String s) throws DataSourceException {
    con = Handle.getInstance (s) ; 
  }

  public static List listOpenConnections () {
    return Handle.listOpenConnections () ;
  }

  public static String fetchStatement (String k) throws DataSourceException {
    String x = statements.getProperty (k) ;
    if (x == null) {
    	Object [] o = {k} ;
    	throw new DataSourceException (f1.format (o)) ;
    }
    return x ;
  }
}