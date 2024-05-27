// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.frame ;

import java.util.Date ;

import misc.Helper ;

public final class Outer implements Frame {

  private String s1, s2 ;
  private Description desc ;
  private Date crt = new Date () ;

  public Outer (Description d) {
    desc = d ;
    StringBuffer x = new StringBuffer () ;
    x.append ("<!--\n\tBegin section formatted by: Outer loaded ") ;
    x.append (crt.toString ()) ;
    x.append ("\n//-->\n<html>\n<head>\n<title>") ;
    x.append (Helper.nameConvert (d.title ())) ;
    x.append ("</title>\n<base target=\"_self\" href=\"") ;
    x.append (d.baseURL ()) ;
    x.append ("\">\n") ;
    x.append (d.outerMeta () == null ? "" : (d.outerMeta () + "\n")) ;
    x.append ("<frameset framespacing=\"0\" border=\"false\" frameborder=\"") ;
    x.append (Integer.toString (d.border ())) ;
    x.append ("\" cols=\"") ;
    x.append (Integer.toString (d.cols ())) ;
    x.append (",*\">\n<frameset rows=\"") ;
    x.append (Integer.toString (d.rows ())) ;
    x.append (",*\">\n<frame name=\"Login\" target=\"_self\" src=\"") ;
    x.append (d.loginURL ()) ;
    x.append ("\" scrolling=\"no\" marginwidth=\"") ;
    x.append (Integer.toString (d.margin ())) ;
    x.append ("\" marginheight=\"0\" noresize>\n<frame name=\"Navigator\" src=\"") ;
    x.append (d.navigatorURL ()) ;
    x.append ("\" scrolling=\"no\" marginwidth=\"0\" marginheight=\"") ;
    x.append (Integer.toString (d.margin ())) ;
    x.append ("\" noresize target=\"_self\">\n</frameset>\n<frame name=\"Body\" target=\"_self\" src=\"") ;
    
    s1 = x.toString () ;
    s2 = "\" scrolling=\"auto\">\n" +
         "<noframes>\n" +
         "<body>\n<p>" + Helper.nameConvert (d.message ()) + "</p>\n</body>\n" +
         "</noframes>\n" +
         "</frameset>\n" +
         "</html>\n" +
         "<!--\n\tTerminkalender (c) Bernhard Schupp, Frankfurt-München-Frankfurt; 2001-2004\n\t" +
         "end section formatted by: Outer\n//-->\n" ;
  }

  public int id () {
  	return desc.id () ;
  }

  public Description description () {
    return desc ;
  }

  public String format (String u1) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (u1) ;
    b.append (s2) ;
    return b.toString () ;
  }
}
