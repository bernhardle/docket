// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

import java.util.Vector ;

public class Result {
	
	private Vector v1 ;
	private int i1, i2, i3, i4 ;
	private boolean b1 ;
	
	public Result (Vector a, int b, int c, int d, int e, boolean f) {
	  v1 = a ;
	  i1 = b ;
	  i2 = c ;
	  i3 = d ;
	  i4 = e ;
	  b1 = f ;	
	}
	
	public int max () {
	  return i4 ;	
	}
	
	public int num () {
		return i1 ;
	}
	
	public int beg () {
	  return i2 ;	
	}
	
	public int end () {
		return i3 ;
	}
	
	public boolean truncated () {
		return b1 ;
	}
	
	public Vector hit () {
		return v1 ;
	}
	
}