// (c) Bernhard Schupp; 2001-2004; Frankfurt-München-Frankfurt


package html.text ;

import misc.JumpTarget ;

public interface IconHook {
	
	public abstract String format () ;
	
	public abstract String format (JumpTarget j) ;
	
}