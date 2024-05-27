// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package data ;

import java.util.List ;
import java.util.LinkedList ;
import java.util.Collections ;

import java.text.MessageFormat ;

import java.sql.SQLException ;
import java.sql.Statement ;
import java.sql.ResultSet ;
import java.sql.ResultSetMetaData ;

import misc.Pair ;

public class DataSourceBase extends ConnectionHandler {

  private final String s0 = getClass ().getName () ;
  private final String s1 = "FATAL: [" + s0 + "] No result for query: {0}. Parameter was: {1}." ;
  private final String s2 = "FATAL: [" + s0 + "] Caught exception: {0}. Message was: {1}." ;
  private final String s3 = "FATAL: [" + s0 + "] Error when executing: {0}. Message was: {1}." ;
  private final String s4 = "FATAL: [" + s0 + "] Cache lookup failed for {0}. Key was {1}." ;
  
  protected final MessageFormat f1 = new MessageFormat (s1) ;
  protected final MessageFormat f2 = new MessageFormat (s2) ;
  protected final MessageFormat f3 = new MessageFormat (s3) ;
  protected final MessageFormat f4 = new MessageFormat (s4) ;
  
  public DataSourceBase (String s) throws DataSourceException {
    super (s) ;
  }

  final public List executeSQL (String sql) throws DataSourceException {
    try {
      synchronized (con) {
        Statement s = con.createStatement () ;
        boolean   b = s.execute (sql) ;

        List nam = new LinkedList () ;
        List val = new LinkedList () ;
  
        if (b) {
          ResultSet r = s.getResultSet () ;
          ResultSetMetaData rmd = r.getMetaData () ;
          int col = rmd.getColumnCount () ;

          {
            String [] x = new String [col] ;   
            for (int i = 0 ; i < x.length ; i++) x [i] = rmd.getColumnName (i+1) ;
            val.add (x) ;
          }

          while (r.next ()) {
            String [] x = new String [col] ;
            for (int i = 0; i < x.length ; i ++) x [i] = r.getString (i+1) ;
            val.add (x) ;
          }
        }
        return Collections.unmodifiableList (val) ;
      }
    }
    catch (SQLException e) {
    	throw new DataSourceException ("DataSourceBase.executeSQL (" + sql + ") " + e.getMessage ()) ;
    }
  }

  final public List executeQuery (String qry) throws DataSourceException {
    return executeSQL (fetchStatement (qry)) ;
  }
}