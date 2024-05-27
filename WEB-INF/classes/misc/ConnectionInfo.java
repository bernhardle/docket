// (c) Bernhard Schupp 2001-2002

package misc ;

public final class ConnectionInfo {

  String dba, usr, drv, pro ;
  int tmo ;

  public ConnectionInfo (String a, String b, String c, String d, int e) {
    dba = a ; usr = b ; drv = c ; pro = d ; tmo = e ;
  }
  
  public String database () {
    return dba ;
  }

  public String user () {
    return usr ;
  }

  public String driver () {
    return drv ;
  }

  public String properties () {
    return pro ;
  }

  public int timeout () {
    return tmo ;
  }
}