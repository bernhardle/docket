// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

public final class Icon extends Image {

  private String alt = "" ;

  public Icon (Image a, String b) {
    super (a) ;
    if (b != null) alt = b ;
  }

  public Icon (int i, String a, int b, int c, int d, String e) {
    super (i,a,b,c,d) ;
    if (e != null) alt = e ;
  }

  public String alt () {
  	return alt ; 
  }
}