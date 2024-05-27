// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.frame ;

import java.util.Date ;

public final class Inner implements Frame {

  private String s1, s2, s3 ;
  private Description desc ;
  private Date crt = new Date () ;

  public Inner (Description d) {
    desc = d ;
    s1 = "<!-- \n   begin section formatted by: Inner /" + 
         Integer.toString (d.id ()) + "/\n" +
         "     loaded " + crt.toString () + "\n//-->\n" +
         "<html>\n" +
         "<head>\n" +
         "<title>" + d.title () + "</title>\n" +
         "<base target=\"_self\" href=\"" + d.baseURL () + "\">\n" +
         (d.innerMeta () == null ? "" : (d.innerMeta () + "\n")) +
         "<frameset framespacing=\"0\" border=\"false\" frameborder=\"" + d.border () + "\" rows=\"" + d.rows () + ",*\">\n" +
         "<frame name=\"Oben\" src=\"" ;
    s2 = "\" scrolling=\"no\" marginwidth=\"" + d.margin () + "\" marginheight=\"" + d.margin () + "\" noresize>\n" +
         "<frame name=\"Unten\" src=\"" ;
    s3 = "\" target=\"_self\" scrolling=\"auto\">\n" +
         "<noframes>\n" +
         "<body>\n" +
         "<p>" + d.message () + 
         "</body>\n" +
         "</noframes>\n" +
         "</frameset>\n" +
         "</html>\n" + 
         "<!--\n Terminkalender (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004\n//-->\n" +
         "<!--\n end section formatted by: Inner\n//-->\n" ;
  }

  public int id () {
  	return desc.id () ;
  }

  public Description description () {
    return desc ; 
  }

  public String format (String u1, String u2) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (u1) ;
    b.append (s2) ;
    b.append (u2) ;
    b.append (s3) ;
    return b.toString () ;
  }
}