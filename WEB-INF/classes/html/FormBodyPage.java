// (c) Bernhard Schupp; Frankfurt; 2004

package html ;

import html.form.Form ;

public class FormBodyPage extends BodyPageAdapter {

  private Form f1 ;

  public Form form () {
  	return f1 ;
  }

  public FormBodyPage (BodyPage a, Form b) {
    super (a) ;
    f1 = b ;
  }

  public String format (String contents, String caption) {
    return super.format (f1.wrap (contents),caption) ;
  }
  
  public String format (String contents, String caption, String toolchest) {
    return super.format (f1.wrap (contents), caption, toolchest) ;
  }
}