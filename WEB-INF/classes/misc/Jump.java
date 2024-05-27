// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc ;

import java.io.Serializable ;
import java.text.MessageFormat ;

import javax.servlet.http.HttpServletResponse ;

public final class Jump implements Serializable {

  private String s1, s2, nam ;
  private MessageFormat f1 ;
  
  public Jump (String n, String a, String b, String c) {
  	nam = n ;
    s1 = a ;
    f1 = new MessageFormat (b) ;
    s2 = c ;
  }
  
  public JumpTarget get (HttpServletResponse r) {
  	Object o [] = {} ;
  	return get (r, o) ;
  }
  
  public JumpTarget get (HttpServletResponse r, Object o) {
  	StringBuffer b = new StringBuffer () ;
  	b.append (s1) ;
  	b.append (f1.format (o)) ;
    return new JumpTarget (r.encodeURL(b.toString ()), s2, nam) ;	
  }
  
  public String redirectURL (HttpServletResponse r, Object o) {
  	StringBuffer b = new StringBuffer () ;
  	b.append (s1) ;
  	b.append (f1.format (o)) ;
    return r.encodeRedirectURL(b.toString ()) ;
  }
}