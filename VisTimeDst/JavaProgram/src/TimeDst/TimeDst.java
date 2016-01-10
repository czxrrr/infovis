package TimeDst;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class TimeDst
{

	static final String[] strFile = {
			"park-movement-Fri.csv", "comm-data-Fri.csv", "FriTimeDst.txt",
			"park-movement-Sat.csv", "comm-data-Sat.csv", "SatTimeDst.txt",
			"park-movement-Sun.csv", "comm-data-Sun.csv", "SunTimeDst.txt"
	};

	public static void main(String[] args) throws FileNotFoundException
	{
		File fOut = new File("TimeDst.txt");
		java.io.PrintWriter out = new java.io.PrintWriter(fOut);
		out.println("ID,Time,Distance");
		for (int i=0; i<3; i++)
		{
			File fIn1 = new File(strFile[i*3]);
			File fIn2 = new File(strFile[i*3+1]);
//			File fOut = new File(strFile[i*3+2]);
//			List list = new ArrayList<String[]>();
//			HashSet set = new HashSet<String>();
			Map<String, Person> map= new HashMap<String, Person>();
			String str = null;
			String[] pieces;
			Person psn;
			java.util.Scanner in1 = new java.util.Scanner(fIn1);
			java.util.Scanner in2 = new java.util.Scanner(fIn2);
//				java.io.PrintWriter out = new java.io.PrintWriter(fOut);
			while (in1.hasNext())
			{
				str = in1.nextLine();
				pieces = str.split(",");
				if (pieces.length<=1){ System.out.println(str); continue; }
				if (pieces[0].equals("Timestamp")) continue;
				if (map.containsKey(pieces[1]))
				{
					psn = map.get(pieces[1]);
					psn.ltTime = pieces[0];
					psn.dst += Math.sqrt( 
							Math.pow(Math.abs(psn.x-Integer.parseInt(pieces[3])), 2)+
							Math.pow(Math.abs(psn.y-Integer.parseInt(pieces[4])), 2)
							); 
					psn.x = Integer.parseInt(pieces[3]);
					psn.y = Integer.parseInt(pieces[4]);
				}
				else
				{
					psn = new Person();
					psn.ciTime = pieces[0];
					psn.dst = 0;
					psn.x = Integer.parseInt(pieces[3]);
					psn.y = Integer.parseInt(pieces[4]);
					map.put(pieces[1], psn);
				}

//					pieces[0]: Time
//					pieces[1]: ID
//					pieces[2]: type(check-in, movement)
//					pieces[3]: X(0-99)
//					pieces[4]: Y(0-99)
				
			}
//				out.println("ID,Time,Distance");
			int time;
			for (Map.Entry<String, Person> entry : map.entrySet())
			{
				psn = entry.getValue();
//					System.out.println(psn.ltTime);
				pieces = psn.ltTime.split(" ");
				pieces = pieces[1].split(":");
				time = Integer.parseInt(pieces[0])*24*60+
						Integer.parseInt(pieces[1])*60+
						Integer.parseInt(pieces[2]);
				pieces = psn.ciTime.split(" ");
				pieces = pieces[1].split(":");
				time -= Integer.parseInt(pieces[0])*24*60+
						Integer.parseInt(pieces[1])*60+
						Integer.parseInt(pieces[2]);
				out.println(entry.getKey() + "," + time + "," + psn.dst + "," + (i+1));  
//				    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
			  
			}
			in1.close();
			in2.close();
			out.flush();
		}
		out.close();
		System.out.println("End");
	}
}

