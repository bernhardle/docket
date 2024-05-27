// (c) Bernhard Schupp; 2001-2004; Frankfurt-München-Frankfurt

package html ;

import misc.JumpTarget ;
import misc.Color ;
import misc.Icon ;
import misc.Style ;
import misc.comparison.ID ;

import html.text.IconHook ;

public interface BasePage extends RawPage, ID {

  public abstract Icon icon (String key) throws IllegalArgumentException ;

  public abstract Style style (String key) throws IllegalArgumentException ;

  public abstract Color color (String key) throws IllegalArgumentException ;

  public abstract IconHook iiconHook (String key) throws IllegalArgumentException ;

  public abstract IconHook iiconHook (String key, String alt) throws IllegalArgumentException ;

  public abstract String iconHook (String key) throws IllegalArgumentException ;

  public abstract String iconHook (String key, JumpTarget tar) throws IllegalArgumentException ;

  public abstract String format (String a) ;

//  public abstract String incomm (String a) ;
}

