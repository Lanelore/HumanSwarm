
// Version 4.1

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

    //color pixels depending on shape/state

    if (green(pixels[(int)((row.getFloat("y")/scaleFactor)*width + (int)(row.getFloat("x")/scaleFactor))]) >= 250) {
      fill(255, 255, 0, opacityPrevUsersBright);
    } else if (red(pixels[(int)((row.getFloat("y")+1)/scaleFactor)*width + (int)((row.getFloat("x")+1)/scaleFactor)]) >= 250) {
      fill(255, 0, 0, opacityPrevUsersBright);
    } else {
      fill(255, 255, 255, opacityPrevUsers);
    }

    // special treatment for the old users when they turn red during phase H (7)
    if (stateMgr.currentStateID == 7) {
      fill(255, 0, 0, opacityPrevUsersBright);
      ellipse(row.getFloat("x")/scaleFactor, row.getFloat("y")/scaleFactor, cursor_size_big, cursor_size_big);
    } else {  
      ellipse(row.getFloat("x")/scaleFactor, row.getFloat("y")/scaleFactor, cursor_size, cursor_size);
    }

    ellipse(row.getFloat("x")/scaleFactor, row.getFloat("y")/scaleFactor - wallHeight, cursor_size, cursor_size);  

    if (showID)
      text(row.getInt("id"), row.getFloat("x"), row.getFloat("y"));
  }
}

void writeCsv(int trackID) {

  TableRow row = table.addRow();

  row.setInt("time", time);
  row.setInt("frame", frame);
  row.setInt("x", GetX(trackID)*scaleFactor);
  row.setInt("y", GetY(trackID)*scaleFactor);
}

void currentTrackingData() {

  for (int trackID=0; trackID<GetNumTracks (); trackID++) 
  {

    numberPerson++;

    noStroke();

    if (stateMgr.currentStateID == 7) {
      loadPixels();
    }

    // new color code for current users (WIP)
    if (green(pixels[(int)(GetY(trackID)*width + GetX(trackID))]) >= 250) {
      fill(255, 255, 0);
    } else if (red(pixels[(int)(GetY(trackID)*width + GetX(trackID))]) >= 50) {
      fill(255, 0, 0);
    } else {
      fill(255, 255, 255);
    }

    ellipse(GetX(trackID), GetY(trackID), cursor_size, cursor_size);
    ellipse(GetX(trackID), GetY(trackID) - wallHeight, cursor_size, cursor_size);
    fill(0);

    if (showID)
      text(GetCursorID(trackID), GetX(trackID), GetY(trackID));

    
    //ToDo: Store data in a List and before exit() save in csv file;

    //test.add(GetX(trackID));
    //test.add(GetY(trackID));
    //test.add(frame);
    //test.add(time);

    writeCsv(trackID);
  }
}


void clearWindow() {
  // clear background with black
  background(0);
}

void clearWall() {
  noStroke();
  fill(0);
  rect(0, 0, windowWidth, wallHeight);
  fill(150);
  text((int)frameRate + " FPS", width / 2, 10);
  text(numberPerson + " tracked person", width*scaleFactor / 2, 30);
}

void clearTable(){

  String error = "" + (-4.0);
       for (TableRow row : table.findRows(error, "x")) {
          row.setFloat("x", 1);
          println("value deleted!");
        }
        
        for (TableRow row : table.findRows(error, "y")) {
          row.setFloat("y", 1);
          println("value deleted!");
        }
}