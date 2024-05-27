// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

final public class Ticket {
	
  private int uid, asd ;
  private String login, name, salt, hash ;
  private boolean sys ;
  private Permissions n1 ;

  public static String hash (String a, String b) {
    return Integer.toHexString (new String (a + b).hashCode ()) ;
  }

  public Ticket (int j, String a, String b, boolean c, boolean d, boolean e, boolean f, boolean g, String h, String i, int k) {
    uid = j ;
    login = a ;
    name = b ;
    salt = h ;
    hash = i ;
    n1 = new Permissions (c, f, d, e) ;
    sys = g ;
    asd = k ;
  }

  public int uid () {
    return uid ;
  }

  public String login () {
    return login ;
  }

  public String name () {
    return name ;
  }

  public boolean isSystemUser () {
    return sys ;
  }

  public boolean checkPassword (String pwd) {
    return 0 == hash (pwd,salt).compareTo (hash) ;
  }
  
  public Permissions permissions () {
    return n1 ;	
  }
  
  public int assigned () {
  	return asd ;
  }
}