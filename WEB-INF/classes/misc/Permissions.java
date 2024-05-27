// (c) Bernhard Schupp 2002

package misc ;

public class Permissions {

  boolean b1, b2, b3, b4 ;

  public Permissions () {
    b1 = b2 = b3 = b4 = false ;	
  }

  public Permissions (boolean a, boolean b, boolean c, boolean d) {
  	b1 = a ;
  	b2 = b ; 
  	b3 = c ;
  	b4 = d ;
  }
	
	public boolean permLgn () {
	  return b1 ;	
	}
	
	public boolean permAdm () {
		return b2 ;
	}
	
  public boolean permCrt () {
    return b3 ;
  }

  public boolean permDel () {
  	return b4 ;
  }
}