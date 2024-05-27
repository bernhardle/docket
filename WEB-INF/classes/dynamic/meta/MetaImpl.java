// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package dynamic.meta ;

final public class MetaImpl implements Meta {

  public String compress (String a) {
    StringBuffer b = new StringBuffer () ;
    for (int i = 0 ; i < a.length () ; i ++) {
      char c = a.charAt (i) ;
      if (Character.isLetterOrDigit (c)) b.append (c) ;
    }
    return b.toString () ;
  }
}