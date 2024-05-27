// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2002

package html.form ;

import java.text.MessageFormat ;

abstract class InputBase implements Input {

  protected final String mi1 = "INFO: begin section formatted by \'" + getClass ().getName () + "\'." ;
  protected final String mi2 = "INFO: end section formatted by \'" + getClass ().getName () + "\'." ;
  protected final String me1 = "FATAL: operation \'format ()\' not supported in class \'" + getClass ().getName () + "\'." ;
  protected final String me2 = "FATAL: void \'name\' argument encountered when constructing instance of class \'" + getClass ().getName () + "\'." ;
  protected final String me3 = "FATAL: invalid argument type encountered in class \'" + getClass ().getName () + "\'." ;
  protected final String me4 = "FATAL: \'null\' argument encountered in class \'" + getClass ().getName () + "\'." ;

  private String n1 ;

  protected InputBase (String a) throws IllegalArgumentException {
    if (a == null) throw new IllegalArgumentException (me2) ;
    n1 = a ;
  }

  final public String name () {
    return n1 ;
  }

  public String format () {
    return me1 ;
  }

  public String incomm (String a) {
    StringBuffer b = new StringBuffer () ;
    b.append ("<!--\n\t") ;
    b.append (a) ;
    b.append ("\n//-->\n") ;
    return b.toString () ;
  }
}
