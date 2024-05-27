// (c) Bernhard Schupp; Frankfurt-München; 2001-2003

package data ;

import java.sql.SQLException ;
import java.sql.PreparedStatement ;
import java.sql.ResultSet ;

import java.text.Format ;
import java.text.MessageFormat ;

import java.util.Map ;
import java.util.HashMap ;
import java.util.TreeMap ;
import java.util.SortedMap ;
import java.util.Iterator ;
import java.util.List ;
import java.util.LinkedList ;
import java.util.Locale ;
import java.util.Collections ;

import misc.Style ;
import misc.Color ;
import misc.JumpTarget ; 

import html.BasePage ;
import html.FormBasePage ;
import html.BodyPage ;
import html.ListPage ;
import html.FormBodyPage ;
import html.FormListPage ;
import html.FormListPageImpl ;
// import html.AutoFormPage ;

import html.form.Input ;
import html.form.AreaInput ;
import html.form.TextInput ;
import html.form.DateInput ;
import html.form.CheckboxInput ;
import html.form.DetailInput ;
import html.form.HiddenInput ;
import html.form.ImageInput ;
import html.form.SubmitInput ;
import html.form.SelectInput ;
import html.form.TextInputStandard ;
import html.form.TextInputPassword ;
import html.form.TextInputPseudo ;
import html.form.Form ;
import html.form.FormImpl ;
import html.form.InputFormRow ;

public class DataSourceForm extends DataSourceLayout {

  private Map inputCache = java.util.Collections.synchronizedMap (new HashMap ()) ;
  private Map inputHidden = java.util.Collections.synchronizedMap (new HashMap ()) ;
  private Map formRowCache = java.util.Collections.synchronizedMap (new HashMap ()) ;
  private Map formInputCache = java.util.Collections.synchronizedMap (new HashMap ()) ;
  
  public DataSourceForm (String s) throws DataSourceException {
    super (s) ;
    synchronized (con) {
      String q = "" ;
      try {	
// AreaInput 
        q = fetchStatement ("query_2093") ;
        PreparedStatement p = con.prepareStatement (q) ;
        ResultSet r = p.executeQuery () ;
        while (r.next ()) {              

          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;
          int i3 = r.getInt (3) ;
          String s1 = r.getString (4) ;
          Integer id = new Integer (r.getInt (5)) ;
          String s4 = r.getString (6) ;
          String s5 = s4 == null ? "" : s4 ;

          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          ((HashMap) inputCache.get (id)).put (s1, new AreaInput (style (i1), i2, i3, s1, s5)) ;
        }
        r.close () ;
        p.close () ;
 // CheckboxInput
        q = fetchStatement ("query_2097") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        while (r.next ()) {              
          
          String s1 = r.getString (1) ;
          String s2 = r.getString (2) ;
          Integer id = new Integer (r.getInt (3)) ;

          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          ((HashMap) inputCache.get (id)).put (s1, new CheckboxInput (s1, s2)) ;
        }
        r.close () ;
        p.close () ;
 // DateInput
        q = fetchStatement ("query_2096") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        while (r.next ()) {              
          
          int i1 = r.getInt (1) ;
          String s1 = r.getString (2) ;
          Integer id = new Integer (r.getInt (3)) ;

          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          ((HashMap) inputCache.get (id)).put (s1, new DateInput (style (i1), s1)) ;
        }
        r.close () ;
        p.close () ;        
// Header


// HiddenInput
        q = fetchStatement ("query_2098") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        while (r.next ()) {              
          
          String s1 = r.getString (1) ;
          String s2 = r.getString (2) ;
          Integer id = new Integer (r.getInt (3)) ;
          

          if (!inputHidden.containsKey (id)) {
            inputHidden.put (id, new HashMap ()) ;
          }

          ((HashMap) inputHidden.get (id)).put (s1, new HiddenInput (s1, s2)) ;
        }
        r.close () ;
        p.close () ;
// ImageInput
        q = fetchStatement ("query_2099") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        
        while (r.next ()) {              
          
          String s1 = r.getString (1) ;
          String s2 = r.getString (2) ;
          String s3 = r.getString (3) ;
          int i1 = r.getInt (4) ;
          Integer id = new Integer (r.getInt (5)) ;
          
          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          ((HashMap) inputCache.get (id)).put (s1, new ImageInput (new misc.Icon (image (i1), s3) , s1, s2)) ;
        }
        r.close () ;
        p.close () ;
// SelectInput
        q = fetchStatement ("query_2091") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        while (r.next ()) {

          int i1 = r.getInt (1) ;
          String s1 = r.getString (2) ;
          boolean b1 = r.getBoolean (3) ;
          Integer id = new Integer (r.getInt (4)) ;

          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          ((HashMap) inputCache.get (id)).put (s1, new SelectInput (style (i1), s1, b1)) ;
        }
        r.close () ;
        p.close () ;
 // SubmitInput 
        q = fetchStatement ("query_2095") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        while (r.next ()) {              
          
          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;
          String s1 = r.getString (3) ;
          Integer id = new Integer (r.getInt (4)) ;
          String s3 = r.getString (5) ;

          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          ((HashMap) inputCache.get (id)).put (s1, new SubmitInput (style (i1), i2, s1, s3)) ;
        }
        r.close () ;
        p.close () ;
// TextInput
        q = fetchStatement ("query_2094") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        while (r.next ()) {              

          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;
          int i3 = r.getInt (3) ;
          int i4 = r.getInt (4) ;
          
          String s1 = r.getString (5) ;
          Integer id = new Integer (r.getInt (6)) ;
          String s2 = r.getString (7) ;

          if (s2 == null) s2 = "" ;

          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          switch (i4) {
            case 1 :
              ((HashMap) inputCache.get (id)).put (s1, new TextInputStandard (style (i1), i2, i3, s1, s2)) ;
              break ;
            case 2 :
              ((HashMap) inputCache.get (id)).put (s1, new TextInputPassword (style (i1), i2, i3, s1)) ;
              break ;
            case 3 :
              ((HashMap) inputCache.get (id)).put (s1, new TextInputPseudo (style (i1), i2, i3, s1, s2, true)) ;
              break ;
            case 4 :
              ((HashMap) inputCache.get (id)).put (s1, new TextInputPseudo (style (i1), i2, i3, s1, s2, false)) ;
              break ;
            default :
              break ;
          }
        }
        r.close () ;
        p.close () ;
// DetailInput
        q = fetchStatement ("query_2100") ;
        p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        
        while (r.next ()) {              

          String s1 = r.getString (1) ;		// Name
          String s2 = r.getString (2) ;		// Style
          int i1 = r.getInt (3) ;					// InputForm

          
          Integer id = new Integer (i1) ;
          
          if (!inputCache.containsKey (id)) {
            inputCache.put (id, new HashMap ()) ;
          }

          ((HashMap) inputCache.get (id)).put (s1, new DetailInput (s1, s2)) ;
          
        }
        r.close () ;
        p.close () ;
// row pos input
        q = fetchStatement ("query_2092") ; 
       	p = con.prepareStatement (q) ;
        r = p.executeQuery () ;
        SortedMap m = new TreeMap () ;
        
        while (r.next ()) {              

          Integer i1 = new Integer (r.getInt (1)) ;
          Integer i2 = new Integer (r.getInt (2)) ;
          r.getString (3) ;
          String s1 = r.getString (4) ;

          if (!m.containsKey (i1)) {
            m.put (i1, new TreeMap ()) ;
          }
          
          if (!((SortedMap) m.get (i1)).containsKey (i2)) {
            ((SortedMap) m.get (i1)).put (i2, new LinkedList ()) ;
          }
          
          ((List) ((SortedMap) m.get (i1)).get (i2)).add (s1) ;
          
        }
        r.close () ;
        p.close () ;
        
        for (Iterator i = m.entrySet ().iterator () ; i.hasNext () ; ) {
          Map.Entry e = (Map.Entry) i.next () ;
          SortedMap x = (SortedMap) e.getValue () ;
          List t = new LinkedList () ;
          for (Iterator j = x.entrySet ().iterator () ; j.hasNext () ; ) {
          	List y = (List)((Map.Entry) j.next ()).getValue () ;
          	t.add (y) ;
          }
          formRowCache.put (e.getKey (), t) ;
        }
      }
      catch (SQLException e) {
        Object [] o = {q, e.getMessage ()} ;
        throw new DataSourceException (f3.format (o)) ;
      }
    }
  }

  final public Form form (int key) throws DataSourceException {
    String q = fetchStatement ("query_6010") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setInt (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {
          String s4 = r.getString (1) ;
          String s5 = r.getString (2) ;
          String s6 = r.getString (3) ;
          StringBuffer b1 = new StringBuffer () ;
          b1.append (r.getString (4)) ;
          b1.append (r.getString (5)) ;
          String s1 = b1.toString () ;
          String s2 = r.getString (6) ;
          String s3 = r.getString (7) ;

          r.close () ;
          p.close () ;
          
          Integer id = new Integer (key) ;
          JumpTarget t1 = new JumpTarget (s4 + s5, s6) ;
          Map m1 = Collections.unmodifiableMap (inputCache.containsKey (id) ? (Map) inputCache.get (id) : new HashMap ()) ;
          Map m2 = Collections.unmodifiableMap (inputHidden.containsKey (id) ? (Map) inputHidden.get (id) : new HashMap ()) ;
          
          return new FormImpl (key, s3, t1, s1, m1, m2, s2) ;
        }
        else {
          Object [] o = {q, Integer.toString (key)} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }

  final public FormBasePage formBasePage (Locale loc, String key) throws DataSourceException {
    String q = fetchStatement ("query_6020") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {

          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;

          r.close () ;
          p.close () ;

          Form p1 = form (i1) ;

          BasePage p2 = basePage (loc, i2) ;

          return new FormBasePage (p2, p1) ;
        }
        else {
          Object [] o = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }


  final public FormBodyPage formBodyPage (Locale loc, String key) throws DataSourceException {
    String q = fetchStatement ("query_6030") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {

          int i1 = r.getInt (1) ;
          int i2 = r.getInt (2) ;

          r.close () ;
          p.close () ;

          Form p1 = form (i1) ;

          BodyPage p2 = bodyPage (loc, i2) ;

          return new FormBodyPage (p2, p1) ;
        }
        else {
          Object [] o = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {e.getClass ().getName (), e.getMessage ()} ;
      throw new DataSourceException (f2.format (o)) ;
    }
  }

  final public FormListPage formListPage (Locale loc, String key) throws DataSourceException {
   	String q = fetchStatement ("query_6060") ;
    try {
      synchronized (con) {
        PreparedStatement p = con.prepareStatement (q) ;
        p.setString (1,key) ;
        ResultSet r = p.executeQuery () ;
        if (r.next ()) {

          Integer i1 = new Integer (r.getInt (1)) ;
          int i2 = r.getInt (2) ;

          r.close () ;
          p.close () ;

          if (!formRowCache.containsKey (i1)) {
            Object [] o = {new String ("Row-List"), i1.toString ()} ;
            throw new DataSourceException (f4.format (o)) ;
          }
          
          List l1 = (List) formRowCache.get (i1) ;
          Form f1 = form (i1.intValue ()) ;
          ListPage p1 = listPage (loc, i2) ;
          
          return new FormListPageImpl (p1, f1, l1) ;
        }
        else {
          Object [] o = {q, key} ;
          throw new DataSourceException (f1.format (o)) ;
        }
      }
    }
    catch (SQLException e) {
      Object [] o = {q, e.getMessage ()} ;
      throw new DataSourceException (f3.format (o)) ;
    }
  }
}