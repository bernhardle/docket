//	(c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004

package html ;

import java.util.Map ;
import java.util.SortedMap ;
import java.util.List ;
import java.util.LinkedList ;
import java.util.Iterator ;
import java.util.Collections ;

import misc.Pair ;
import misc.Detail ;

import html.form.Form ;
import html.form.Input ;
import html.form.InputFormRow ;

import html.list.Row ;
import html.text.DetailFormat ;

public class FormListPageImpl implements FormListPage {

  final static String sc1 = "<table>\n" ;
  final static String sc2 = "<tr>\n" ;
  final static String sc3 = "<td>\n" ;
  final static String sc4 = "</td>\n" ;
  final static String sc5 = "</tr>\n" ;
  final static String sc6 = "</table>\n" ;

  final static Map ms1 = Collections.unmodifiableMap (new java.util.HashMap ()) ;

  final class InputListRowImpl implements Row {
  	
    private List l2 ;

    InputListRowImpl (List l, Map m) {
      l2 = l ;
    }
 
    public String format () {
    	Iterator i = l2.iterator () ;
    	if (i.hasNext ()) {
    	  Input l = (Input) i.next () ;
    	  StringBuffer b = new StringBuffer () ;
    	  b.append (sc1) ;
    	  b.append (sc2) ;
    	  for ( ; i.hasNext () ; ) {
    	  	b.append (sc3) ;
    	  	Input f = (Input) i.next () ;
    	  	if (m1.containsKey (f.name ())) {
    	  	  b.append (f.format (m1.get (f.name ()))) ;
    	    }
    	    else {
    	      b.append (f.format ()) ;
    	    }
    	  	b.append (sc4) ;
    	  }
    	  b.append (sc5) ;
    	  b.append (sc6) ;
    	  return b1.textTextRow (l.format (), b.toString ()).format () ;
    	}
      return b1.textTextRow ("ERROR","").format () ;
    }
  }

  private ListPage b1 ;
  private Form f1 ;
  private Map m1 = new java.util.HashMap () ;
  private List l1 = new java.util.LinkedList () ;
  
  public FormListPageImpl (ListPage a, Form x, List l) {
  	b1 = a ;
    f1 = x ;
    
    for (Iterator i = l.iterator () ; i.hasNext () ; ) {
    	List li = new LinkedList () ;
    	for (Iterator j = ((List) i.next ()).iterator () ; j.hasNext () ; li.add (f1.input ((String) j.next ()))) ;
      l1.add (new InputListRowImpl (Collections.unmodifiableList (li), m1)) ;
    }
  }
 
  public String format (String a) {
  	// a: Überschrift
  	return b1.format (f1, l1, a) ;
  }

  public String format (String a, Map m) {
  	// a: Überschrift
  	// m: Argumente für die Inputs
  	m1.putAll (m) ;
  	String s = b1.format (f1, l1, a, m) ;
  	m1.clear () ;
    return s ;
  }
}