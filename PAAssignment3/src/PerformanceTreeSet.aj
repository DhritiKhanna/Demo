import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.TreeSet;


public aspect PerformanceTreeSet 
{
	long timeAfter;
	long timeBefore;
	long timeInOperation;
	static int counter=0;
	static File file;
	static FileWriter fileWriter;
	
	before():  
		call (boolean TreeSet.add(..))
		{
			if(counter == 0)
			{
				file = new File("./TreeSetPerformance.txt");
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
	
	after() returning (boolean b):  
		call (boolean TreeSet.add(..))
		{
			if (counter == 1)
				try 
				{
					fileWriter.write("No. of elements(n)\t" + "Time taken\t" + "log(n)\n");
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
					fileWriter.write(counter + "\t\t" + timeInOperation + "\t\t" + Math.log(counter) + "\n");
			} 
			catch (IOException e) 
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(counter==200000)
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
