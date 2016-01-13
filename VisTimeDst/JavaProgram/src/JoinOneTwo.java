import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class JoinOneTwo
{
	static final String[] strFile = {
			"park-movement-Fri.csv", "comm-data-Fri.csv", "Fri.csv",
			"park-movement-Sat.csv", "comm-data-Sat.csv", "Sat.csv",
			"park-movement-Sun.csv", "comm-data-Sun.csv", "Sun.csv"
	};

	public static void main(String[] args)
	{
		for (int i=0; i<3; i++)
		{
			File fIn1 = new File(strFile[i*3]);
			File fIn2 = new File(strFile[i*3+1]);
			File fOut = new File(strFile[i*3+2]);
			List list = new ArrayList<String[]>();
			HashSet set = new HashSet<String>();
			String str = null;
			String[] pieces;
			try
			{
				java.util.Scanner in1 = new java.util.Scanner(fIn1);
				java.util.Scanner in2 = new java.util.Scanner(fIn2);
				java.io.PrintWriter out = new java.io.PrintWriter(fOut);
				in1.nextLine();
				while (in1.hasNext())
				{
					str = in1.nextLine();
					pieces = str.split(",");
					
					if (pieces.length>1)
						set.add(pieces[1]);
					
//					list.add(pieces);
				}
				System.out.println(str);
				System.out.println(""+set.size());
				
				int start = 0;
				in2.nextLine();
				out.println("Timestamp	from	to	location	X1	Y1	X2	Y2");
				while (in2.hasNextLine())
				{
					str = in2.nextLine();
					pieces = str.split(",");
//					for (int j=start; j<list.size(); j++)
//					{
//						(list.get(j))[0];
//					}
					
				}
				System.out.println(str);
//				out.println(x);
			}
			catch
			(FileNotFoundException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("End");
	}

}
