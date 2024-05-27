// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

import java.io.IOException ;
import java.io.PrintWriter ;
import javax.servlet.ServletConfig ;
import javax.servlet.ServletException ;
import javax.servlet.UnavailableException ;
import javax.servlet.http.HttpSession ;
import javax.servlet.http.HttpServletRequest ;
import javax.servlet.http.HttpServletResponse ;

import java.sql.Date ;

import java.util.Vector ;
import java.util.Calendar ;
import java.util.Iterator ;
import java.util.Properties ;
import java.util.ResourceBundle ;

import java.text.Format ;
import java.text.ChoiceFormat ;
import java.text.DateFormat ;
import java.text.MessageFormat ;
import java.text.NumberFormat ;
import java.text.DateFormat ;

import misc.Result ;
import misc.Pair ;
import misc.Ticket ;
import misc.Option ;
import misc.Jump ;
import misc.ObjectWrapper ;

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceScheduleRead ;

final public class WorkloadServlet extends MyBasicHttpServlet {

	private final static String form1 = "workload" ;		// Formularschlüssel
  private final static String param_cnl = "cancel" ;	//
  private final static String param__ok = "go" ;			// 
  private final static String param_asd = "asd" ;
  private final static String param_cut = "cut" ;
  private final static String param_all = "all" ;
  private final static String param_da1 = "1" ;				// Postfix Startdatum
  private final static String param_da2 = "2" ;				// Postfix Enddatum

  private MessageFormat f1, f2, f3 ;
  private String major ;
  private ResourceBundle r1 ;
  private Properties x1 ;
  private Jump j1, j2, j3, j4 ;
  private int len, max ;
  
  protected void reload () throws ServletException {
    try {
      DataSourceForm d = new DataSourceForm (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      x1 = d.properties (major) ;
      f1 = new MessageFormat ("50,{0},{1},{2},{3},{4},{5},{6},{7},{8},{9}") ;
      j1 = d.jump (26) ;	// Fehlerblatt
      j2 = d.jump (39) ;	// Liste
      j3 = d.jump (51) ;	// Zurück ins Menue
      j4 = d.jump (300) ;	// Anmeldefehler
      len = Integer.parseInt (x1.getProperty ("len")) ;
      max = 1000 ;
      
      double [] limits = {0,1,max} ;
      String [] labels = {r1.getString ("body.result.none"),r1.getString ("body.result.hits"),r1.getString ("body.result.trunc")} ;
      
      ChoiceFormat cf = new ChoiceFormat (limits,labels) ;
      NumberFormat nf = NumberFormat.getInstance () ;
      DateFormat df = DateFormat.getDateInstance (DateFormat.LONG) ;
      Format [] fm1 = {cf, df, df, nf, nf, nf} ;
      f2 = new MessageFormat ("{0}") ;
      f2.setFormats (fm1) ;
      f3 = new MessageFormat (r1.getString ("caption.result")) ;
    }
    catch (Exception e) {
      throw new UnavailableException (e.getMessage ()) ;
    }
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    major = getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    HttpSession session = request.getSession (false) ;
    Ticket u = (session == null) ? null : (Ticket) session.getAttribute ("Ticket") ;
    
    if (u == null ? true : ! u.permissions ().permLgn ()) {
    	response.sendRedirect (j4.redirectURL (response, new Object [0])) ;
    }
    else {

      boolean cnl = request.getParameter (param_cnl) != null || request.getParameter (param__ok) == null ;

      if (cnl) {
        response.sendRedirect (j3.redirectURL (response, new Object [0])) ;
      }
      else {
      	
        Date beg = null ;
        boolean begOK = true ;
        
        try {
          beg = parseDate (request, param_da1) ;
        } catch (Exception e) { begOK = false ; }
      
        Date end = null ;
        boolean endOK = true ;
        boolean ordOK = false ;
        try {
          end = parseDate (request, param_da2) ;
          if (begOK) ordOK = ! end.before (beg) ;
        } catch (Exception e) { endOK = false ; }
      
        int asd = Integer.parseInt (request.getParameter (param_asd)) ;
        int cut = Integer.parseInt (request.getParameter (param_cut)) ;

        boolean all = request.getParameter (param_all) == null ? false : (request.getParameter ("all").compareTo ("ON") == 0) ? true : false ;
        
        try {

          DataSourceScheduleRead d = new DataSourceScheduleRead (getInitParameter("schedule")) ;

          String assignee = null ;
          boolean asdOK = false ;
          for (Iterator i = d.loginNameList (false,false,true).iterator () ; i.hasNext () ; ) {
            Option o = (Option) i.next () ;
            if (o.key () == asd) {
          	  assignee = o.label () ;
          	  asdOK = true ;
            }
          }
        
          boolean allOK = begOK && endOK && ordOK && asdOK ;
        
          if (!allOK) {
        	  Object t [] = {new Boolean (begOK).toString (),
        	                 new Boolean (endOK).toString (),
        	                 new Boolean (asdOK).toString (),
        	                 new Boolean (ordOK).toString (),
        	                 "29",
        	                 ""} ;
        	  response.sendRedirect (j1.redirectURL (response,t)) ;
        	  return ;
          }

          Result res = d.workload (beg, end, asd, all, len, cut) ;
        
          {
        	  
        	  Vector hit = res.hit () ;
            StringBuffer b = new StringBuffer () ;
        	  for (int i = 0 ; i < hit.size () ; i ++) {
        		  b.append (((Integer) hit.get (i)).toString ()) ;
        		  if (i < hit.size () - 1) b.append (",") ;
        	  }
        	
          	Object v [] = {assignee} ;
        	
        	  Object w [] = {new Integer (res.num ()),
        	                 beg,
        	                 end,
        		               new Integer (res.beg () + 1),
        	                 new Integer (res.end ()),
        	                 new Integer (res.num ())} ;
        	               
        	  Calendar c1 = Calendar.getInstance (def) ;
            Calendar c2 = Calendar.getInstance (def) ;
            c1.setTime (beg) ;
            c2.setTime (end) ;
          
        	  Object x [] = {Integer.toString (c1.get (Calendar.DATE)),
        	                 Integer.toString (c1.get (Calendar.MONTH) + 1),
        	                 Integer.toString (c1.get (Calendar.YEAR)),
        	                 Integer.toString (c2.get (Calendar.DATE)),
        	                 Integer.toString (c2.get (Calendar.MONTH) + 1),
        	                 Integer.toString (c2.get (Calendar.YEAR)),
        	                 Integer.toString (asd),
        	                 all ? "ON" : "OFF",
        	                 Integer.toString (cut - 1)} ;
        	  Object y [] = {Integer.toString (c1.get (Calendar.DATE)),
        	                 Integer.toString (c1.get (Calendar.MONTH) + 1),
        	                 Integer.toString (c1.get (Calendar.YEAR)),
        	                 Integer.toString (c2.get (Calendar.DATE)),
        	                 Integer.toString (c2.get (Calendar.MONTH) + 1),
        	                 Integer.toString (c2.get (Calendar.YEAR)),
        	                 Integer.toString (asd),
        	                 all ? "ON" : "OFF",
        	                 Integer.toString (cut + 1)} ;
        	               
            String z [] = {f3.format (v), f2.format (w)} ;

            Object r [] = {
        		  b.toString (),
        		  (res.beg () > 0 ? f1.format (x) : ""),
        		  (res.end () < res.num () ? f1.format (y) : ""),
        		  new ObjectWrapper (z)
        	  } ;
        	  response.sendRedirect (j2.redirectURL (response, r)) ;
          }
        } 
        catch (Exception e) {
          response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
        }
      }
    }
  }
}
