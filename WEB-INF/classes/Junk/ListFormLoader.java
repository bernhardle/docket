// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package misc ;

import html.FormListPage ;

import data.DataSourceException ;
import data.DataSourceForm ;
import data.DataSourceScheduleRead ;

public abstract class ListFormLoader {

  private ListFormLoader () {}

  protected ListFormLoader (DataSourceScheduleRead a, DataSourceForm b, Ticket c) {}

  public abstract String format (FormListPage p) ;	
	
}

