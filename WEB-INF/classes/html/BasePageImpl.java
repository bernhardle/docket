// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import java.util.Date ;

import java.util.Map ;
import java.util.List ;
import java.util.Iterator ;
import java.util.TreeMap ;
import java.util.Collections ;

import misc.JumpTarget ;
import misc.Style ;
import misc.Color ;
import misc.Icon ;
import misc.Image ;
import misc.Option ;

import html.text.IconHook ;

public class BasePageImpl implements BasePage {

  final private class IconHookImpl implements IconHook {
  	
  	private String is1 ;
  
    private IconHookImpl (String key) {
    	if (icons.containsKey (key)) {
    	  Icon d = (Icon) icons.get (key) ;
  	    StringBuffer b = new StringBuffer () ;
  	    b.append ("<img src=\"") ;
  	    b.append (d.url ()) ;
  	    b.append ("\" border=\"") ;
  	    b.append (d.border ()) ;
  	    b.append ("\" width=\"") ;
  	    b.append (d.xsize ()) ;
  	    b.append ("\" height=\"") ;
  	    b.append (d.ysize ()) ;
  	    b.append ("\">\n") ;
        is1 =  b.toString () ;
      }
      else {
      	is1 = m2_1 + key + m2_2 ;
      }
    }
    
    private IconHookImpl (String key, String alt) {
    	if (icons.containsKey (key)) {
    	  Icon d = (Icon) icons.get (key) ;
  	    StringBuffer b = new StringBuffer () ;
  	    b.append ("<img src=\"") ;
  	    b.append (d.url ()) ;
  	    b.append ("\" border=\"") ;
  	    b.append (d.border ()) ;
  	    b.append ("\" width=\"") ;
  	    b.append (d.xsize ()) ;
  	    b.append ("\" height=\"") ;
  	    b.append (d.ysize ()) ;
  	    b.append ("\" alt=\"") ;
  	    b.append (alt) ;
  	    b.append ("\" title=\"") ;
  	    b.append (alt) ;
  	    b.append ("\">\n") ;
        is1 =  b.toString () ;
      }
      else {
      	is1 = m2_1 + key + m2_2 ;
      }
    }
    
    public String format () {
  		return is1 ;
  	}
  	
  	public String format (JumpTarget t) {
  		return t.wrap (is1) ;
  	}
  }

  private final static String m1_1 = "<!--\nERROR: PageLayoutBase exception caught while loading styles " ;
  private final static String m1_2 = "\n//-->\n" ;
  private final static String m2_1 = "<!--\nERROR: PageLayoutBase.iconHook (...) failed for key " ;
  private final static String m2_2 = "\n//-->\n" ;
  private final static String m3_1 = "<!--\nERROR: PageLayoutBase.imageInput (...) failed for key " ;
  private final static String m3_2 = "\n//-->\n" ;
  private final static String m4_1 = "<!--\nERROR: PageLayoutBase.selectInputFormatter (...) failed for key " ;
  private final static String m4_2 = "\n//-->\n" ;
  
  private Map classes, colors, icons ;
  private Date crt = new Date () ;
  private String s1, s2 ;
  private int key ;

  private String styleSheet () {
    StringBuffer b = new StringBuffer () ;
    try {
      for (Iterator i = classes.entrySet ().iterator () ; i.hasNext () ; ) {
        Map.Entry x = (Map.Entry) i.next () ;
        Style y = (Style) x.getValue () ;
        b.append (y.format ((String) x.getKey ())) ;
      }
    }
    catch (Exception e) {
      b.append (m1_1) ;
      b.append (e.getMessage ()) ;
      b.append (m1_2) ;
    }
    finally {
      return b.toString () ;
    }
  }

  public BasePageImpl (BasePageImpl a) {
    classes = a.classes ;
    colors = a.colors ;
    icons = a.icons ;
    s1 = a.s1 ;
    s2 = a.s2 ;
    key = a.key ;
  }

  public BasePageImpl (String a, String b, String c, int d, int e, Color bgColor, Color linkColor, Color vlinkColor, Image bgImage, Map m1, Map m2, int n) {

    classes = m1 ;
    icons = m2 ;
    key = n ;
 
    s1 = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">\n" +
         incomm ("INFO: begin section formatted by: PageLayoutBase /" + a + "/ loaded on: " + crt.toString ()) +
         "<html>\n" +
         "<head>\n" +
         "<meta http-equiv=\"content-type\" content=\"text/html; charset=ISO-8859-1\">" +
         "<title>" + (c == null ? "no title" : c) + "</title>\n" + 
         (b == null ? "" : b) + 
         "</head>\n" +
         "<style type=\"text/css\"><!--\n" + 
         styleSheet () + 
         "//-->\n"+
         "</style>\n" +
         "<body topmargin=\"" + Integer.toString (d) + "\" leftmargin=\"" + Integer.toString (e) + "\" bgcolor=\"" + bgColor.hex () + "\" link=\"" + linkColor.hex () + "\" vlink=\"" + vlinkColor.hex () + "\" background=\"" + bgImage.url () + "\">\n" ;
    s2 = "</body>\n" +
         incomm ("Terminkalender (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004") +
         "</html>\n" ;
  }

  public int id () {
  	return key ;
  }

  public String incomm (String a) {
    return "<!--\n\t" + a + "\n//-->\n" ;
  }

  public Icon icon (String key) throws IllegalArgumentException {
    Icon x = (Icon) icons.get (key) ;
    if (x == null) throw new IllegalArgumentException ("PageLayoutBaseImpl.icon (...) key /" + key + "/ not found.") ;
    return x ;
  }

  public Style style (String key) throws IllegalArgumentException {
    Style x = (Style) classes.get (key) ;
    if (x == null) throw new IllegalArgumentException ("PageLayoutBaseImpl.style (...) key /" + key + "/ not found.") ;
    return x ;
  }

  public Color color (String key) throws IllegalArgumentException {
    Color x = new Color (0,0,0) ;
    if (x == null) throw new IllegalArgumentException ("PageLayoutBaseImpl.color (...) key /" + key + "/ not found.") ;
    return x ;
  }

  String iconHook (Icon d) {
    return iconHook (d, d.alt ()) ;
  }

  String iconHook (Icon d, String alt) {
  	StringBuffer b = new StringBuffer () ;
  	b.append ("<img src=\"") ;
  	b.append (d.url ()) ;
  	b.append ("\" border=\"") ;
  	b.append (d.border ()) ;
  	b.append ("\" width=\"") ;
  	b.append (d.xsize ()) ;
  	b.append ("\" height=\"") ;
  	b.append (d.ysize ()) ;
  	b.append ("\" alt=\"") ;
  	b.append (alt) ;
  	b.append ("\" title=\"") ;
  	b.append (alt) ;
  	b.append ("\">\n") ;
    return  b.toString () ;
  }

  String iconHook (Icon d, JumpTarget t) {
    return t.wrap (iconHook (d)) ;
  }

  String iconHook (Icon d, JumpTarget t, String alt) {
    return t.wrap (iconHook (d, alt)) ;
  }

  public IconHook iiconHook (String key) {
  	return new IconHookImpl (key) ;
  }

  public IconHook iiconHook (String key, String alt) {
  	return new IconHookImpl (key, alt) ;
  }

  public String iconHook (String key) {
    return icons.containsKey (key) ? iconHook ((Icon) icons.get (key)) : m2_1 + key + m2_2 ;
  }

  public String iconHook (String key, String alt) {
    return icons.containsKey (key) ? iconHook ((Icon) icons.get (key), alt) : m2_1 + key + m2_2 ;
  }

  public String iconHook (String key, JumpTarget tar) {
    return icons.containsKey (key) ? iconHook ((Icon) icons.get (key), tar) : m2_1 + key + m2_2 ;
  }

  public String format (String a) {
    StringBuffer b = new StringBuffer () ;
    b.append (s1) ;
    b.append (a) ;
    b.append (s2) ;
    return b.toString () ;
  }
}