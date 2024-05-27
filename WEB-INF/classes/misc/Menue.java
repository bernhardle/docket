// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc ;

import java.util.List ;
import java.util.Iterator ;

public final class Menue {
	
  private List l1 ;
  private String s1 ;
  
  public Menue (List a, String b) {
  	l1 = a ;
  	s1 = b ;
  }
  
  final public Iterator items () {
  	return l1.iterator () ;
  }
  
  final public String title () {
  	return s1 ;
  }
	
}