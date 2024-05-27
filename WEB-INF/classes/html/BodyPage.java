// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import html.text.DetailFormat ;

public interface BodyPage extends BasePage {

  public String format (String contents, String caption) ;
  
  public String format (String contents, String caption, String toolchest) ;

}