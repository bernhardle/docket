// (c) Bernhard Schupp; Frankfurt-M�nchen; 2001-2003

package dynamic.inputchecker ;

import java.sql.Date ;

public interface InputChecker {

//  public boolean isValidDueDate (Date due) ;

  public boolean isValidSubject (String sub) ;

  public boolean isValidFileID (String id) ;

}