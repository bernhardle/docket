// (c) Bernhard Schupp 2001-2002

package misc ;

final public class AutoNotification {
  int offset, base ;
  boolean mutable ;
  public AutoNotification (int a, int b, boolean c) {
    offset = a ; base = b ;
  }
  public int offset () { return offset ; }
  public int base () { return base ; }
  public boolean mutable () { return mutable ; }
}
