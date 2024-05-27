// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import java.util.Map ;
import java.util.List ;
import java.util.Iterator ;

import misc.Detail ;
import misc.JumpTarget ;
import misc.ConnectionInfo ;

import html.text.DetailFormat ;

import html.list.* ;
import html.form.Form ;

public interface ListPage {
	
  public abstract BodyPage bodyPage () ;

  public abstract IconTextRow iconTextRow (String a, String b) ;

  public abstract IconTextRow iconTextRow (String a, String b, JumpTarget c) ;

  public abstract IconDetailRow iconDetailRow (String a, Detail b) ;

  public abstract IconDetailRow iconDetailRow (String a, Detail b, JumpTarget c) ;

  public abstract IconDetailRow iconDetailRow (String a, Detail b, JumpTarget c, DetailFormat d) ;

  public abstract TextRow textRow (String a) ;

  public abstract TextRow textRow (String a, JumpTarget b) ;

  public abstract TextTextRow textTextRow (String a, String b) ;

  public abstract TextTextRow textTextRow (String a, String b, JumpTarget c) ;

  public abstract IconConInfoRow iconConInfoRow (String a, ConnectionInfo b) ;

  public abstract String format (List l, String caption) ;

  public abstract String format (List l, String caption, String toolchest) ;

  public abstract String format (Form f, List l, String caption) ;
  
  public abstract String format (Form f, List l, String caption, Map m) ;
}