import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

public aspect ReaderClose 
{
	Map<InputStreamReader, Boolean> m = new HashMap<InputStreamReader, Boolean>();
	
	after() returning (InputStreamReader r):
	call(new(..))
	{
		m.put(r, false);
	}
		
	after(InputStreamReader r) returning:
		call (void InputStreamReader.close()) && target(r)
		{
			m.put(r, true);
		}
	
	before(InputStreamReader r) :  
		call (* InputStreamReader.read()) && target(r)
		{
			if(m.get(r) == true) // Reader has been closed
				throw new ReaderHasBeenClosed();
		}
}
