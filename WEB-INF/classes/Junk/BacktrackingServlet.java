// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import misc.Pair ;
import misc.Jump ;
import misc.JumpTarget ;
import misc.ObjectWrapper ;

import data.DataSourceException ;
import data.DataSourceConfiguration ;

public final class BacktrackingServlet extends MyBasicHttpServlet {

  private String major ;
  
  protected void reload () throws ServletException {
    try {
      DataSourceConfiguration d = new DataSourceConfiguration (getInitParameter("config")) ;
      
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

  	try {
  	  String s = request.getParameter ("args") ;
  	  if (s != null) {
  	  	
  	  	Pair p = (Pair) ObjectWrapper.fromString (s).getObject () ;
  		  DataSourceConfiguration d = new DataSourceConfiguration (getInitParameter("config")) ;
  		  Jump j = d.jump (((Integer) p.first ()).intValue ()) ;
  		  Object r [] = (Object []) p.second () ;
  		  
   		  response.sendRedirect (j.redirectURL (response, r)) ;
  		}
  		else {
  			response.sendError (HttpServletResponse.SC_BAD_REQUEST) ;
  		}
  	}
  	catch (Exception e) {
  	  response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR) ;
  	}
  }
}