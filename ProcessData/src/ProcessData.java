import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;

public class ProcessData {
	private static String MD5(String str) {
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}

		char[] charArray = str.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++) {
			byteArray[i] = (byte) charArray[i];
		}
		byte[] md5Bytes = md5.digest(byteArray);

		StringBuffer hexValue = new StringBuffer();
		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16) {
				hexValue.append("0");
			}
			hexValue.append(Integer.toHexString(val));
		}
		return hexValue.toString();
	}
	public void turnToTrajectory(String fileName, String fileOutput) {
		File file = new File(fileName);
		File output = new File(fileOutput);
		Scanner scanner = null;
		HashMap<String, ArrayList<String>> data = new HashMap<String, ArrayList<String>>();
			try {
				scanner = new Scanner(file);
				String thisLine = scanner.nextLine();
				while (scanner.hasNextLine()) {
					thisLine = scanner.nextLine();
					String [] array = thisLine.split(",");
					String id = array[1];
					String x = array[3];
					String y = array[4];
					if (data.containsKey(id)) {
						ArrayList<String> value = data.get(id);
						value.add(x);
						value.add(y);
					}
					else {
						ArrayList<String> value = new ArrayList<String>();
						value.add(x);
						value.add(y);
						data.put(id, value);
					}
				}
				if(!output.exists())
		             output.createNewFile();
		         FileOutputStream out=new FileOutputStream(output,true);        
		         Iterator iter = data.entrySet().iterator();
		         while (iter.hasNext()) {//遍历每一个id
		        	Map.Entry entry = (Map.Entry) iter.next();
		        	String id = (String) entry.getKey();
		        	ArrayList<String> val = (ArrayList<String>) entry.getValue();
		        	StringBuffer sb = new StringBuffer();
					sb.append(id+",");
					Iterator it = val.iterator();
					while(it.hasNext()){//遍历id里的每一个x,y
						String xy = (String)it.next();
						sb.append(xy);
						if (it.hasNext()) {
							sb.append(',');
						}
					}
					sb.append('\n');
					byte[] o = sb.toString().getBytes();
					out.write(o);
//					System.out.println(o);
				}
		         out.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (IOException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			finally {
				if (scanner != null) {
	                scanner.close();
	            }
			}
		
	}
	public static void turnToGroup(String fileName, String fileOutput) {
		File file = new File(fileName);
		File output = new File(fileOutput);
		Scanner scanner = null;
		HashMap<String, String> itrack = new HashMap<String,String>();//<id,track>
		HashMap<String, String> iGid = new HashMap<String,String>();//<id,gId>
		HashMap<String, Integer> iGsize = new HashMap<String,Integer>();//<gid,gSize>
		try {
			scanner = new Scanner(file);
			while (scanner.hasNextLine()) {
				String thisLine = scanner.nextLine();
				int index = thisLine.indexOf(',')+1;
				String id = thisLine.substring(0, index-1);
				String track = thisLine.substring(index);
				itrack.put(id, track);//put track
				//put Gid
				Iterator iter = itrack.entrySet().iterator();
				while (iter.hasNext()) {
					Map.Entry entry = (Map.Entry) iter.next();
		        	String gTrack = (String)entry.getValue();
		        	String gid = (String)entry.getKey();
		        	if (gTrack.equals(track)&&!id.equals(gid)) {//same group
						iGid.put(id, gid);
						Integer isize = iGsize.get(gid);
						isize++;
		        	}
				}
				if (!iGid.containsKey(id)) {//no same group, create a new one
					iGid.put(id, id);
					Integer isize = 1;
					iGsize.put(id, isize);
				}
			}
			if(!output.exists())
	             output.createNewFile();
	         FileOutputStream out=new FileOutputStream(output,true);        
	         Iterator iter = itrack.entrySet().iterator();
	         while (iter.hasNext()) {//遍历每一个id
	        	Map.Entry entry = (Map.Entry) iter.next();
	        	String id = (String) entry.getKey();
	        	String track = (String)entry.getValue();
	        	String gid = iGid.get(id);
	        	Integer gsize = iGsize.get(gid);
	        	StringBuffer sb = new StringBuffer();
				sb.append(id+","+gid+","+gsize.toString()+","+track);
				sb.append('\n');
				byte[] o = sb.toString().getBytes();
				out.write(o);
//				System.out.println(o);
			}
	         out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally {
			if (scanner != null) {
                scanner.close();
            }
		}
	}
	public static void main(String[] argvs){
		turnToGroup("/Users/jiwentadashi/Downloads/trajectory.txt", "/Users/jiwentadashi/Downloads/groupInfo.txt");
	}	
}
