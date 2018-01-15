// StateE starts with the 6 ellipses formed in a circle
// out grows a path to the right direction that morphs into a shape
// it ends in a line that disappears and leaves a black screen

class StateE extends State {
  // speed parameter
  float translateSpeed = 1.5 * (1/timeScale) * 4/scaleFactor; // how many pixel per frame are traversed
  float lineGrowthSpeed = 1.5 * (1/timeScale) * 4/scaleFactor;
  
  PShape s;
  int scale = 15;
  int shapeWidth = 237 * scale * 4/scaleFactor;
  int shapeHeight = 113 * scale * 4/scaleFactor;
  float translate = 0;        // counts 
  float ballWidth = playArea.areaHeight/2;
  float maxArmLength = playArea.areaWidth/1.5;
  float armWidth = 50 * 4/scaleFactor;
  float currentArmLength = 0;
  float currentCenterLineCut = 0;
  boolean linesFinished = false;
  boolean pathsFinished = false;
  boolean centerLineFinished = false;
  float targetScale = 0.4f;   // target scale
  float currentLineWidth = armWidth * targetScale;
  
  PVector center;
  PVector point0;
  PVector point60;
  PVector point120;
  PVector point180;
  PVector point240;
  PVector point300;
  
  int nextStateID;

  StateE() {
    super();
  }
  
  StateE(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void setup(){
    // The file must be in the data folder
    // of the current sketch to load successfully
    s = loadShape("Path.svg");
    s.disableStyle();  // Ignore the colors in the SVG
    
    center = new PVector(playArea.x + playArea.areaWidth/2, playArea.y + playArea.areaHeight/2);
    point0 = pointAngle(center, 0, maxArmLength);
    point60 = pointAngle(center, 60, maxArmLength);
    point120 = pointAngle(center, 120, maxArmLength);
    point180 = pointAngle(center, 180, maxArmLength);
    point240 = pointAngle(center, 240, maxArmLength);
    point300 = pointAngle(center, 300, maxArmLength);
    
    nextStateID = super.getNextStateID();
  }
  
  public void draw() {
    
    if (!this.isActive()){
      return;
    }
     
    //background(bgColor);
    playArea.drawPlayArea();    
    noStroke();
    fill(greenColor);
    
    pushMatrix();
    translate(playArea.x + (playArea.areaWidth/2), playArea.y + (playArea.areaHeight/2));
    scale(targetScale);
    translate((-1) * (playArea.x + (playArea.areaWidth/2)), (-1) * (playArea.y + (playArea.areaHeight/2)));
    
    stroke(greenColor);    
        
    if (!pathsFinished){
      if (linesFinished){
        translateRight();
      }   
      
      drawDots();
      linesFinished = drawLines();
      
      if (linesFinished){
        pathsFinished = drawPaths();
      }
    }
    
    popMatrix();
    if (pathsFinished && !centerLineFinished){
      centerLineFinished = centerLine();
    } else if (centerLineFinished){
      nextStateID = stateID + 1;
    }
  }   
  
  public void drawDots(){
    noStroke();       

    ellipse(point0.x, point0.y, ballWidth, ballWidth);
    ellipse(point60.x, point60.y, ballWidth, ballWidth);
    ellipse(point120.x, point120.y, ballWidth, ballWidth);
    ellipse(point180.x, point180.y, ballWidth, ballWidth);
    ellipse(point240.x, point240.y, ballWidth, ballWidth);
    ellipse(point300.x, point300.y, ballWidth, ballWidth);
  }
  
  public PVector pointAngle(PVector start, float angle, float length){
    float radiansAngle = radians(angle);
    return new PVector(start.x + cos(radiansAngle) * length, start.y - sin(radiansAngle) * length);
  }
  
  void translateRight(){
    translate -= translateSpeed;
    translate(translate, 0);
  }
  
  boolean drawLines(){
    if (currentArmLength < (maxArmLength * 2)){
      currentArmLength += lineGrowthSpeed;
    } 
        
    stroke(greenColor); 
    strokeWeight(armWidth);
    
    line(point0.x, point0.y, point0.x+cos(0) * currentArmLength, point0.y-sin(0) * currentArmLength);
    line(point60.x, point60.y, point60.x+cos(0) * currentArmLength, point60.y-sin(0) * currentArmLength);
    line(point120.x, point120.y, point120.x+cos(0) * currentArmLength, point120.y-sin(0) * currentArmLength);
    line(point180.x, point180.y, point180.x+cos(0) * currentArmLength, point180.y-sin(0) * currentArmLength);
    line(point240.x, point240.y, point240.x+cos(0) * currentArmLength, point240.y-sin(0) * currentArmLength);    
    line(point300.x, point300.y, point300.x+cos(0) * currentArmLength, point300.y-sin(0) * currentArmLength);
    
    return currentArmLength >= (maxArmLength * 2);
  }
  
  boolean drawPaths(){ 
    strokeWeight(armWidth);
    
    line(point0.x, point300.y, point0.x + width * 2, point300.y);
    line(point0.x, point0.y, point0.x + width * 2, point0.y);
    line(point0.x, point60.y, point0.x + width * 2, point60.y);

    line(point0.x + width * 2, point300.y, point0.x + width * 2.5, point0.y);
    line(point0.x + width * 2, point0.y, point0.x + width * 2.5, point0.y);
    line(point0.x + width * 2, point60.y, point0.x + width * 2.5, point0.y);    
    
    noStroke();
    shape(s, point0.x + windowWidth * 2.5 - armWidth, wallHeight + ((floorHeight - shapeHeight) / 2), shapeWidth, shapeHeight); 
    
    stroke(greenColor); 
    strokeWeight(armWidth);  
    line(point0.x + width * 2.5 - armWidth*2 + shapeWidth, point0.y, point0.x + width * 3.5 - armWidth + shapeWidth + width / targetScale, point0.y);
    
    if (translate * (-1) >= (point0.x + width * 3.5 - armWidth*2 + shapeWidth)){
      return true;
    }
    return false;
  }
  
  boolean centerLine(){
    if (currentCenterLineCut < width/2){
      currentCenterLineCut += lineGrowthSpeed;
    } else if (currentLineWidth > 1){
      currentLineWidth -=1;
    }
    
    stroke(greenColor); 
    strokeWeight(currentLineWidth); 
    line(currentCenterLineCut, center.y, width - currentCenterLineCut, center.y);
        
    return currentLineWidth <= 1;
  }
  
  // state transition from inside of state:
  public int getNextStateID() {
    return nextStateID;
  } 
}