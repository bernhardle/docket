// (c) Bernhard Schupp; Frankfurt-M�nchen; 2001-2003

package dynamic.listfetch ;

import java.util.Iterator ;

import data.DataSourceException ;
import data.DataSourceScheduleRead ;

public class UserListFetch implements ListFetch {
	public Iterator fetch (DataSourceScheduleRead d) throws DataSourceException {
	  return d.loginNameList (false,true,true).iterator () ;
	}
}