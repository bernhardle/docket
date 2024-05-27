// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.Map ;

import html.form.Input ;

public class FormAdapter implements Form {

  private Form base ;

  protected FormAdapter (Form a) {
    base = a ;
  }

  public Input input (String name) {
    return base.input (name) ;
  }

  public String wrap (String fill) {
    return base.wrap (fill) ;
  }
  
  public String wrap (String fill, Map m) {
    return base.wrap (fill, m) ;
  }
}