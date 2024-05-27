// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package dynamic.listfetch ;

import java.util.Iterator ;

import data.DataSourceException ;
import data.DataSourceScheduleRead ;

public class DTypeListFetch implements ListFetch {
	public Iterator fetch (DataSourceScheduleRead d) throws DataSourceException {
	  return d.typeList (false).iterator () ;
	}
}