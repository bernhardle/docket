// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package dynamic.inputchecker ;

public class InputCheckerImpl implements InputChecker {

  private String prefixes = "ERW" ;

  public InputCheckerImpl () { }

  public boolean isValidSubject (String sub) {
    boolean ok = (sub == null) ? false : sub.length () > 0 ;
    if (ok) {
      for (int i = 0 ; i < sub.length () ; i ++) {
        char c = sub.charAt (i) ;
        ok &= Character.isLetterOrDigit (c) || Character.isSpaceChar (c) || c == '/' || c == '.' || c == '-' ;
      }
    }
    return ok ;
  }

  public boolean isValidFileID (String id) {

    if (id != null ? (0 < id.length ()) : false) {		// richtige Länge
      if (Character.isDigit (id.charAt (0)) 
		|| id.charAt (0) == prefixes.charAt (0) 
		|| id.charAt (0) == prefixes.charAt (1) 
		|| id.charAt (0) == prefixes.charAt (2)) {	// richtiges präfix
        int i ;
        for (i = 1; i < id.length () ? Character.isDigit (id.charAt (i)) : false ; i ++) ;
        if (i == id.length ()) {
          return true ;
        }
      }
    }
    return false ;
  }
}