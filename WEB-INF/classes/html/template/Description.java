// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.template ;

final public class Description {
  
  private String name, url ;
   
  public Description (String a, String b) {
    name = a ; url = b ;
  }

  public String url () {
  	return url ;
  }
  
  public String name () {
  	return name ;
  }
}