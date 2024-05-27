// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc ;

import java.sql.Date ;
import java.sql.Timestamp ;

final public class Event implements misc.comparison.ID {
	
  private int id, tid ;
  private Timestamp crd ;
  private String crt, dsc, com, typ, col ; 
  private Date wvd ;

  public Event (int i, int j, Timestamp x, String a, String b, String c, String d) {
    id = i ; tid = j ; crd = x ; crt = a ; dsc = b ; com = c ; typ = d ;
  }

  public Event (int i, int j, Timestamp x, String a, String b, String c, String d, Date e) {
    id = i ; tid = j ; crd = x ; crt = a ; dsc = b ; com = c ; typ = d ; wvd = e ;
  }

  public int id () {
  	return id ;
  }
  
  public int typ () {
  	return tid ;
  }
  
  public Timestamp timestamp () {
  	return crd ; 
  }
  
  public String creator () {
  	return crt ; 
  }
  
  public String label () {
  	return typ ; 
  }
  
  public String description () {
  	return dsc ;
  }
  
  public String comment () {
  	return com ;
  }
  
	// falls es ein Wiedervorlagenereignis ist
  public boolean nevent () {
  	return wvd == null ? false : true ;
  }
  
  public Date ndue () {
  	return wvd ;
  }
}

