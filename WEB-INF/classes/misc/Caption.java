// (c) Bernhard Schupp 2001-2002

package misc ;

public final class Caption {
  String title, icon, desc ;

  public Caption (String a, String b, String c) {
    title = a ; icon = b ; desc = c ;
  }

  public String title () { return title ; }
  public String icon () { return icon ; }
}
