// (c) Bernhard Schupp; Frankfurt-M�nchen; 2001-2003

package dynamic.inputchecker ;

import java.sql.Date ;

import misc.Helper ;

public abstract class InputCheckerBase implements InputChecker {
	
  public boolean isValidDueDate (Date due) {
  	
  	Date tdy = Helper.parseDate (new Date (new java.util.Date ().getTime ()).toString ()) ;
  	
  	return false ;
  }
  
}