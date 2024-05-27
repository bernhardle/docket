// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

import java.util.Iterator ;

public class OIterator {

  private Iterator i ;

  public OIterator (Iterator a) {
  	i = a ;
  }
	
	public Option next () {
	  return (Option) i.next () ;	
	}
	
}