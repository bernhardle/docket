// (c) Bernhard Schupp; Frankfurt-München; 2002-2003

package misc ;

public class Item {

  private Jump jmp ;
  private String lbl ;
  private String ico ;

  public Item (Jump a, String b, String c) {
    jmp = a ;
    lbl = b ;
    ico = c ;
  }

  public Jump jump () {
    return jmp ;
  }

  public String label () {
    return lbl ;
  }

  public String icon () {
    return ico ;
  }
}