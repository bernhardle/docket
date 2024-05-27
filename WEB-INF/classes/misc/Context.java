// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

public final class Context implements misc.comparison.ID {
	
	private int cid, col ;
	private String lbl, dsc ;
	
	public Context (int a, int b, String c, String d) {
		cid = a ;
		col = b ;
		lbl = c ;
		dsc = d ;
	}
	
	public int id () {
		return cid ;
	}
	
	public int colorID () {
		return col ;
	}
	
	public String label () {
		return lbl ;
	}
	
	public String description () {
		return dsc ;
	}
}