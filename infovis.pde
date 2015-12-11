/**
 * Program for visual information home work
 * 
 * There still exist some problems
 * 
 */
PImage bg ;
String[] lines;
People[] people;
int index = 1;//start from the seconde line, we don't need the first line
int count=0;
int h,min,sec;
String time;
String[] pieces;
void setup() {
  people=new People[999999];
  count=0;
  h=8; min=0; sec=0;
  time="2014-6-06 08:00:00";
  bg=loadImage("back.jpg");
  size(500, 500);
  background(bg);
  stroke(255);
  frameRate(100);
  lines = loadStrings("test.txt");
}

void draw() {
  int i;
  if (index < lines.length) {
    pieces = split(lines[index], ',');
    //println(pieces[0]);
    while (pieces.length > 0 && time.compareTo(pieces[0])>=0) {
      //current time is more than the data time, then shows the date
      //this is aim to speed up to play,or it will cost me more than 15 mins
      //to watch the movement of crowd through the whole day
      if (pieces[2].equals("check-in")){
        int x = int(pieces[3]) * 5;
        int y = 495 - int(pieces[4]) * 5;
        people[count]=new People(pieces[1],x,y);
        count++;
        //point(x, y);
        //ellipse(x, y, 8, 8);
      }else{
        for(i=0;i<count;i++){
          if(pieces[1].equals(people[i].id)){
            people[i].x=int(pieces[3]) * 5;
            people[i].y=495 - int(pieces[4]) * 5;
          }
        }
      }
      index = index + 1;
      pieces = split(lines[index], ',');
    }
  }
  redraw();
  time_plus(1);
}

void time_plus(int round){
  int k;
  for(k=0;k<round;k++){
    sec++;
    if(sec==60){sec= 0; min++;}
    if(min==60){min=0; h++;}
    time="2014-6-06 ";
    if(h<=9){
      time=time+"0"+h;
    }else{
      time=time+h;
    }
    if(min<=9){
      time=time+":0"+min;
    }else{
      time=time+":"+min;
    }
    if(sec<=9){
      time=time+":0"+sec;
    }else{
      time=time+":"+sec;
    }  
  }

  //println(time);
}


void redraw(){
  int i,r,g,b;
  color p;
  background(bg);
  for(i=0;i<count;i++){
    r=Integer.valueOf(people[i].id)%256;
    g=Integer.valueOf(people[i].id)/256 %256;
    b=Integer.valueOf(people[i].id)/256/256 % 256;
    p = color(r,g,b);
    stroke(p);
    rect(people[i].x, people[i].y, 4 , 4);
  }
}