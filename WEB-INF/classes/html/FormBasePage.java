// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import html.form.Form ;

public class FormBasePage extends BasePageAdapter {

  private Form f1 ;

  public Form form () {
    return f1 ;
  } 

  public FormBasePage (BasePage a, Form b) {
    super (a) ;
    f1 = b ;
  }

  public String format (String a) {
    return super.format (f1.wrap (a)) ;
  }
}