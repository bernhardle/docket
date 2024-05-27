// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package html.frame ;

public final class Argument {

  private String s1, s2 ;
  private boolean b1 ;

  public Argument (String a, String b, boolean c) {
    s1 = a; s2 = b; b1 = c;
  }

  public boolean optional () { return b1 ; }
  public String name () { return s1 ; }
  public String defval () { return s2 ; }
}