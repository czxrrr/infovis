package test;

import java.util.HashSet;

public class set
{

	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
		HashSet set = new HashSet<String>();
		set.add(new String("1"));
		set.add(new String("2"));
		set.add(new String("2"));
		set.add(new String("2"));
		System.out.println(set.size());
	}

}
