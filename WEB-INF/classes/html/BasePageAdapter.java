// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import java.util.Date ;

import misc.Style ;
import misc.Color ;
import misc.Icon ;
import misc.JumpTarget ;

import html.text.IconHook ;

public class BasePageAdapter implements BasePage {

  private BasePage p1 ;

  public BasePageAdapter (BasePage a) {
    p1 = a ;
  }

  public BasePageAdapter (BasePageAdapter a) {
    p1 = a.p1 ;
  }

  public int id () {
  	return p1.id () ;
  }

  public String incomm (String a) {
    return p1.incomm (a) ;
  }

  public Icon icon (String key) throws IllegalArgumentException { 
    return p1.icon (key) ;
  }

  public Style style (String key) throws IllegalArgumentException {
    return p1.style (key) ;
  }

  public Color color (String key) throws IllegalArgumentException {
    return p1.color (key) ;
  }

  public IconHook iiconHook (String key) throws IllegalArgumentException {
  	return p1.iiconHook (key) ;
  }
  
  public IconHook iiconHook (String key, String alt) throws IllegalArgumentException {
  	return p1.iiconHook (key, alt) ;
  } 

  public String iconHook (String key) throws IllegalArgumentException {
    return p1.iconHook (key) ;
  }

  public String iconHook (String key, JumpTarget tar) throws IllegalArgumentException {
    return p1.iconHook (key,tar) ;
  }

  public String format (String a) {
    return p1.format (a) ;
  }
}