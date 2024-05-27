// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.form ;

import java.util.Map ;
import java.util.Date ;
import java.util.List ;
import java.util.Iterator ;

import misc.JumpTarget ;

import html.form.Input ;

public class FormImpl implements Form {

  class ErrorInput implements Input { 

    private final String me1 = "<!--\n\t" + getClass ().getName () + ".input (...) no input found for \'" ;
    private final String me2 = "\'.\n//-->\n" ;

    private String s1, s2 ;

    ErrorInput (String a) {
      StringBuffer b = new StringBuffer () ;
      b.append (me1) ;
      b.append (a) ;
      b.append (me2) ;
      s1 = b.toString () ;
      s2 = a ;
    }

    public String name () {
      return s2 ;
    }

    public String format () {
      return s1 ;
    }

    public String format (Object o) {
      return format () ;
    }  
  }

  private String s1, s2, s3 ;
  private Map m1, m2 ;

  public FormImpl (FormImpl a) {
    s1 = a.s1 ;
    s2 = a.s2 ;
    s3 = a.s3 ;
    m1 = a.m1 ;
    m2 = a.m2 ;
  }

  public FormImpl (int id, String name, JumpTarget target, String script, Map inputs, Map hidden, String type) {
    m1 = inputs ;
    m2 = hidden ;

    StringBuffer b = new StringBuffer () ;
    b.append ("<!--\n\tINFO: begin section formatted by ") ;
    b.append (getClass ().getName ()) ;
    b.append (" /") ;
    b.append (Integer.toString (id)) ;
    b.append ("/ loaded on: ") ;
    b.append (new Date ().toString ()) ;
    b.append ("\n//-->\n") ;
    b.append ("<script src=\"") ;
    b.append (script) ;
    b.append ("\"></script>\n") ;
    b.append ("<form action=\"") ;
    b.append (target.url ()) ;
    b.append ("\" method=\"") ;
    b.append (type) ;
    b.append ("\" name=\"") ;
    b.append (name) ;
    b.append ("\" target=\"") ;
    b.append (target.target ()) ;
    b.append ("\" onsubmit=\"return validator(this)\">\n") ;
    s1 = b.toString () ;

    b = new StringBuffer () ;
    b.append ("<!--\n\tINFO: Default Werte für versteckte Felder verwendet.\n//-->\n") ;
    for (Iterator i = m2.entrySet ().iterator () ; i.hasNext () ; ) {
      b.append (((Input) ((Map.Entry)i.next ()).getValue ()).format ()) ;
    }
    s2 = b.toString () ;

    b = new StringBuffer () ;
    b.append ("</form>\n") ;
    b.append ("<!--\n\tINFO: end section formatted by: ") ;
    b.append (getClass ().getName ()) ;
    b.append ("\n//-->\n") ;
    s3 = b.toString () ;
  }

  public Input hidden (String name) {
  	Input x = (Input) m2.get (name) ;
    if (x == null) x = new ErrorInput (name) ;
    return x ;
  }

  public Input input (String name) {
    Input x = (Input) m1.get (name) ;
    if (x == null) x = new ErrorInput (name) ;
    return x ;
  }

  public String wrap (String a) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (s2) ;
    b.append (a) ;
    b.append (s3) ;
    return b.toString () ;
  }
  
  public String wrap (String a, Map m) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    for (Iterator i = m2.entrySet ().iterator () ; i.hasNext () ; ) {
      Map.Entry e = (Map.Entry) i.next () ;
      if (m.containsKey (e.getKey ())) {
        b.append (((Input) e.getValue ()).format (m.get (e.getKey ()))) ;
      }
      else {
        b.append (((Input) e.getValue ()).format ()) ;
      }
    }
    b.append (a) ;
    b.append (s3) ;
    return b.toString () ;
  }
}