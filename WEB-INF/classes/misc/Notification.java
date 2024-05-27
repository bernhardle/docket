// (c) Bernhard Schupp; Frankfurt-München; 2001-2002

package misc ;

import java.sql.Date ;

public class Notification implements misc.comparison.ID {

  private int gid ;
  private Date due ;
  private Deadline bas ;
  private boolean hid ;

  public Notification (Deadline a, int b, Date c, boolean d) {
    bas = a ; gid = b ; due = c ; hid = d ;
  }

  public int id () {
  	return gid ;
  }
  
  public Date due () {
  	return due ;
  }
  
  public boolean done () {
  	return hid ;
  }
  
  public Deadline deadline () {
  	return bas ;
  }
}
