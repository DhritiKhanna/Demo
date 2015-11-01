import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

public aspect FailSafePop 
{
	Map<Stack<Integer>, Boolean> m = new HashMap<Stack<Integer>, Boolean>();
	boolean val;
	
	after() returning (Stack s): 								//Constructor
		call(new(..))
		{
			m.put(s, false);
		}
	
	after(Stack s) returning (boolean b): 						//After empty
		call (boolean Stack.empty()) && target(s)
		{
			m.put(s, true);
		}
	
	before(Stack s):
		call (* Stack.push(..)) && target(s)					//Before push
		{
			val = m.remove(s);
		}
	
	after(Stack s) returning:									//After push
		call (* Stack.push(..)) && target(s) 
		{
			m.put(s, val);
		}
	
	before(Stack s):  											//Before pop
		call (* Stack.pop()) && target(s)
		{
			if(m.get(s) == false)
				throw new EmptyNotCalledBeforePop();
			m.remove(s);
		}
	
	after(Stack s) returning:  									//After pop
		call (* Stack.pop()) && target(s)
		{
			m.put(s, false);
		}
}