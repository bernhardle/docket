// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package dynamic.inputchecker ;

import java.sql.Date ;

public interface InputChecker {

//  public boolean isValidDueDate (Date due) ;

  public boolean isValidSubject (String sub) ;

  public boolean isValidFileID (String id) ;

}