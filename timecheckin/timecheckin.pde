int num;
String[] lines;
String[] pieces;
int tmp;
int maxTime = 0, maxDst = 0;
String maxTimeId, maxDstId;
float x, y;
String[][] str;
int edge = 20;
int[][] colors = new int[][]{
  {255,0,0}, 
  {0,255,0},
  {0,0,255},
  {255,255,0},
  {255,0,255},
  {0,255,255}
};
int txt = 0;
int ID = -1;
int drawWhat = 0;

void setup()
{
  mysetup();
  size(500, 500);
}

void mysetup()
{
  if (drawWhat==0)
  {
    if (txt==0)
      lines = loadStrings("time_checkin1.txt");
    if (txt==1)
      lines = loadStrings("time_checkin2.txt");
    if (txt==2)
      lines = loadStrings("time_checkin3.txt");
    num = lines.length;
    str = new String[num][4];
    for (int i=1; i<lines.length; i++)
    {
      pieces = split(lines[i], '\t');
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
    //println("maxDstID = " + maxDstId);
    
    smooth();
  }
  if (drawWhat == 1)
  {
    setupSin();
  }
}

void draw()
{
  if (drawWhat==0)
  {
    background(200);
    stroke(0);
    textSize(10);
    ID = -1;
    int yID = 10;
    int d = 10;
    for (int i=1; i<num; i++)
    {
      pieces = str[i];
      y = height - map(Integer.parseInt(pieces[1]), 0, maxTime, edge, width-edge);
      x = map(Integer.parseInt(pieces[2]), 0, maxDst, edge, height-edge);
      //point(x, y);
      fill(colors[Integer.parseInt(pieces[3])][0],
      colors[Integer.parseInt(pieces[3])][1],
      colors[Integer.parseInt(pieces[3])][2]);
      ellipse(x, y, d, d);
      if (overCircle(x, y, d))
      {
        fill(0);
        text(pieces[0]+" "+pieces[1]+" "+pieces[3], 0, yID);
        fill(255);
        yID += 10;
        if (ID == -1)
          ID = Integer.parseInt(pieces[0]);
      }
    }
  }
  if (drawWhat==1)
  {
    drawSin();
  }
}

void keyPressed()
{
  if (key=='q') drawWhat = 0;
  if (key=='z') txt = 0;
  if (key=='x') txt = 1;
  if (key=='c') txt = 2;
  mysetup();
}

void mousePressed()
{
  println(ID);
  if (ID != -1)
  {
    drawWhat = 1;
    mysetup();
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