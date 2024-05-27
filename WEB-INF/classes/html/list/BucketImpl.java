// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2000-2004

package html.list ;

import java.util.Iterator ;
import java.util.LinkedList ;

import misc.JumpTarget ;
import misc.Detail ;
import misc.ConnectionInfo ;

import html.BasePage ;

import html.text.DetailFormat ;
import html.text.DetailFormatMedium ;
import html.text.ConnectionInfoFormat ;

final class BucketImpl implements BucketHolder {

  private final static String m1 = "FATAL: exception \'" ;
  private final static String m2 = "\' in: html.list.BucketImpl.format ()\n" ;

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
      b.append (a3 == null ? f1.format (a2) : f1.format (a2,a3)) ;
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

    private String a1 ;
    private ConnectionInfo a2 ;
    private ConnectionInfoFormat a3 ;

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

  private BasePage b1 ;
  private LinkedList l1 ;
  private String s1, s2, s3, s4, s5, s10, s11 ;
  private int d = 0, e = 2, f = 3 ;
  
  BucketImpl (BasePage a, int i, int h, int w) {

	// i: Anzahl der Spalten
	// h: Spaltenhöhe
	// w: Breite der linken Spalte

    if (i < 1) throw new IllegalArgumentException ("ouhhh shit ...") ;
    l1 = new LinkedList () ;
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
      b.append ("\" align=\"center\" valign=\"middle\">\n") ;
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

    s10 = "<!--\n\tINFO: begin section formatted by: html.form.BucketImpl\n//-->\n" +
          "<table width=\"100%\" border=\"" + Integer.toString (d) + 
          "\" cellpadding=\"" + Integer.toString (e) + 
          "\" cellspacing=\"" + Integer.toString (f) + 
          "\">\n" ;
    s11 = "</table>\n" +
          "<!--\n\tINFO: end section formatted by: html.form.BucketImpl\n//-->\n" ;
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
  
  public String format () {

    StringBuffer b = new StringBuffer (s10) ;

    for (Iterator i = l1.iterator () ; i.hasNext () ; ) {
      try {
        b.append (((Row) i.next ()).format ()) ;
      }
      catch (Exception e) {
        b.append (s1) ; 
        b.append (m1) ;
        b.append (e.getClass ().getName ()) ;
        b.append (m2) ;
        b.append (s2) ;
      }
    }

    b.append (s11) ;

    return b.toString () ;
  }
}