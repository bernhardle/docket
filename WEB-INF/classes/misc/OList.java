// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

import java.util.List ;
import java.util.ArrayList ;

public class OList {
	
	private List l = new ArrayList () ;
	
	public OList () {}
	
	public OIterator iterator () {
	  return new OIterator (l.iterator ()) ;	
	}
}