// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

public class BodyPageAdapter extends BasePageAdapter implements BodyPage {

  private BodyPage p1 ;

  public BodyPageAdapter (BodyPage a) {
    super (a) ;
    p1 = a ;
  }
  
  public int id () {
  	return p1.id () ;
  }

  public String format (String contents, String caption) {
    return p1.format (contents,caption) ;
  }
  
  public String format (String contents, String caption, String toolchest) {
    return p1.format (contents, caption, toolchest) ;
  }
}