// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package dynamic.inputchecker ;

import java.sql.Date ;

import misc.Helper ;

public abstract class InputCheckerBase implements InputChecker {
	
  public boolean isValidDueDate (Date due) {
  	
  	Date tdy = Helper.parseDate (new Date (new java.util.Date ().getTime ()).toString ()) ;
  	
  	return false ;
  }
  
}