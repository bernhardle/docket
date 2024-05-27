// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2003

package html.form ;

import misc.Detail ;

import html.text.DetailFormat ;

public class DetailInput extends InputBase {
	
	private DetailFormat f1 = DetailFormat.getInstance (DetailFormat.LONG) ;
	
  public DetailInput (String n, String s) {
	  super (n) ;
	}
	
	public String format () {
	  return format (null) ;
	}
	
	public String format (Object o) {
	  try {
	  	StringBuffer b = new StringBuffer () ;
	  	b.append (incomm (mi1)) ;
	  	b.append (f1.format ((Detail)o)) ;
	  	b.append (incomm (mi2)) ;
	  	return b.toString () ;
	  }
      catch (NullPointerException e) {
        StringBuffer b = new StringBuffer () ;
        b.append (incomm (me4)) ;
        return b.toString () ;
      }
      catch (ClassCastException e) {
        StringBuffer b = new StringBuffer () ;
        b.append (incomm (me3)) ;
        b.append (incomm (e.getMessage ())) ;
        return b.toString () ;
      }
	}
}