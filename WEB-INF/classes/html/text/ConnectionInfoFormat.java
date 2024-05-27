// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.text ;

import misc.ConnectionInfo ;

public class ConnectionInfoFormat {

  private final static String s10 = misc.Helper.nameConvert("Datenbank:") ;
  private final static String s11 = misc.Helper.nameConvert("Benutzer:") ;
  private final static String s12 = misc.Helper.nameConvert("Treiber:") ;
  private final static String s13 = misc.Helper.nameConvert("Properties aus Datei:") ;
  private final static String s14 = misc.Helper.nameConvert("Timeout [sec]:") ;

  private String s1, s2, s3, s4, s5, s6, s7, s8 ;
  private int i1 = 1, i2 = 1, i3 = 2 ;

  public ConnectionInfoFormat () {
    s1 = "<table border=\"" + i1 + "\" cellspacing=\"" + i2 + "\" cellpadding=\"" + i3 + "\">\n" ;
    s2 = "<tr><td>" + s10 + "</td><td>" ;
    s3 = "</td></tr>\n" ;
    s4 = "<tr><td>" + s11 + "</td><td>" ;
    s5 = "<tr><td>" + s12 + "</td><td>" ;
    s6 = "<tr><td>" + s13 + "</td><td>" ;
    s7 = "<tr><td>" + s14 + "</td><td>" ;
    s8 = "</table>" ;
  }

  public String format (ConnectionInfo i) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (s2) ;
    b.append (misc.Helper.nameConvert (i.database ())) ; 
    b.append (s3) ;
    b.append (s4) ; 
    b.append (misc.Helper.nameConvert (i.user ())) ;
    b.append (s3) ;
    b.append (s5) ;
    b.append (misc.Helper.nameConvert (i.driver ())) ;
    b.append (s3) ;
    b.append (s6) ;
    b.append (misc.Helper.nameConvert (i.properties ())) ;
    b.append (s3) ;
    b.append (s7) ;
    b.append (misc.Helper.nameConvert (Double.toString (i.timeout () * 0.001))) ;
    b.append (s3) ;
    b.append (s8) ;
    return b.toString () ;
  }
}