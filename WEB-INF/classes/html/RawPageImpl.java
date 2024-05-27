// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

final public class RawPageImpl implements RawPage {

  private String s1, s2 ;

  public RawPageImpl () {

    s1 = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">" +
         incomm ("INFO: begin section formatted by: RawPageImpl") +
         "<html>\n" +
         "<head>\n" +
         "<title></title>\n" + 
         "<body>\n" ;
    s2 = "</body>\n" +
         "</html>\n" +
         incomm ("INFO: end section formatted by RawPageImpl") ;
  }

  public String incomm (String a) {
    return "<!--\n\t" + a + "\n//-->\n" ;
  }

  public String format (String body) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (body) ;
    b.append (s2) ;
    return b.toString () ;
  }
}