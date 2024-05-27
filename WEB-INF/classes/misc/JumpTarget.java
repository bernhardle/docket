// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

public final class JumpTarget {

  final static String s1 = "<a href=\"" ;
  final static String s2 = "\"" ;
  final static String s3 = " onMouseOver=\"window.status='" ;
  final static String s4 = "';return true;\" onMouseOut=\"window.status='';return true;\"" ;
  final static String s5 = " target=\"" ;
  final static String s6 = "\">" ;
  final static String s7 = "</a>" ;

  private String url = null ;
  private String target = "_self" ;
  private String name = null ;

  public JumpTarget (String u) {
    url = u ;
    target = "_self" ;
  }

  public JumpTarget (String u, String t) {
    url = u ;
    target = t ;
  }

  public JumpTarget (String u, String t, String n) {
    url = u ;
    target = t ;
    name = n ;	
  }
  
  public String url () {
  	return url ;
  }

  public String target () {
  	return target ;
  }

  public String wrap (String item) {
  	if (item == null || url == null || target == null) throw new IllegalArgumentException ("FATAL: null wrap failed") ;
  	StringBuffer b = new StringBuffer () ;
  	b.append (s1) ;
  	b.append (url) ;
  	b.append (s2) ;
  	if (name != null) {
  	  b.append (s3) ;
  	  b.append (misc.Helper.jsStringConvert (name)) ;
  	  b.append (s4) ;	
  	}
  	b.append (s5) ;
  	b.append (target) ;
  	b.append (s6) ;
  	b.append (item) ;
  	b.append (s7) ;
    return b.toString () ;
  }
}