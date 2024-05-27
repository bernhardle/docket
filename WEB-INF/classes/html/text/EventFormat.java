// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.text ;

import misc.Event ;

public abstract class EventFormat {

  public final static int MEDIUM = 2 ;
  public final static int LONG   = 1 ;
  public final static int SHORT  = 0 ;

  public EventFormat () {}

  public static EventFormat getInstance (int i) {
    return new EventFormatLong () ;
  }

  public abstract String htmlFormat (Event e) ;
}