// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc.comparison ;

import java.util.Comparator ;

public class IDCompare implements Comparator {

  public int compare (Object a, Object b) {
  	int i = ((ID) a).id () ;
  	int j = ((ID) b).id () ;
  	return i == j ? 0 : (i < j ? -1 : 1) ;
  }
	
	public boolean equals (Object a, Object b) {
	  return ((ID)a).id () == ((ID)b).id () ;	
	}
}