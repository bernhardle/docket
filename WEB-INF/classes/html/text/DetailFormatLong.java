// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html.text ;

import java.text.DateFormat ;

import misc.Style ;
import misc.DType ;
import misc.Context ;
import misc.Detail ;
import misc.JumpTarget ;

public class DetailFormatLong extends DetailFormat {

  private final static DateFormat df  = DateFormat.getDateInstance (DateFormat.LONG) ;
  private String fileLoc, assnLoc, enddLoc, subjLoc, cnxtLoc, typeLoc ;

  private String begTable = "<table border=\"0\" class=\"detail0x0x1\">\n" ;
  private final String endTable = "</table>\n" ;
  private String begRow = "<tr><td>" ;
  private String begDoubleRow = "<tr><td colspan=\"2\">" ;
  private String midRow = "</td><td>" ;
  private final String endRow = "</td></tr>\n" ;

  public DetailFormatLong (String prefix, String a, String b, String c, String d, String e, String f) {
    fileLoc = misc.Helper.nameConvert (a) ;
    assnLoc = misc.Helper.nameConvert (b) ;
    enddLoc = misc.Helper.nameConvert (c) ;
    subjLoc = misc.Helper.nameConvert (d) ;
    cnxtLoc = misc.Helper.nameConvert (e) ;
    typeLoc = misc.Helper.nameConvert (f) ;
    begTable = "<table border=\"0\" class=\"" + prefix + "0x0x1\">\n" ;
  }
 
  public String format (Detail d) {
    return format (d, null) ;
  }

  public String format (Detail d, JumpTarget jmp) {
    DType typ = d.type () ;
    
    StringBuffer b = new StringBuffer () ;
    b.append (begTable) ;
    b.append (d.done () ? "<td colspan=\"2\" class=\"detail1x1x" : "<td colspan=\"2\" class=\"detail1x0x") ;
    b.append (Integer.toString (typ.colorID ())) ;
    b.append ("\">") ;
    b.append (typeLoc) ;
    b.append (misc.Helper.nameConvert (typ.description ())) ;
    b.append (endRow) ;
    b.append (d.done () ? "<td colspan=\"2\" class=\"detail0x1x" : "<td colspan=\"2\" class=\"detail0x0x") ;
    b.append (Integer.toString (typ.context ().colorID ())) ;
    b.append ("\">") ;
    b.append (cnxtLoc) ;
    b.append (misc.Helper.nameConvert (typ.context ().description ())) ;
    b.append (endRow) ;
    if (d.file () != null) {
      b.append (begRow) ;
      b.append (fileLoc) ;
      b.append (midRow) ;
      b.append (misc.Helper.nameConvert (d.file ())) ;
      b.append (endRow) ;
    }
    b.append (begRow) ;
    b.append (enddLoc) ;
    b.append (d.done () ? "</td><td class=\"detail1x1x1\">" : "</td><td class=\"detail1x0x1\">") ;
    String s = misc.Helper.nameConvert (df.format (d.date ())) ;
    b.append (jmp == null ? s : jmp.wrap (s)) ;
    b.append (endRow) ;
// Subject
    b.append (begRow) ;
    b.append (subjLoc) ;
    b.append (midRow) ;
    b.append (misc.Helper.nameConvert (d.subject ())) ;
    b.append (endRow) ;
// Bearbeiter
    b.append (begRow) ;
    b.append (assnLoc) ;
    b.append (midRow) ;
    b.append (misc.Helper.nameConvert (d.assigned ())) ;
    b.append (endRow) ;
// Kommentar
    b.append (begDoubleRow) ;
    b.append (misc.Helper.nameConvert (d.comment ())) ;
    b.append (endRow) ;
// Linie
    b.append (begDoubleRow) ;
    b.append ("<hr align=\"left\" width=\"55%\" size=\"1\">") ;
    b.append (endRow) ;
// Tabellenende
    b.append (endTable) ;
    return b.toString () ;
  }
}