package test;

public class array {

	public static void main(String[] args)
	{
		boolean[][] b = new boolean[100000][100000];
		b[9999][9999] = false;
		if (!b[9999][9999]) System.out.println("OK");
	}
}
