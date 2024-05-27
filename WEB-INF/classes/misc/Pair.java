// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc ;

import java.io.Serializable ;

public final class Pair implements Serializable {
	
  private Object a1, a2 ;
  
  public Pair (Object a, Object b) {
    a1 = a ; a2 = b ;
  }
  
  public Object first () {
    return a1 ;
  }
  
  public Object second () {
    return a2 ;
  }
}