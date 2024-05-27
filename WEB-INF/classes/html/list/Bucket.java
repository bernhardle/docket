// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2000-2004

package html.list ;

import java.util.List ;
import java.util.Iterator ;

import misc.Detail ;
import misc.JumpTarget ;
import misc.ConnectionInfo ;

import html.text.DetailFormat ;

public interface Bucket {

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
}