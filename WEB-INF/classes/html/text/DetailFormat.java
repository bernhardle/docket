// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.text ;

import java.util.Map ;
import java.util.HashMap ;

import misc.Style ;
import misc.Detail ;
import misc.JumpTarget ;

public abstract class DetailFormat {

  public final static int MEDIUM = 2 ;
  public final static int LONG   = 1 ;
  public final static int SHORT  = 0 ;

  private final static String s1 = "Akte: " ;
  private final static String s2 = "Bearbeiter: " ;
  private final static String s3 = "Fristablauf: " ;
  private final static String s4 = "Betrifft: " ;
  private final static String s5 = "" ;
  private final static String s6 = "" ;

  private static DetailFormatLong f1 = new DetailFormatLong ("detail", s1, s2, s3, s4, s5, s6) ;
  private static DetailFormatMedium f2 = new DetailFormatMedium ("detail") ;
  
  protected DetailFormat () {}

  public abstract String format (Detail d) ;

  public abstract String format (Detail d, JumpTarget j) ;

  public static DetailFormat getInstance (int i) throws IllegalArgumentException {
    if (i == LONG) {
    	return f1 ;
    }
    else if (i == MEDIUM) {
    	return f2 ;
    }
    else throw new IllegalArgumentException () ;
  }
}