// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004
// -> dieser Quellcode ist noch im Bau ...

package html ;

import java.util.Map ;
import java.util.Date ;
import java.util.List ;
import java.util.Iterator ;
import java.util.LinkedList ;

import misc.Style ;
import misc.Icon ;
import misc.Color ;
import misc.Detail ;
import misc.JumpTarget ;
import misc.ConnectionInfo ;

import html.text.DetailFormat ;
import html.text.DetailFormatLong ;
import html.text.DetailFormatMedium ;
import html.text.ConnectionInfoFormat ;

import html.list.* ;
import html.form.Form ;
import html.form.Input ;

public class ListPageImpl implements ListPage {

  final static String m1 = "FATAL: exception \'" ;
  final static String m2 = "\' in: html.ListPageImpl.format ()\n" ;

  final class IconTextRowImpl extends IconTextRow {

    private String a1, a2 ;
    private JumpTarget a3 ;

    IconTextRowImpl (String a, String b) {
      a1 = a ;
      a2 = b ;
    }

    IconTextRowImpl (String a, String b, JumpTarget c) {
      a1 = a ;
      a2 = b ;
      a3 = c ;
    }

    public String format () {
      StringBuffer b = new StringBuffer () ;
      b.append (s3) ;
      b.append (a3 == null ? b1.iconHook (a1) : b1.iconHook (a1, a3)) ;
      b.append (s4) ;
      b.append (a3 == null ? a2 : a3.wrap (a2)) ;
      b.append (s5) ;
      return b.toString () ;
    }
  }

  final class IconDetailRowImpl extends IconDetailRow {

    private String a1 ;
    private Detail a2 ;
    private JumpTarget a3 ;
    private DetailFormat f1 ;

    IconDetailRowImpl (String a, Detail b) {
      a1 = a ;
      a2 = b ;
      f1 = new DetailFormatMedium ("detail") ;
    }

    IconDetailRowImpl (String a, Detail b, JumpTarget c) {
      a1 = a ;
      a2 = b ;
      a3 = c ;
      f1 = new DetailFormatMedium ("detail") ;
    }

    IconDetailRowImpl (String a, Detail b, JumpTarget c, DetailFormat d) {
      a1 = a ;
      a2 = b ;
      a3 = c ;
      f1 = d ; 
    }

    public String format () {
      StringBuffer b = new StringBuffer () ;
      b.append (s3) ;
      b.append (a3 == null ? b1.iconHook (a1) : b1.iconHook (a1, a3)) ;
      b.append (s4) ;
//      b.append (a3 == null ? f1.format (a2) : f1.format (a2,a3)) ;
      b.append (f1.format (a2)) ;
      b.append (s5) ;
      return b.toString () ;
    }
  }

  final class TextDetailRowImpl extends TextDetailRow {
  	
  	private DetailFormat f1 ;
  	private String s1 ;
  	private Detail d1 ;
  	private int i1, i2 ;
  	
  	TextDetailRowImpl (String a, Detail b, int c, int d) {
  		s1 = a ;
  		d1 = b ;
  		i1 = c ;
  		i2 = d ;
  		f1 = DetailFormat.getInstance (DetailFormat.LONG) ;
  	}
  	
  	TextDetailRowImpl (String a, Detail b, int c, int d, DetailFormat e) {
  		s1 = a ;
  		d1 = b ;
  		i1 = c ;
  		i2 = d ;
  		f1 = e ;
  	}
  	
  	public String format () {
  		StringBuffer b = new StringBuffer () ;
  		b.append (s3) ;
      b.append (s1) ;
      b.append (s4) ;
      b.append (f1.format (d1)) ;
      if (i1 > 0 && i2 > 0) {
      	b.append ("<hr align=\"left\" width=\"") ;
      	b.append (Integer.toString (i1)) ;
      	b.append ("%\" size=\"") ;
      	b.append (Integer.toString (i2)) ;
      	b.append ("\">\n") ;
      }
      b.append (s5) ;
  		return b.toString () ;
  	}
  }

  final class TextRowImpl extends TextRow {

    private String a1 ;
    private JumpTarget a2 ;

    TextRowImpl (String a) {
      a1 = a ;
    }

    TextRowImpl (String a, JumpTarget b) {
      a1 = a ;
      a2 = b ;
    }

    public String format () {
      StringBuffer b = new StringBuffer () ;
      b.append (s1) ;
      b.append (a2 == null ? a1 : a2.wrap (a1)) ;
      b.append (s2) ;
      return b.toString () ;
    }
  }

  final class TextTextRowImpl extends TextTextRow {
  	
    private String e1, e2 ;
    private JumpTarget j1 ;

    TextTextRowImpl (String a, String b) {
      e1 = a ;
      e2 = b ;
    }

    TextTextRowImpl (String a, String b, JumpTarget c) {
      e1 = a ;
      e2 = b ;
      j1 = c ; 
    }

    public String format () {
      StringBuffer b = new StringBuffer () ;
      b.append (s3) ;
      b.append (j1 == null ? e1 : j1.wrap (e1)) ;
      b.append (s4) ;
      b.append (j1 == null ? e2 : j1.wrap (e2)) ;
      b.append (s5) ;
      return b.toString () ;
    }
  }

  final class IconConInfoRowImpl extends IconConInfoRow {

    String a1 ;
    ConnectionInfo a2 ;
    ConnectionInfoFormat a3 ;

    IconConInfoRowImpl (String a, ConnectionInfo b) {
      a1 = a ;
      a2 = b ;
      a3 = new ConnectionInfoFormat () ;
    }

    public String format () {
      StringBuffer b = new StringBuffer () ;
      b.append (s3) ;
      b.append (b1.iconHook (a1)) ;
      b.append (s4) ;
      b.append (a3.format (a2)) ;
      b.append (s5) ;
      return b.toString () ;
    }
  }

  private String s1, s2, s3, s4, s5, s10, s11 ;
  private BodyPage b1 ;
  private Date d1 = new Date () ;

  public ListPageImpl (BodyPage a, String n, int w, int d, int e, int f, int h) {

    int i = 2 ;

	// Argumente: 
	// a: der BodyFormatierer
	// x: das Formular (kann auch 'null' sein)
	// n: der Name (ohne Bedeutung)
	// d: Rahmenstärke
	// e: Padding
	// f: Spacing
	// i: Anzahl der Spalten
	// h: Zeilenhöhe
	// w: Breite der linken Spalte

    if (i < 1) throw new IllegalArgumentException ("ouhhh shit ...") ;
    b1 = a ;
    {
      StringBuffer b = new StringBuffer () ;
      b.append ("<tr>\n") ;
      b.append ("<td ") ;
      if (i > 1) {
        b.append ("colspan=\"") ;
        b.append (Integer.toString (i)) ;
        b.append ("\" ") ;
      }
      b.append ("height=\"") ;
      b.append (Integer.toString (h)) ;
      b.append ("\" align=\"left\" valign=\"middle\">\n") ;
      b.append ("<font class=\"caption\">\n") ;
      s1 = b.toString () ;
    }
    {
      StringBuffer b = new StringBuffer () ;
      b.append ("</font>\n") ;
      b.append ("</td>\n") ;
      b.append ("</tr>\n") ;
      s2 = b.toString () ;
    }
    {
      StringBuffer b = new StringBuffer () ;
      b.append ("<tr>\n") ;
      b.append ("<td ") ;
      b.append ("height=\"") ;
      b.append (Integer.toString (h)) ;
      b.append ("\" width=\"") ;
      b.append (Integer.toString (w)) ;
      b.append ("\" align=\"left\" valign=\"middle\">\n") ;
      s3 = b.toString () ;
    }
    {
      StringBuffer b = new StringBuffer () ;
      b.append ("</td>\n") ;
      b.append ("<td ") ;
      if (i > 2) {
        b.append ("colspan=\"") ;
        b.append (Integer.toString (i - 1)) ;
        b.append ("\" ") ;
      }
      b.append ("align=\"left\" valign=\"middle\">\n") ;
      s4 = b.toString () ;
    }
    {
      StringBuffer b = new StringBuffer () ;
      b.append ("</td>\n") ;
      b.append ("</tr>\n") ;
      s5 = b.toString () ;
    }
    {
      StringBuffer b = new StringBuffer () ;
      b.append ("<!--\n\tINFO: begin section formatted by: ") ;
      b.append (getClass ().getName ()) ;
      b.append (" /") ;
      b.append (n) ;
      b.append ("/ loaded on: ") ;
      b.append (d1.toString ()) ;
      b.append ("\n//-->\n") ;
      b.append ("<table width=\"100%\" border=\"") ;
      b.append (Integer.toString (d)) ;
      b.append ("\" cellpadding=\"") ;
      b.append (Integer.toString (e)) ;
      b.append ("\" cellspacing=\"") ;
      b.append (Integer.toString (f)) ;
      b.append ("\">\n") ;
      s10 = b.toString () ;
    }
    {
      StringBuffer b = new StringBuffer () ;
      b.append ("</table>\n") ;
      b.append ("<!--\n\tINFO: end section formatted by: ") ;
      b.append (getClass ().getName ()) ;
      b.append ("\n//-->\n") ;
      s11 = b.toString () ;
    }
  }

  protected String _format (List l) {

    StringBuffer b = new StringBuffer (s10) ;

    for (Iterator i = l.iterator () ; i.hasNext () ; ) {
      try {
        b.append (((Row) i.next ()).format ()) ;
      }
      catch (Exception e) {
        b.append (s2) ; 
        b.append (m1) ;
        b.append (e.getMessage ()) ;
        b.append (m2) ;
        b.append (s3) ;
      }
    }

    b.append (s11) ;

    return b.toString () ;
  }

  public TextRow textRow (String a) {
    return new TextRowImpl (a) ;
  }
 
  public TextRow textRow (String a, JumpTarget b) {
    return new TextRowImpl (a,b) ;
  }

  public TextTextRow textTextRow (String a, String b) {
    return new TextTextRowImpl (a,b) ;
  }
 
  public TextTextRow textTextRow (String a, String b, JumpTarget c) {
    return new TextTextRowImpl (a,b,c) ;
  }

  public IconTextRow iconTextRow (String a, String b) {
    return new IconTextRowImpl (a,b) ;
  }

  public IconTextRow iconTextRow (String a, String b, JumpTarget c) {
    return new IconTextRowImpl (a,b,c) ;
  }

  public IconDetailRow iconDetailRow (String a, Detail b) {
    return new IconDetailRowImpl (a,b) ;
  }
  
  public IconDetailRow iconDetailRow (String a, Detail b, JumpTarget c) {
    return new IconDetailRowImpl (a,b,c) ;
  }

  public IconDetailRow iconDetailRow (String a, Detail b, JumpTarget c, DetailFormat d) {
    return new IconDetailRowImpl (a,b,c,d) ;
  }

  public IconConInfoRow iconConInfoRow (String a, ConnectionInfo b) {
    return new IconConInfoRowImpl (a,b) ;
  }

  public String format (List l, String title) {
    return b1.format (_format (l),title) ;
  }

  public String format (List l, String title, String toolchest) {
    return b1.format (_format (l),title,toolchest) ;
  }
  
  public String format (Form f, List l, String t) {
    return b1.format (f.wrap (_format (l)), t) ;
  }
  
  public String format (Form f, List l, String t, Map m) {
    return b1.format (f.wrap (_format (l), m), t) ;
  }
  
  public BodyPage bodyPage () {
  	return b1 ;
  }	
}