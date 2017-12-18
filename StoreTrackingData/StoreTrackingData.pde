
// Version 4.1

float cursor_size = 25;
PFont font;
int scaleFactor = 5;
int windowWidth = 3030/scaleFactor; // for real Deep Space this should be 3030
int windowHeight = 3712/scaleFactor; // for real Deep Space this should be 3712
int wallHeight = 1914/scaleFactor; // for real Deep Space this should be 1914 (Floor is 1798)

Animation ball;

boolean showID = false;
float opacityPrevious = 40;
int numberPerson = 0;
int frame = 0;
long time;

Table table;

int show = 0xffff;

void settings()
{
  size(windowWidth, windowHeight);
}

void setup()
{
  noStroke();
  fill(0);

  font = createFont("Arial", 18);
  textFont(font, 18);
  textAlign(CENTER, CENTER);

  initTracking(false, wallHeight*scaleFactor);
  table = loadTable("tracking.csv", "header");
  time = System.currentTimeMillis();
  
  ball = new Animation("ball",6);
}

void draw()
{

  clearWindow();

  if (frame == 600) {
    saveTable(table, "tracking.csv");
    exit();
  }

  numberPerson = 0;

  //show previous trackers
  readCsv();

  //show current trackers
  currentTrackingData();

  frame++;
}

void calculateOrientation() {

  // show the motion path of each track on the floor    
  for (int trackID=0; trackID<GetNumTracks (); trackID++) 
  {      
    stroke(255, 0, 0);
    int numPoints = GetNumPathPoints (trackID);
    if (numPoints > 1)
    {      
      int maxDrawnPoints = 300;      
      int startX = GetPathPointX(trackID, numPoints - 1);
      int startY = GetPathPointY(trackID, numPoints - 1);
      for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxDrawnPoints); pointID--) 
      {  
        int endX = GetPathPointX(trackID, pointID);
        int endY = GetPathPointY(trackID, pointID);
        line(startX, startY, endX, endY);
        startX = endX;
        startY = endY;
      }
    }
  }
}


void readCsv() {

  String frameS = "" + frame;

  for (TableRow row : table.findRows(frameS, "frame")) {

    numberPerson++;

    noStroke();
    fill(255, 255, 255, opacityPrevious);
    ellipse(row.getFloat("x")/scaleFactor, row.getFloat("y")/scaleFactor, cursor_size, cursor_size);
    fill(0);
    
     //ball.display(row.getFloat("x") * 3, row.getFloat("y") * 3);

    if (showID)
      text(row.getInt("id"), row.getFloat("x"), row.getFloat("y"));
  }
}

void writeCsv(int trackID) {

  TableRow row = table.addRow();

  row.setLong("time", time);
  row.setInt("frame", frame);
  row.setInt("id", trackID);
  row.setFloat("x", GetX(trackID));
  row.setFloat("y", GetY(trackID));
}

void currentTrackingData() {

  for (int trackID=0; trackID<GetNumTracks (); trackID++) 
  {

    numberPerson++;

    //noStroke();
    //fill(255, 255, 255);
    //ellipse(GetX(trackID), GetY(trackID), cursor_size, cursor_size);
    //fill(0);
  
    if (showID)
      text(GetCursorID(trackID), GetX(trackID), GetY(trackID));

    writeCsv(trackID);
  }
}

void keyPressed()
{
  switch(key)
  {
  case 'p':
    //ShowPath = !ShowPath;
    break;
  case 't':
    //ShowTrack = !ShowTrack;
    break;
  }

  // use keys <0> .. <9> to toggle foot drawing of tracks 0 .. 9
  if (key >= '0' && key <= '9')
  {
    show = show ^ (int)pow(2, key - '0');
  }
}

void clearWindow() {
  // clear background with black
  background(0);

  // set upper half of window (=wall projection) bluish
  noStroke();
  fill(70, 100, 150);
  rect(0, 0, windowWidth, wallHeight);
  fill(150);
  text((int)frameRate + " FPS", width / 2, 10);
  text(numberPerson + " tracked person", width / 2, 30);
}