// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

import java.sql.Date ;

public class Deadline implements misc.comparison.ID {

  private int gid ;
  private String fil, com ;
  private DType typ ;
  private Date due ;
  private boolean hid ;

  public Deadline (int i, Date e, String a, String b, boolean d, DType t) {
    com = b ; 
    due = e ;
    gid = i ;
    fil = (a.compareTo ("0") == 0 ? "--" : a) ;
    hid = d ;
    typ = t ;
  }

  public int id () {
  	return gid ;
  }
  
  public int context () {
  	return typ.context ().id () ;
  }
  
  public Date due () {
  	return due ;
  }
  
  public String file () {
  	return fil ;
  }
  
  public String type () {
  	return typ.mini () ;
  }
  
  public String label () {
  	return com ;
  }
  
  public int colorID () {
  	return typ.colorID () ;
  }

  public boolean done () {
  	return hid ;
  }
}