// (c) Bernhard Schupp 2001-2002

package misc ;

final public class AutoDeadlinePreview {
  int key, notis ;
  String label ;
  public AutoDeadlinePreview (int a, int b, String c) {
    key = a; notis = b ; label = c ;
  }
  public int key () { return key ; }
  public int notis () { return notis ; }
  public String label () { return label ; }
}
