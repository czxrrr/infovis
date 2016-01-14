int num;
String[] lines;
String[] pieces;
int tmp;
int tt=40;//transparency
int maxCheckin = 61, maxTime = 930;//max check-in times and max stay time
String maxCheckinId, maxTimeId;//ID of max check-in times and ID of max stay time
float x, y;
String[][] str;
int edge = 20;
int[][] colors = new int[][]{//6 colors
  {255,0,0}, 
  {0,255,0},
  {0,0,255},
  {255,255,0},
  {255,0,255},
  {0,255,255}
};
int txt = 0;//decide which day to show
int ID = -1;//the selected ID
int drawWhat = 0;//decide the page to show

void setup()
{
  mysetup();
  size(500, 500);
}

void mysetup()
{
  //drawWhat, 0:show scatter diagram, 1:show single person
  if (drawWhat==0)
  {
    //read one of three days
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
    }
    
    smooth();
  }
  if (drawWhat == 1)
  {
    setupSin();
  }
}

void draw()
{
  //drawWhat, 0:show scatter diagram, 1:show single person
  if (drawWhat==0)
  {
    background(255);
    stroke(0);
    textSize(10);
    ID = -1;
    int yID = 10;
    int d = 10;
    int cx = 5, cy = 8;
    float lx, ly;
    fill(60);
    text("t", width-10, height-20);
    text("c", 20, 13);
    for (int i=0; i<=cx; i++)
    {
      lx = map(i, 0, cx, edge, width-edge);
      stroke(160, 160, 160, 90);
      line(lx, edge, lx, height-edge);
      fill(60);
      text((int)map(i, 0, cx, 0, maxTime),
        lx-4, height-edge+15);
    }
    for (int i=0; i<=cy; i++)
    {
      ly = map(i, 0, cy, edge, height-edge);
      line(edge, ly, width-edge, ly);
      fill(60);
      text((int)map(i, 0, cy, 0, maxCheckin),
        edge-16, height-ly+4);
    }
    for (int i=1; i<num; i++)
    {
      pieces = str[i];
      //calculate coordinate x and y
      y = height - map(Integer.parseInt(pieces[1]), 0, maxCheckin, edge, width-edge);
      x = map(Integer.parseInt(pieces[2]), 0, maxTime, edge, height-edge);
      //judge color
      fill(colors[Integer.parseInt(pieces[3])][0],
           colors[Integer.parseInt(pieces[3])][1],
           colors[Integer.parseInt(pieces[3])][2],
           tt);
      noStroke();
      ellipse(x, y, d, d);
      //check whether arrow is on an ID
      if (overCircle(x, y, d))
      {
        fill(0);
        text(pieces[0]+"\t "+pieces[3], 30, yID);
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
  if (key=='q') drawWhat = 0;//go to show scatter diagram
  if (key=='z') txt = 0;//Friday
  if (key=='x') txt = 1;//Saturday
  if (key=='c') txt = 2;//Sunday
  mysetup();//resetup
}

void mousePressed()
{
  println(ID);
  if (ID != -1)
  {
    drawWhat = 1;//go to show single person
    mysetup();//resetup
    id = ""+ID;
    ID = -1;
  }
}

//decide whether arrow is on an ID
boolean overCircle(float x, float y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}