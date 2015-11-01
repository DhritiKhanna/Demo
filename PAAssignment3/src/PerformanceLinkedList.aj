import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;

public aspect PerformanceLinkedList 
{
	long timeAfter;
	long timeBefore;
	long timeInOperation;
	static int counter=0;
	static File file;
	static FileWriter fileWriter;
	
	before():  
		call (* LinkedList.getLast())
		{
			if(counter == 0)
			{
				file = new File("./LinkedListPerformance.txt");
				try 
				{
					fileWriter = new FileWriter(file);
				}
				catch (IOException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
				
			timeBefore = System.nanoTime();
			counter++;
		}
	
	after() returning (Integer i):  
		call (* LinkedList.getLast())
		{
			if (counter == 1)
				try 
				{
					fileWriter.write("No. of elements(n)\t" + "Time taken\n\n");
				} 
				catch (IOException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			timeAfter = System.nanoTime();
			timeInOperation = timeAfter-timeBefore;
			try 
			{
				if( (counter&(counter-1)) == 0 )
				{
					fileWriter.write(counter + "\t\t" + timeInOperation + "\n");
				}
			} 
			catch (IOException e) 
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if (counter==Math.pow(2, 10))
			{
				try 
				{
					fileWriter.close();
				} 
				catch (IOException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
}
