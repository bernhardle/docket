// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc ;

import java.sql.Date ;

final public class Detail implements misc.comparison.ID {

  private static String nullfile = "<leer>" ;
  
  private int gid ;
  private Date due ;
  private String fil, sub, com, asd ;
  private boolean hid ;
  private DType typ ;

  public Detail (int a, Date b, DType c, boolean d, String e, String f, String g, String h) {
    gid = a ;
    due = b ;
    fil = (e.compareTo ("0") == 0 ? nullfile : e) ;
    sub = (f == null ? "" : f) ;
    com = (g == null ? "" : g) ;
    hid = d ;
    asd = (h == null ? "" : h) ;
    typ = c ;
  }

  public int id () {
  	return gid ;
  }
  
  public Date date () {
  	return due ; 
  }
  
  public String file () {
  	return fil ;
  }
 
  public String subject () {
  	return sub ;
  }
  
  public String comment () {
  	return com ;
  }
  
  public DType type () {
  	return typ ;
  }
  
  public String assigned () {
  	return asd ; 
  }
  
  public boolean done () {
  	return hid ;
  }
}
