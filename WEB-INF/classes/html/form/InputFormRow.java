// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2002

package html.form ;

import misc.Color ;

public class InputFormRow {

  private String s1, s2, s3 ;
  private Color c1 ;

  public InputFormRow (String a, String b, Color c, String d) {
  	
  	// a: Text
  	// b: Style (Name)
  	// c: Farbe 
  	// d: Input (Name)
  	
    s1 = a ;
    s2 = b ;
    c1 = c ;
    s3 = d ;
  }
  
  public String text () {
    return s1 ;	
  }
  
  public String style () {
  	return s2 ;
  }
  
  public String input () {
  	return s3 ;
  }
  
  public Color color () {
  	return c1 ;
  }
}