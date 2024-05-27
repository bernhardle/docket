// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package misc ;

final public class Style implements misc.comparison.ID {

  private int id, padding ;
  private String font, s1, s2 ;
  private Color color ;
  private int size, line ;
  private boolean bold, slanted, strike, underline ;

  public Style (int i, String b, Color c, int d, int e, int e1, boolean f, boolean g, boolean x1, boolean x2) {
    font = b ;
    color = c ;
    size = d ;
    line = e;
    bold = f ;
    padding = e1 ;
    slanted = g ;
    strike = x1 ;
    underline = x2 ;
    id = i ;
    {
    	StringBuffer x = new StringBuffer () ;
    	x.append ("\t/*\t") ;
  	  x.append (Integer.toString (key ())) ;
  	  x.append ("\t*/\t") ;
    	s1 = x.toString () ;
    }
    {
      StringBuffer x = new StringBuffer () ;
      x.append ("font-family: ") ;
      x.append (font ()) ;
      x.append ("; font-size: ") ;
      x.append (Integer.toString (size ())) ;
      x.append ("px; ") ;
      if (line () > 0) {
        x.append ("line-height: ") ;
        x.append (Integer.toString (line ())) ;
        x.append ("px; ") ;
      }
      if (padding () > 0) {
      	x.append ("padding: ") ;
        x.append (Integer.toString (padding ())) ;
        x.append ("px; ") ;
      }
      x.append ("font-weight: ") ;
      x.append (bold () ? "bold" : "normal") ;
      x.append ("; font-style: ") ;
      x.append (slanted () ? "italic" : "normal") ;
      x.append ("; ") ;
      if (strike () || underline ()) {	// Textdekoration ...
      	x.append ("text-decoration:") ;
      	if (strike ())    x.append (" line-through") ;
      	if (underline ()) x.append (" underline") ;
      	x.append ("; ") ;
      }
      x.append ("color: ") ;						// Textfarbe ...
      x.append (color ().rgb ()) ;
      x.append ("; ") ;
      s2 = x.toString () ;
    }
  }

  public int id () {
  	return id ;
  }

  public int key () {
    return id ;
  }

  public String font () {
    return font ;
  }

  public Color color () {
    return color ;
  }

  public int size () {
    return size ;
  }

  public int line () {
   return line ; 
  }

  public int padding () {
  	return padding ;
  }

  public boolean bold () {
    return bold ;
  }

  public boolean slanted () {
    return slanted ;
  }

  public boolean strike () {
  	return strike ;
  }
  
  public boolean underline () {
  	return underline ;
  }

  public String format () {		// 'DEPRECATED' Wird von den Inputs leider noch verwendet ...
  	return s2 ;
  }

  public String format (String name) {
  	StringBuffer b = new StringBuffer () ;
  	b.append (s1) ;
  	if (!name.startsWith (".")) b.append (" ") ;
  	b.append (name) ;
  	b.append (" { ") ;
  	b.append (s2) ;
  	b.append (" }\n") ;
    return b.toString () ;
  }
}