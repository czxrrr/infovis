int num;
String[] lines;
String[] pieces;
int tmp;
int maxCheckin = 0, maxTime = 0;//max check-in times and max stay time
String maxCheckinId, maxTimeId;//ID of max check-in times and ID of max stay time
float x, y;
String[][] str;
int edge = 20;
int segment =10;
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
      tmp = Integer.parseInt(pieces[1]);
      if (tmp > maxCheckin)//get the max check-in times
      {
        maxCheckin = tmp;
        maxCheckinId = pieces[0];
      }
      tmp = Integer.parseInt(pieces[2]);
      if (tmp > maxTime)//get the max stay time
      {
        maxTime = tmp;
        maxTimeId = pieces[0];
      }
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
    background(200);
    stroke(0);
    textSize(10);
    ID = -1;
    int yID = 10;
    int d = 10;
    for (int i=1; i<num; i++)
    {
      pieces = str[i];
      //calculate coordinate x and y
      y = height - map(Integer.parseInt(pieces[1]), 0, maxCheckin, edge, width-edge);
      x = map(Integer.parseInt(pieces[2]), 0, maxTime, edge, height-edge);
      //judge color
      fill(colors[Integer.parseInt(pieces[3])][0],
      colors[Integer.parseInt(pieces[3])][1],
      colors[Integer.parseInt(pieces[3])][2]);
      ellipse(x, y, d, d);
      //check whether arrow is on an ID
      if (overCircle(x, y, d))
      {
        fill(0);
        text(pieces[0]+" "+pieces[1]+" "+pieces[3], edge*2, yID);
        fill(255);
        yID += 10;
        if (ID == -1)
          ID = Integer.parseInt(pieces[0]);
      }
    }
    fill(0);
    text(0, edge/2, height-edge/2);
    //
    int xSeg = maxDst/segment;
    int ySeg = maxTime/segment;
    //draw x axis
    for(int j=1;j<segment;j++)
      text(""+j*xSeg,j*width/segment,height-10);
    for(int j=1;j<segment;j++)
      text(""+j*ySeg,6,(segment-j)*height/segment);
     text("Tm",480,490);
     text("Ci",10,10);
    //maxTime is y, maxDst is x
    //for (int j = 1; j<10; j++)
      //text(maxDst/10*i,  
    line(edge, height-edge, width-edge/2, width-edge);
    line(edge, height-edge, edge, edge/2);
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
