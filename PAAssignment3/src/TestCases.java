import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.util.Scanner;
import java.util.Stack;
import java.util.TreeSet;

class EmptyNotCalledBeforePop extends RuntimeException
{
	private static final long serialVersionUID = 1L;
	private static String msg;
	public EmptyNotCalledBeforePop()
	{
		super(msg);
	}
}

class ReaderHasBeenClosed extends RuntimeException
{
	private static final long serialVersionUID = 1L;
	private static String msg;
	public ReaderHasBeenClosed()
	{
		super(msg);
	}
}

public class TestCases 
{
	public static void main(String[] args) throws IOException 
	{
		System.out.println("Enter your choice: ");
		System.out.println("1. Run test case 1 for property \'FailSafePop\'");
		System.out.println("2. Run test case 2 for property \'FailSafePop\'");
		System.out.println("3. Run test case 1 for property \'ReaderClose\'");
		System.out.println("4. Run test case 2 for property \'ReaderClose\'");
		System.out.println("5. Run test case to validate the performance measure of insertion() in TreeSet");
		System.out.println("6. Run test case to validate the performance measure of get() in LinkedList");
		Scanner in = new Scanner(System.in);
		int choice = in.nextInt();
		
		switch (choice)
		{
			case 1:
				
				// Test case 1 for property 'FailSafePop' 
				Stack<Integer> s1 = new Stack<Integer>();
				s1.push(1);
				s1.push(2);
				if(!s1.empty())
					System.out.println(s1.pop());
				System.out.println(s1.pop());
				break;
			
			case 2:
			
				// Test case 2 for property 'FailSafePop'
				Stack<Integer> s2 = new Stack<Integer>();
				s2.push(1);
				if(!s2.empty())
					s2.pop();
				s2.pop();
				break;
			
			case 3:
			
				// Test case 1 for property 'ReaderClose'
				InputStreamReader st1 = new InputStreamReader(System.in);
				System.out.println((char)st1.read());
				st1.close();
				System.out.println((char)st1.read());
				break;
			
			case 4:
				
				// Test case 2 for property 'ReaderClose'
				InputStreamReader st2 = new InputStreamReader(System.in);
				System.out.println((char)st2.read());
				st2.close();
				System.out.println((char)st2.read());
				System.out.println((char)st2.read());
				break;
				
			case 5:
			
				// Test case for performance of operation 1: Insertion in TreeSet takes log(n) time
				TreeSet<Integer> t = new  TreeSet<Integer>();
				int i=0; int j=100000;
				while(i<100000 && j>=0)
				{
					t.add(i);
					t.add(j);
					i++;
					j--;
				}
				break;
			
			case 6:
				
				// Test case for performance of operation 2: Get operation on LinkedList runs in linear time
				LinkedList<Integer> l = new LinkedList<Integer>();
				int k=0;
				while(k<Math.pow(2, 10))
				{
					l.add(k);
					l.getLast();
					k++;
				}
				break;
		}
		in.close();
	}
}
