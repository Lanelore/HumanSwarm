
// Version 4.1

float cursor_size = 25;
PFont font;
int scaleFactor = 3;
int windowWidth = 3030/scaleFactor; // for real Deep Space this should be 3030
int windowHeight = 3712/scaleFactor; // for real Deep Space this should be 3712
int wallHeight = 1914/scaleFactor; // for real Deep Space this should be 1914 (Floor is 1798)

Animation ant;
Animation fish;

boolean ShowTrack = true;
boolean ShowPath = false;
boolean ShowFeet = false;

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

  initTracking(false, wallHeight);
  table = loadTable("tracking.csv", "header");
  time = System.currentTimeMillis();
  
  ant = new Animation("ant",2);
  
}

void draw()
{
  // clear background with black
  background(0);

  // set upper half of window (=wall projection) bluish
  noStroke();
  fill(70, 100, 150);
  rect(0, 0, windowWidth, wallHeight);
  fill(150);
  text((int)frameRate + " FPS", width / 2, 10);
  text(numberPerson + " tracked person", width / 2, 30);

  if (ShowTrack)

    if (frame == 600) {
      saveTable(table, "tracking.csv");
      exit();
    }

  {

    //show recent trackers

    numberPerson = 0;
    String frameS = "" + frame;

    for (TableRow row : table.findRows(frameS, "frame")) {

      numberPerson++;

      noStroke();
      fill(255, 255, 255, opacityPrevious);
      ellipse(row.getFloat("x"), row.getFloat("y"), cursor_size, cursor_size);
      fill(0);
      
      //ant.display(row.getFloat("x"), row.getFloat("y"));

      if (showID)
        text(row.getInt("id"), row.getFloat("x"), row.getFloat("y"));
    }

    //show current trackers and save them in the csv file

    for (int trackID=0; trackID<GetNumTracks (); trackID++) 
    {

      numberPerson++;

      noStroke();
      fill(255, 255, 255);
      ellipse(GetX(trackID), GetY(trackID), cursor_size, cursor_size);
      fill(0);

      if (showID)
        text(GetCursorID(trackID), GetX(trackID), GetY(trackID));

      TableRow row = table.addRow();

      row.setLong("time", time);
      row.setInt("frame", frame);
      row.setInt("id", trackID);
      row.setFloat("x", GetX(trackID));
      row.setFloat("y", GetY(trackID));
    }

    frame++;
  }

  if (ShowPath)
  {
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

  if (ShowFeet)
  {
    // show the feet of each track
    for (int trackID=0; trackID<GetNumTracks (); trackID++) 
    { 
      // if we had used keys <0> .. <9> to deactivate the feet for this track, then we skip it here
      if (((int)pow(2, trackID) & show) != (int)pow(2, trackID))
      {
        continue;
      }
      stroke(70, 100, 150, 200);
      noFill();
      // paint all the feet that we can find for one character
      for (int footID=0; footID<GetNumFeet (trackID); footID++)
      {
        ellipse(GetFootX(trackID, footID), GetFootY(trackID, footID), cursor_size / 3, cursor_size / 3);
      }
    }
  }
}

void keyPressed()
{
  switch(key)
  {
  case 'p':
    ShowPath = !ShowPath;
    break;
  case 't':
    ShowTrack = !ShowTrack;
    break;
  case 'f':
    ShowFeet = !ShowFeet;
    break;
  }

  // use keys <0> .. <9> to toggle foot drawing of tracks 0 .. 9
  if (key >= '0' && key <= '9')
  {
    show = show ^ (int)pow(2, key - '0');
  }
}