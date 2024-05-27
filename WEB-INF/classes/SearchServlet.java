// (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Vector ;
import java.util.List ;
import java.util.Iterator ;
import java.util.Properties ;
import java.util.ResourceBundle ;

import java.text.Format ;
import java.text.ChoiceFormat ;
import java.text.MessageFormat ;
import java.text.NumberFormat ;

import html.ListPage ;
import html.text.DetailFormat ;

import misc.Jump ;
import misc.Detail ;
import misc.JumpTarget ;
import misc.ObjectWrapper ;
import misc.Result ;
import misc.Pair ;

import dynamic.meta.Meta ;

import data.DataSourceException ;
import data.DataSourceLayout ;
import data.DataSourceScheduleRead ;

final public class SearchServlet extends MyBasicHttpServlet {

  private final static String param_tok = "token" ;		//
  private final static String param_cut = "cut" ;			//

  private MessageFormat f1, f2, f3 ;
  private ResourceBundle r1 ;
  private Properties x1 ;
  private int len, max ;
  private String major ;
  private Meta m1 ;
  private Jump j1, j2 ;

  protected void reload () throws ServletException {
    try {
    	
      DataSourceLayout d = new DataSourceLayout (getInitParameter("config")) ;
      r1 = d.resourceBundle (major) ;
      x1 = d.properties (major) ;
      j1 = d.jump (36) ;
      j2 = d.jump (39) ;
      
      len = Integer.parseInt (x1.getProperty ("len")) ;
      max = Integer.parseInt (x1.getProperty ("max")) ; ;

      m1 = (Meta) Class.forName (x1.getProperty ("meta")).newInstance () ;
      
      double [] limits = {0,1,max} ;
      String [] labels = {r1.getString ("noHitLoc"),r1.getString ("hitLoc"),r1.getString ("truncLoc")} ;
 
      ChoiceFormat cf = new ChoiceFormat (limits,labels) ;
      NumberFormat nf = NumberFormat.getInstance () ;
      Format [] fmt = {cf, nf, nf, nf} ;
      f1 = new MessageFormat ("37,{0},{1}") ;
      f2 = new MessageFormat ("{0}") ;
      f2.setFormats (fmt) ;
      f3 = new MessageFormat (r1.getString ("srchLoc")) ;
    }
    catch (Exception e) {
      throw new UnavailableException (e.toString () + e.getMessage ()) ;
    }
  }

  public void init (ServletConfig cfg) throws ServletException {
    super.init (cfg) ;
    major = getServletName () ;
    reload () ;
  }

  public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    String tok = request.getParameter (param_tok) ;

    try {

      List list = new java.util.LinkedList () ;

      String cts = request.getParameter (param_cut) ;
      int cut = (cts == null) ? 0 : Integer.parseInt (cts) ;

      if (tok == null ? true : (tok.length () > 0 ? false : true)) {
      	response.sendError (HttpServletResponse.SC_BAD_REQUEST) ; 
      	return ;
      }
      else {
      	
        DataSourceScheduleRead db = new DataSourceScheduleRead (getInitParameter("schedule")) ;

        Result res = db.search (tok, m1.compress (tok), len, cut, max) ;
        Vector hit = res.hit () ;

// URL ausfüllen
        
        {
        	StringBuffer b = new StringBuffer () ;
        	for (int i = 0 ; i < hit.size () ; i ++) {
        		b.append (((Integer) hit.get (i)).toString ()) ;
        		if (i < hit.size () - 1) b.append (",") ;
        	}
        	
        	Object w [] = {new Integer (res.num ()),
        	               new Integer (res.beg () + 1),
        	               new Integer (res.end ()),
        	               new Integer (res.num ())} ;
        	Object x [] = {tok, Integer.toString (cut - 1)} ;
        	Object y [] = {tok, Integer.toString (cut + 1)} ;
          String z [] = {f3.format (x), f2.format (w)} ;
          
        	Object r [] = {
        								b.toString (),
        								(res.beg () > 0 ? f1.format (x) : ""),
        								(res.end () < res.num () ? f1.format (y) : ""),
        								new ObjectWrapper (z)
        	} ;
        	response.sendRedirect (j2.redirectURL (response, r)) ;
        }
      }
    }
    catch (Exception e) { 
      response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
    }
  }
}
