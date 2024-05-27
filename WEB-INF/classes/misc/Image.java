// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

public class Image implements misc.comparison.ID {

  private int id = -1 ;
  private String url ;
  private int xsize, ysize, border ;

  public int id () {
  	return id ;
  }

  public Image (Image a) {
    id = a.id; url = a.url ; xsize = a.xsize ; ysize = a.ysize ; border = a.border ;
  }

  public Image (int i, String a, int b, int c, int d) {
    id = i; url = a ; xsize = b ; ysize = c ; border = d ;
  }

  public String url () { return url ; }
  public int xsize () { return xsize ; }
  public int ysize () { return ysize ; }
  public int border () { return border ; }
}