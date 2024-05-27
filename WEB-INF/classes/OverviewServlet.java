// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004
//     Dieses Servlet hat leider bis heute seinen 
//     undurchsichtigsten Aufbau von allen. /BS

import java.sql.Date ;

import java.io.PrintWriter ;
import java.io.IOException ;

import java.util.List ;
import java.util.Iterator ;
import java.util.LinkedList ;
import java.util.Properties ;
import java.util.Locale ;
import java.util.Calendar ;
import java.util.ResourceBundle ;
import java.util.GregorianCalendar ;

import java.text.DateFormat ;
import java.text.MessageFormat ;

import javax.servlet.*;
import javax.servlet.http.*;

import html.BasePage ;

import misc.Pair ;
import misc.Jump ;
import misc.Color ;
import misc.Ticket ;
import misc.Deadline ;
import misc.Notification ;
import misc.JumpTarget ;
import misc.ObjectWrapper ;

import data.DataSourceException ;
import data.DataSourceConfiguration ;
import data.DataSourceLayout ;
import data.DataSourceScheduleRead ;

final public class OverviewServlet extends MyBasicHttpServlet {

  private final static DateFormat dateFormatFull  = DateFormat.getDateInstance (DateFormat.FULL) ;
  private final static DateFormat dateFormtMedium = DateFormat.getDateInstance (DateFormat.MEDIUM) ;
  
  private final static String tdyArg = "today" ;
  private final static String pageHeader = "<!--\n\tINFO: begin section formatted by: OverviewServlet\n//-->\n<table border=\"0\" width=\"790\" height=\"60\"><tr>\n<td valign=\"middle\" align=\"left\" height=\"60\" width=\"70%\"><font class=\"date\">\n" ;
  private final static String pageMidA =	"</font></td>\n<td valign=\"middle\" align=\"right\" height=\"60\" width=\"30%\">" ;
  private final static String pageMidB = "</td></tr>\n<tr><td width=\"100%\" valign=\"middle\" align=\"left\" height=\"1\" colspan=\"2\">\n" ;
  private final static String pageTrailer = "</td></tr>\n</table>\n<!--\n\tINFO: end section formatted by: OverviewServlet\n//-->\n" ;
  private final static String begHeadingFont = "<font class=\"head\">" ;
  private final static String endHeadingFont = "</font>" ;
  private final static String endLine = "</tr>\n" ;
  private final static String endRowL = "</td>\n" ;
  private final static String endRowR = "</td>" + endLine ;
  private final static String endOuterTab = "</table>\n" ;

  private final static String endBlock = "</td>\n" ;
  private final static String endHref = "</a>" ;
  private final static String endInnerTab = "</table>\n" ;
  private final static String begStrike = "<strike>" ;
  private final static String endStrike = "</strike>" ;
  private final static String begStrong = "<strong>" ;
  private final static String endStrong = "</strong>" ;

  private final static String param__id = "id" ;			//
  private final static String param_dat = "date" ;

	// die nachfolgenden Variablen werden vom init () gesetzt

  private boolean allowShowEmptyHeading, allowDeleteFutureDeadline, allowDeleteFutureNotification ;
  private boolean extensionActivate = false ;

  private int extensionContext = -1 ;
  private int wTable, wRowL, wFile, wType, wDate, wSpace, wCheck ; 
  private int labelCharsL, labelCharsR, hRow, wRowR, wLabelL, wLabelR ;
  private int innerPadding = 0 , innerSpacing = 1, outerPadding = 1, outerSpacing = 1 ;
  
  private String major ;
  private String iconLeft, iconBall, iconBlank, iconRight ;
  private String begOuterTab, begInnerTab, deadlineLoc, notificationLoc ; 
  private String begLine, begDefRowL, begDefRowLB, begHilRowL ;
  private String begDefRowR, begDefRowRB, begHilRowR ;
  private String emptyL, emptyLB, emptyR, emptyRB ;
  private String begCheck, begSpaceEnd ;

  private BasePage pageLayout ;

  private Color defaultColor, defaultColorB, highlightColor, borderColor ;
  
  private MessageFormat begFile, begType, begLabelR, begDate, begLabelL ;
  
  final class ToolChest {
  	
    private String a = "<table border=\"0\" cellpadding=\"5\" cellspacing=\"0\">\n<tr><td>" ;
    private String b = "</td><td>" ;
    private String c = "</td></tr></table>\n" ;

    ToolChest () {}

    String htmlFormat (JumpTarget j1, JumpTarget j2, JumpTarget j3) {
    	StringBuffer x = new StringBuffer () ;
    	x.append (a) ;
    	x.append (j1.wrap (iconLeft)) ;
    	x.append (b) ;
    	x.append (j2.wrap (iconBall)) ;
    	x.append (b) ;
    	x.append (j3.wrap (iconRight)) ;
    	x.append (c) ;
      return x.toString () ;
    }
    
    String htmlFormat (JumpTarget j1, JumpTarget j2, JumpTarget j3, JumpTarget j4) {
   	  StringBuffer x = new StringBuffer () ;
    	x.append (a) ;
    	x.append (j1.wrap (iconBlank)) ;
    	x.append (b) ;
    	x.append (j2.wrap (iconLeft)) ;
    	x.append (b) ;
    	x.append (j3.wrap (iconBall)) ;
    	x.append (b) ;
    	x.append (j4.wrap (iconRight)) ;
    	x.append (c) ;
      return x.toString () ;
    }
  }

  private ToolChest toolChest ;
  private Jump j1, j2, j3, j4 ;

  static List split (List deadlines, int context) {
	// Interne Fristen spezial: trennen der Liste in interne/normale Fristen.
    LinkedList intern = new LinkedList () ;
    for (Iterator i = deadlines.iterator () ; i.hasNext () ; ) {
      Deadline d = (Deadline) i.next () ;
      if (d.context () == context) { i.remove () ; intern.add (d) ; }
    }
    return intern ;
  }

  protected void reload () throws ServletException {
    try {
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      ResourceBundle r = d.resourceBundle (major) ;
      Properties p = d.properties (major) ;

      pageLayout = d.basePage (def,getInitParameter("layout")) ;

      extensionActivate = Boolean.valueOf (p.getProperty ("reichelExtensionActivate")).booleanValue() ;
      if (extensionActivate) extensionContext = Integer.parseInt (p.getProperty ("reichelExtensionContext")) ;

      allowShowEmptyHeading = Boolean.valueOf (p.getProperty ("allowShowEmptyHeading")).booleanValue() ;
      allowDeleteFutureDeadline = Boolean.valueOf (p.getProperty ("allowDeleteFutureDeadline")).booleanValue() ;
      allowDeleteFutureNotification = Boolean.valueOf (p.getProperty ("allowDeleteFutureNotification")).booleanValue() ;

      labelCharsL = Integer.parseInt (p.getProperty ("labelCharsL")) ;
      labelCharsR = Integer.parseInt (p.getProperty ("labelCharsR")) ;

      hRow = Integer.parseInt (p.getProperty ("rowHeight")) ;

      wTable = Integer.parseInt (p.getProperty ("wTable")) ;
      wRowL = Integer.parseInt (p.getProperty ("wRowL")) ;
      wFile = Integer.parseInt (p.getProperty ("wFile")) ;
      wType = Integer.parseInt (p.getProperty ("wType")) ;
      wDate = Integer.parseInt (p.getProperty ("wDate")) ;
      wSpace = Integer.parseInt (p.getProperty ("wSpace")) ;
      wCheck = Integer.parseInt (p.getProperty ("wCheck")) ;

      deadlineLoc = r.getString ("deadlineLoc") ;
      notificationLoc = r.getString ("notificationLoc") ;

      iconLeft = pageLayout.iconHook ("prev") ;
      iconBall = pageLayout.iconHook ("today") ;
      iconRight = pageLayout.iconHook ("next") ;
      iconBlank = pageLayout.iconHook ("prevatt") ;
      
      toolChest = new ToolChest () ;
      
      j1 = d.jump (27) ;	// Detail ohne zurück
      j2 = d.jump (53) ;	// Eintrag löschen
      j3 = d.jump (66) ;	// Übersicht nach Tag
      j4 = d.jump (44) ;	// Zur Übersicht des Haupteintrags
      
      borderColor = d.color (Integer.parseInt (p.getProperty ("borderColor"))) ;
      defaultColor = d.color (Integer.parseInt (p.getProperty ("oddRowColor"))) ;
      defaultColorB = d.color (Integer.parseInt (p.getProperty ("evenRowColor"))) ;
      highlightColor = d.color (Integer.parseInt (p.getProperty ("highlightColor"))) ;

      wRowR   = 100 - wRowL ;
      wLabelL = 100 - wFile - wSpace - wType - wSpace - wCheck ;
      wLabelR = 100 - wFile - wSpace /* - wType - wSpace */ - wDate - wCheck ;

      begOuterTab  = "<table border=\"0\" cellspacing=\"" + Integer.toString (outerSpacing) + "\" cellpadding=\"" + Integer.toString (outerPadding) + "\" width=\"" + wTable + "%\" bgcolor=\"" + borderColor.hex () + "\">\n" ;
      begInnerTab  = "<table border=\"0\" cellspacing=\"" + Integer.toString (innerSpacing) + "\" cellpadding=\"" + Integer.toString (innerPadding) + "\" width=\"100%\" height=\"" + Integer.toString (hRow) + "\">\n" ;
      
      begLine      = "<tr height=\"" + Integer.toString (hRow) + "\">\n" ;
      begDefRowL   = begLine + "<td bgcolor=\"" + defaultColor.hex () + "\">" ;
      begDefRowLB  = begLine + "<td bgcolor=\"" + defaultColorB.hex () + "\">" ;
      begHilRowL   = begLine + "<td bgcolor=\"" + highlightColor.hex () + "\">" ;
      begDefRowR   =           "<td bgcolor=\"" + defaultColor.hex () + "\">" ;
      begDefRowRB  =           "<td bgcolor=\"" + defaultColorB.hex () + "\">" ;
      begHilRowR   =           "<td bgcolor=\"" + highlightColor.hex () + "\">" ;
 
      emptyL       = begLine + "<td bgcolor=\"" + defaultColor.hex () + "\">&nbsp;</td>" ;
      emptyLB      = begLine + "<td bgcolor=\"" + defaultColorB.hex () + "\">&nbsp;</td>" ;
      emptyR       =           "<td bgcolor=\"" + defaultColor.hex () + "\">&nbsp;</td>" + endLine ;
      emptyRB      =           "<td bgcolor=\"" + defaultColorB.hex () + "\">&nbsp;</td>" + endLine ;
			//
      begCheck     = "<td width=\"" + Integer.toString (wCheck) + "%\" align=\"right\" valign=\"middle\">" ;
      //
      begSpaceEnd  = "<td width=\"" + Integer.toString (wSpace) + "%\">" + endBlock ;
      //
			String style = "detail" ;
			//
      begFile   = new MessageFormat ("<td width=\"" + Integer.toString (wFile) + "%\" align=\"right\" class=\""+ style + "1x{0}x1\">{1}</td>\n") ;
			//
      begType   = new MessageFormat ("<td width=\"" + Integer.toString (wType) + "%\" align=\"center\" class=\"" + style + "1x{0}x{1}\">{2}</td>\n") ;
      //
      begLabelL = new MessageFormat ("<td width=\"" + Integer.toString (wLabelL) + "%\" align=\"left\" class=\"" + style + "0x{0}x1\">{1}</td>\n") ;
      //
      begLabelR = new MessageFormat ("<td width=\"" + Integer.toString (wLabelR) + "%\" align=\"left\" class=\"" + style + "0x{0}x1\">{1}</td>\n") ;
      //
      begDate   = new MessageFormat ("<td width=\"" + Integer.toString (wDate) + "%\" align=\"right\" class=\"" + style + "1x{0}x1\">{1}</td>\n") ;
      //
    }
    catch (DataSourceException e) {
    	throw new UnavailableException (e.getMessage ()) ;
    }
  }
 
  String header (int i, int j) {
    StringBuffer b = new StringBuffer () ;
    b.append ("<tr><td width=\"") ;
    b.append (wRowL) ;
    b.append ("%\" style=\"background-color: ") ;
    b.append (defaultColor.rgb ()) ;
    b.append (";\" align=\"center\" valign=\"middle\">") ;
    b.append (begHeadingFont) ;
    b.append (misc.Helper.nameConvert (deadlineLoc)) ;
    b.append (" (") ;
    b.append (Integer.toString (i)) ;
    b.append (") ") ;
    b.append (endHeadingFont) ;
    b.append ("</td>\n") ;
	  b.append ("<td width=\"") ;
	  b.append (wRowR) ;
	  b.append ("%\" style=\"background-color: ") ;
	  b.append (defaultColor.rgb ()) ;
	  b.append (";\" align=\"center\" valign=\"middle\">") ;
	  b.append (begHeadingFont) ;
	  b.append (misc.Helper.nameConvert (notificationLoc)) ;
	  b.append (" (") ;
    b.append (Integer.toString (j)) ;
    b.append (") ") ;
	  b.append (endHeadingFont) ;
	  b.append ("</td></tr>\n") ;
	  return b.toString () ;
  }
 
  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    String p1 = getInitParameter("major") ;
    major = p1 != null ? p1 : getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;

    String whn = request.getParameter (param_dat) ;

    try {

      DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter("schedule")) ;

      Date now = new Date (new java.util.Date ().getTime ()) ;
      Date tdy = misc.Helper.parseDate (now.toString ()) ;			// etwas kompliziert, aber so steht das Datum auf 0:00 Uhr
      Date dat = null ;

      int hld = -1 ;	// highlighted deadline
      int hln = -1 ;	// highlighted notification

      if (whn != null) {
        dat = whn.compareTo (tdyArg) == 0 ? tdy : misc.Helper.parseDate (whn) ;
      }
      else {
        String s1 = request.getParameter (param__id) ;
        hld = hln = Integer.parseInt (s1) ;
        dat = db.dateFromID (hld) ;
      }
      
      boolean  pmg = (u == null) ? false : u.permissions ().permDel () ;
      boolean  pmd = pmg ? (dat.after (tdy) ? allowDeleteFutureDeadline : true) : false ;
      boolean  pmn = pmg ? (dat.after (tdy) ? allowDeleteFutureNotification : true) : false ;
      boolean  datePast = dat.before (tdy) ;

	    StringBuffer table = new StringBuffer () ;
      {
      	
        Calendar tmp = Calendar.getInstance () ;

        tmp.setTime (dat) ;
        tmp.add (Calendar.DATE, -1) ;
        Object o [] = {new Date (tmp.getTime ().getTime ()).toString ()} ;
        JumpTarget l1 = j3.get (response, o) ;
        o [0] = tdyArg ;
        JumpTarget l2 = j3.get (response, o) ;
        tmp.add (Calendar.DATE, 2) ;
        o [0] = new Date (tmp.getTime ().getTime ()).toString () ;
        JumpTarget l3 = j3.get (response, o) ;

        Date xx = db.nextBefore (datePast ? dat : tdy) ;

        table.append (pageHeader) ;
        table.append (misc.Helper.htmlConvert (dateFormatFull.format (dat))) ;
        table.append (pageMidA) ; 
        if (xx == null) {
          table.append (toolChest.htmlFormat (l1, l2, l3)) ;
        }
        else {
        	Object r [] = {xx.toString ()} ;
          table.append (toolChest.htmlFormat (j3.get (response, r), l1, l2, l3)) ;
        }
      }
      
      table.append (pageMidB) ;

      List xx1 = new LinkedList (db.deadlineOV (dat)) ;
      List xx2 = extensionActivate ? split (xx1, extensionContext) : new LinkedList () ;
      Iterator intern =  xx2.iterator () ;
      Iterator deadlines = xx1.iterator () ;
      List xx3 = db.notificationOV (dat) ;
      Iterator notifications = xx3.iterator () ;

      if (deadlines.hasNext () || notifications.hasNext () || intern.hasNext () || allowShowEmptyHeading) {

        table.append (begOuterTab) ;

        table.append (header (xx1.size (), xx3.size () + xx2.size ())) ;

        for (int cnt = 0 ; deadlines.hasNext () || notifications.hasNext () || intern.hasNext () ; cnt ++) {
          if (deadlines.hasNext ()) {
            Deadline d = (Deadline) deadlines.next () ;

            Object o2 [] = {Integer.toString (d.id ())} ;
            JumpTarget td = j1.get (response, o2) ;

            int i = hld ;
            if (d.id () == i) {
              table.append (begHilRowL) ;
            }
            else {
              if (cnt % 2 == 0) {
                table.append (begDefRowLB) ;
              }
              else {
                table.append (begDefRowL) ;
              }
            }
            table.append (begInnerTab) ;
            
            {
            	Object o [] = {d.done () ? "1" : "0", td.wrap (misc.Helper.nameConvert (d.file ()))} ;
            	table.append (begFile.format (o)) ;
            }
            
            table.append (begSpaceEnd) ;
            
            {
            	Object o [] = {d.done () ? "1" : "0", Integer.toString (d.colorID ()), misc.Helper.nameConvert (d.type ())} ;
            	table.append (begType.format (o)) ;
            }

            table.append (begSpaceEnd) ;

            {
              String s = misc.Helper.nameConvert (d.label ().length () > labelCharsL ? d.label().substring (0, labelCharsL) : d.label ()) ; 
             	Object ox [] = {d.done () ? "1" : "0", td.wrap (s)} ;
             	table.append (begLabelL.format (ox)) ;
            }

            table.append (begCheck) ;
            if (pmd && ! d.done ()) {
            	Object o [] = {Integer.toString (d.id ())} ;
            	table.append (pageLayout.iconHook (datePast ? "delatt" : "delete", j2.get (response, o))) ;
            }
            else {
              table.append (pageLayout.iconHook (datePast && ! d.done () ? "att" : (d.done () ? "att1" : "att0"))) ;
            }
            table.append (endBlock) ;
            
            table.append (endInnerTab) ;
            table.append (endRowL) ;
          }
          else {
            table.append (cnt % 2 == 0 ? emptyLB : emptyL) ;
          }

          if (notifications.hasNext ()) {
            Notification n = (Notification) notifications.next () ;
            Deadline d = n.deadline () ;
            
            Object o [] = {Integer.toString (d.id ())} ;
            JumpTarget td = j1.get (response, o) ;
                        
            int i = hln ;
            if (n.id () == i) {
              table.append (begHilRowR) ;
            }
            else {
              if (cnt % 2 == 0) {
                table.append (begDefRowRB) ;
              }
              else {
                table.append (begDefRowR) ;
              }
            }
            table.append (begInnerTab) ;
            
            {
            	Object ox [] = {n.done () ? "1" : "0",
            	               td.wrap (misc.Helper.nameConvert (d.file ()))} ;
            	table.append (begFile.format (ox)) ;
            }
//
            table.append (begSpaceEnd) ;
//            
            {
            	String s = misc.Helper.nameConvert (d.label ().length () > labelCharsR ? d.label ().substring (0, labelCharsR) : d.label ()) ;
            	Object ox [] = {n.done () ? "1" : "0", td.wrap (s)} ;
            	table.append (begLabelR.format (ox)) ;
            }

            {
            	StringBuffer b = new StringBuffer () ;
              b.append (dateFormtMedium.format (d.due ())) ;
              Object o2 [] = {Integer.toString (d.id ())} ;
              Object o3 [] = {d.done () ? "1" : "0", j4.get (response, o2).wrap (b.toString ())} ;
              table.append (begDate.format (o3)) ;
            }
            
            
            table.append (begCheck) ;
            if (pmn && ! n.done ()) {
              Object o2 [] = {Integer.toString (n.id ())} ;
              table.append (pageLayout.iconHook (datePast ? "delatt" : "delete", j2.get (response, o2))) ;
            }
            else {
              table.append (pageLayout.iconHook ((datePast && ! n.done ()) ? "att" : (n.done () ? "att1" : "att0"))) ;
            }
            table.append (endBlock) ;
            table.append (endInnerTab) ;
            table.append (endRowR) ;
          }
          
// "Reichel spezial" Einschub beginnt ...

          else if (intern.hasNext ()) {
            Deadline d = (Deadline) intern.next () ;
            Object o2 [] = {Integer.toString (d.id ())} ;
            JumpTarget td = j1.get (response, o2) ;
            int i = hld ;
            if (d.id () == i) {
              table.append (begHilRowR) ;
            }
            else {
              if (cnt % 2 == 0) {
                table.append (begDefRowRB) ;
              }
              else {
                table.append (begDefRowR) ;
              }
            }
            table.append (begInnerTab) ;
            
            {
            	Object o [] = {d.done () ? "1" : "0",
            	               td.wrap (misc.Helper.nameConvert (d.file ()))} ;
            	table.append (begFile.format (o)) ;
            }
            
            table.append (begSpaceEnd) ;
            
            {
            	Object o [] = {d.done () ? "1" : "0",
            								 Integer.toString (d.colorID ()),
            								 misc.Helper.nameConvert (d.type ())} ;
            	table.append (begType.format (o)) ;
            }

            table.append (begSpaceEnd) ;
            
            {
 	            String s = misc.Helper.nameConvert (d.label ().length () > labelCharsL ? d.label ().substring (0, labelCharsL) : d.label ()) ; 
            	Object ox [] = {d.done () ? "1" : "0", td.wrap (s)} ;
            	table.append (begLabelL.format (ox)) ;
            }

            table.append (begCheck) ;
            if (pmn && ! d.done ()) {
              Object o [] = {Integer.toString (d.id ())} ;
              table.append (pageLayout.iconHook (datePast ? "delatt" : "delete", j2.get (response, o))) ;
            }
            else {
              table.append (pageLayout.iconHook ((datePast && ! d.done ()) ? "att" : (d.done () ? "att1" : "att0"))) ;
            }
            table.append (endBlock) ;
            //
            table.append (endInnerTab) ;
            table.append (endRowR) ;
          }
// "Reichel spezial" ... Einschub endet.
          else {
            table.append (cnt % 2 == 0 ? emptyRB : emptyR) ;
          }
        }
        table.append (endOuterTab) ;
      }

      table.append (pageTrailer) ;

      response.setContentType ("text/html") ;
      response.setDateHeader("expires",new java.util.Date ().getTime () + 1000) ;
      response.setDateHeader("updated",new java.util.Date ().getTime ()) ;
      
      PrintWriter out = response.getWriter () ;
      out.println (pageLayout.format (table.toString ())) ;
      out.close () ;
    }
    catch (Exception e) {
      response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage ()) ;
    }
  }
}
