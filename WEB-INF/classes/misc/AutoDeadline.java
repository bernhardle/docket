// (c) Bernhard Schupp 2001-2002

package misc ;

import java.util.List ;
import java.util.Iterator ;

final public class AutoDeadline {
  int key ;
  List types, notis, assign ;
  String label, desc ;
  public AutoDeadline (int a, String b, String c, List d, List e, List f) {
    key = a ; label = b ; desc = c ; types = d ; notis = e ; assign = f ;
  }
  public int key () { return key ; }
  public String label () { return label ; }
  public String description () { return desc ; }
  public Iterator types () { return types.iterator () ; }
  public Iterator notis () { return notis.iterator () ; }
  public Iterator assign () { return assign.iterator () ; }
}


