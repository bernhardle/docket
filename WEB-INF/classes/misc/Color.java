// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

public final class Color implements misc.comparison.ID {

  private int id = -1 ;
  private String n ;
  private int r, g, b ;

  public Color (int i, int j, int k) {
    id = -1 ; n = "" ; r = i ; g = j ; b = k ;
  }

  public Color (int e, String a, int i, int j, int k) {
    id = e ; n = a ; r = i ; g = j ; b = k ;
  }

  public int id () {
  	return id ;
  }

  public String label () {
    return n ;	
  }

  public String hex () {
    String rh = Integer.toHexString (r).toUpperCase () ;
    String gh = Integer.toHexString (g).toUpperCase () ;
    String bh = Integer.toHexString (b).toUpperCase () ;
    return "#" + (rh.length () == 1 ? "0" : "") + rh + (gh.length () == 1 ? "0" : "") + gh + (bh.length () == 1 ? "0" : "") + bh ;
  }

  public String rgb () {
    StringBuffer x = new StringBuffer () ;
    x.append ("rgb(") ;
    x.append (Integer.toString (r)) ;
    x.append (",") ;
    x.append (Integer.toString (g)) ;
    x.append (",") ;
    x.append (Integer.toString (b)) ;
    x.append (")") ;
    return x.toString () ;
  }
}