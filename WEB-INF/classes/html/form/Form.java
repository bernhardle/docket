// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.Map ;

import html.form.Input ;

public interface Form {

  public Input input (String name) ;

  public String wrap (String fill) ;
  
  public String wrap (String a, Map b) ;

}