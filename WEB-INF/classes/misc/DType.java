// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc ;

public final class DType implements misc.comparison.ID {

  private int tid, mxc, mxn, rnk, col ;
  private Context cxt ;
  private String mni, lbl, dsc ;
  boolean fix ;
  
  public DType (int a, String b, String c, int d, int e, int f, int g, Context h, String i, boolean j) {
  	tid = a ;
  	mni = b ;
  	lbl = c ;
  	rnk = d ;
  	col = e ;
  	mxn = f ;
  	mxc = g ;
  	cxt = h ;
  	dsc = i ;
  	fix = j ;
  }
  
  public int id () {
  	return tid ;
  }
  
  public String mini () {
  	return mni ;
  }
  
  public String label () {
    return lbl ;
  }
  
  public int colorID () {
  	return col ;
  }
  
  public int maxn () {
  	return mxn ;
  }
  
  public int maxc () {
  	return mxc ;
  }
  
  public int rank () {
  	return rnk ;
  }
  
  public Context context () {
  	return cxt ;
  }
  
  public String description () {
  	return dsc ;
  }
  
  public boolean fixed () {
  	return fix ;
  }
}