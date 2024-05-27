// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

public class Assign implements misc.comparison.ID {
	
	private int aid, uid ;
	private String lbl, dsc ;
	
	public Assign (int a, int b, String c, String d) {
	  aid = a ;
	  uid = b ;
	  lbl = c ;
	  dsc = d ;	
	}
	
	public int id () {
	  return aid ;	
	}
	
	public int login () {
		return uid ;
	}
	
	public String label () {
		return lbl ;
	}
	
	public String description () {
		return dsc ;
	}
	
}