// (c) Bernhard Schupp

package misc ;

import java.io.* ;
import java.util.zip.* ;

public class ObjectWrapper implements Serializable {
	
	private Object o ;
	
	public ObjectWrapper (Object a) {
	  o = a ;	
	}

  public Object getObject () {
    return o ;	
  }

  public String toString () {
  	ByteArrayOutputStream ostream = new ByteArrayOutputStream ();
  	try {
/**/    ZipOutputStream zip = new ZipOutputStream (ostream) ;
/**/    zip.putNextEntry (new ZipEntry ("1")) ;
/**/    zip.setLevel (9) ;
/**/	  ObjectOutputStream p = new ObjectOutputStream(zip);
//*	    ObjectOutputStream p = new ObjectOutputStream(ostream);
	    p.writeObject (o);
	    p.flush();
/**/	  zip.finish () ;
/**/	  zip.close () ;
//*      ostream.close () ;
	  }
	  catch (IOException e) { }
	  finally {
	  	
	    byte x [] = ostream.toByteArray () ;
	    StringBuffer b = new StringBuffer () ;
	    for (int i = 0 ; i < x.length ; i++ ) {
	    	String s = Integer.toHexString (128 + x[i]) ;
        if (s.length () == 1) b.append ("0") ;
	    	b.append (s) ;
	    }
	    return b.toString () ;	  	
	  }
	}
	
	public static ObjectWrapper fromString (String s) throws IOException, ClassNotFoundException {
		int len = s.length () / 2 ;
		byte b [] = new byte [len] ;
		for (int i = 0 ; i < len ; i ++ ) {
		  String t = s.substring (2 * i, 2 * i + 2) ;
		  b [i] = (byte) (Integer.parseInt (t, 16) - 128) ;
		}
		
		ByteArrayInputStream istream = new ByteArrayInputStream (b);

/**/    ZipInputStream zip = new ZipInputStream (istream) ;
/**/    zip.getNextEntry () ;
/**/ 	  ObjectInputStream p = new ObjectInputStream(zip);

//*	  ObjectInputStream p = new ObjectInputStream (istream);

    ObjectWrapper w = new ObjectWrapper (p.readObject ()) ;
    p.close () ;
    zip.close () ;
	  istream.close () ;    
  	return w ;
	}
}