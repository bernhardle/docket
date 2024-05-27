// (c) Bernhard Schupp 2001-2002

package misc ;

final public class AutoContinuation {
	
  private int offset, base, type ;
  private boolean mutable ;
  private String baselabel, typelabel ;
  
  public AutoContinuation (int a, int b, String c, int d, String e, boolean f) {
    offset = a ;
    base = b ;
    baselabel = c ;
    type = d ;
    typelabel = e ;
    mutable = f ;
  }
  public int offset () {
  	return offset ; 
  }
  
  public int base () {
  	return base ;
  }
  
  public int type () {
  	return type ;
  }
 
  public int now () {
  	return 0 ;
  }
  
  public String typeLabel () {
  	return typelabel ;
  }
  
  public String baseLabel () {
  	return baselabel ;
  }
  
  public String nowLabel () {
  	return "Fristende" ;
  }
  
  public boolean mutable () {
  	return mutable ;
  }
}