// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

final public class Option {

  final static Color defaultColor = new Color (0,0,0) ;
  final static String defaultLabel = "<void>" ;

  private int key ;
  private String lab ;
  private Color col ;

  public Option (int k, String a) {
    key = k ;
    lab = (a == null ? defaultLabel : a) ; 
    col = defaultColor ;
  }

  public Option (int k, String a, Color b) {
    key = k ;
    lab = (a == null ? defaultLabel : a) ; 
    col = (b == null ? defaultColor : b) ;
  }

  public int key () {
  	return key ;
  }
  
  public String label () {
  	return lab ;
  }
  
  public Color color () {
  	return col ;
  }
}