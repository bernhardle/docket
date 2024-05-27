// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import misc.Style ;

public abstract class TextInput extends InputBase {
  
  private Style style ;
  private int len, max ;

  protected TextInput (Style a, int b, int c, String d) {
    super (d) ;
    style = a ;
    len = b ;
    max = c ;
  }

  int max () {
    return max ;
  }

  int len () {
    return len ;
  }

  Style style () {
    return style ;
  }
}