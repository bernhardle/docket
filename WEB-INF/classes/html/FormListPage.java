// (c) Bernhard Schupp; Frankfurt-M�nchen; 2001-2003

package html ;

import java.util.Map ;

public interface FormListPage {

  public abstract String format (String caption) ;

  public abstract String format (String caption, Map m) ;

}