// (c) Bernhard Schupp 2001-2002

package data ;

public class DataSourceException extends Exception {

  String _msg = null ;

  public DataSourceException (String m) {
    _msg = m ;
  }

  public String getMessage () {
    return _msg ;
  }
}