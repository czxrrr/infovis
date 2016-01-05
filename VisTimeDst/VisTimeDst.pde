final int num = 17538;
String[] lines;
String[] pieces;
int tmp;
int maxTime = 0, maxDst = 0;
String maxTimeId, maxDstId;
float x, y;
String[][] str = new String[num][3];
int edge = 20;

void setup()
{
  lines = loadStrings("TimeDst.txt");
  
  for (int i=1; i<lines.length; i++)
  {
    pieces = split(lines[i], ',');
    if (pieces.length<=1) println(lines[i]);
    str[i] = pieces;
    tmp = Integer.parseInt(pieces[1]);
    if (tmp > maxTime) 
    {
      maxTime = tmp;
      maxTimeId = pieces[0];
    }
    tmp = Integer.parseInt(pieces[2]);
    if (tmp > maxDst)
    {
      maxDst = tmp;
      maxDstId = pieces[0];
    }
    if (tmp>5000) println(pieces[0]);
  }
  println("maxDstID = " + maxDstId);
  
  size(500, 500);
  smooth();  
}

void draw()
{
  background(200);
  textSize(10);
  int yID = 10;
  int d = 10;
  for (int i=1; i<num; i++)
  {
    pieces = str[i];
    x = map(Integer.parseInt(pieces[1]), 0, maxTime, edge, width-edge);
    y = height - map(Integer.parseInt(pieces[2]), 0, maxDst, edge, height-edge);
    //point(x, y);
    ellipse(x, y, d, d);
    if (overCircle(x, y, d))
    {
      fill(0);
      text(pieces[0], 0, yID);
      fill(255);
      yID += 10;
    }
  }
}

boolean overCircle(float x, float y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}