import java.util.Collection;
import java.util.ConcurrentModificationException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


public aspect HasNext 
{
	Map<Iterator<Integer>, Boolean> m = new HashMap<Iterator<Integer>, Boolean>();
	
	after() returning (Iterator i):
		call(* Collection.iterator()) 
		{
			System.out.println("Created iterator");
			m.put(i, false);
		}
	
	after(Iterator i) returning (boolean b):  
		call (boolean Iterator.hasNext()) && target(i)
		{
			System.out.println("Done hasnext");
			m.put(i, true);
		}
	
	before(Iterator i):  
		call (* Iterator.next()) && target(i)
		{
			if(m.get(i) == false)
				throw new ConcurrentModificationException();
			System.out.println("Done next");
			m.put(i, false);
		}
}