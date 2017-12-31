// StateD starts with a circle in the middle. 
// It growths star like paths in 6 directions 

class StateD extends State {
  // speed parameter
  float timeUntilStar = 50;
  
  float armGrowthSpeed = 1;
  float ballGrowthSpeed = 1;
  float centerGrowthSpeed = 1;
  float scaleGrowthSpeed = 0.002f;

  float translate = 0;        // counts 
  float targetBallWidth = playArea.areaHeight/2; // final ballWidth
  float currentBallWidth = 0;
  float currentCenterWidth = targetBallWidth;
  float targetArmLength = 350; // final armLength  
  float maxArmLength = targetArmLength; // final armLength
  float armWidth = 50;
  float currentArmLength = 0;
  float targetScale = 0.45f;   // target scale
  float currentScale = 1;
  boolean growingStar = true;
  
  PVector center;
  PVector point0;
  PVector point60;
  PVector point120;
  PVector point180;
  PVector point240;
  PVector point300;
  
  int nextStateID;

  StateD() {
    super();
  }
  
  StateD(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void setup(){
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
        
    background(bgColor);
    playArea.drawPlayArea();    
    
    scaleImage(currentScale);
    
    noStroke();
    fill(greenColor);   
    
    // center
    if (growingStar){
      ellipse(center.x, center.y, targetBallWidth, targetBallWidth);  
    } else {
      if (currentCenterWidth > 0){
        currentCenterWidth -= centerGrowthSpeed;
      } 
      ellipse(center.x, center.y, currentCenterWidth, currentCenterWidth);  
    }
    
    if (timeUntilStar > 0){
      timeUntilStar -= 1;
      return;
    }
    
    stroke(greenColor); 
    
    if (growingStar || currentCenterWidth > 0){
      boolean starFinished = drawGrowingStar(); 
      
      if (starFinished){
        boolean dotsFinished = drawDots();
        
        if (currentScale > targetScale){
          currentScale -= scaleGrowthSpeed;
        } else {
          currentScale = targetScale;
        }
        
        if (dotsFinished){
          targetArmLength = 0;
          growingStar = false;
        }
      }
    } else {
      boolean shrinkingFinished = drawShrinkingStar();
      drawDots();
      
      if (shrinkingFinished){
        nextStateID = stateID + 1;
      }
    }
  }   
  
  public void scaleImage(float scalar){
    translate(+width/2, +height/2);
    scale(scalar);
    translate(-width/2, -height/2);
  }
  
  public boolean drawGrowingStar(){
    strokeWeight(armWidth);
    
    if (currentArmLength < targetArmLength){
      currentArmLength += armGrowthSpeed;
    }
    
    lineAngle((int) center.x, (int) center.y, radians(0), currentArmLength); 
    lineAngle((int) center.x, (int) center.y, radians(60), currentArmLength);
    lineAngle((int) center.x, (int) center.y, radians(120), currentArmLength);
    lineAngle((int) center.x, (int) center.y, radians(180), currentArmLength);
    lineAngle((int) center.x, (int) center.y, radians(240), currentArmLength);
    lineAngle((int) center.x, (int) center.y, radians(300), currentArmLength);
 
    return currentArmLength >= targetArmLength;
  }
  
  public boolean drawShrinkingStar(){
    strokeWeight(armWidth);
    
    if (currentArmLength > targetArmLength){
      currentArmLength -= armGrowthSpeed;
    }

    lineAngle((int) point0.x, (int) point0.y, radians(180), currentArmLength); 
    lineAngle((int) point60.x, (int) point60.y, radians(240), currentArmLength);
    lineAngle((int) point120.x, (int) point120.y, radians(300), currentArmLength);
    lineAngle((int) point180.x, (int) point180.y, radians(0), currentArmLength);
    lineAngle((int) point240.x, (int) point240.y, radians(60), currentArmLength);
    lineAngle((int) point300.x, (int) point300.y, radians(120), currentArmLength);
    
    return currentArmLength <= targetArmLength;
  }
  
  public boolean drawDots(){
    noStroke();       

    if (currentBallWidth < targetBallWidth){
      currentBallWidth += ballGrowthSpeed;
    }

    ellipse(point0.x, point0.y, currentBallWidth, currentBallWidth);
    ellipse(point60.x, point60.y, currentBallWidth, currentBallWidth);
    ellipse(point120.x, point120.y, currentBallWidth, currentBallWidth);
    ellipse(point180.x, point180.y, currentBallWidth, currentBallWidth);
    ellipse(point240.x, point240.y, currentBallWidth, currentBallWidth);
    ellipse(point300.x, point300.y, currentBallWidth, currentBallWidth);

    return currentBallWidth >= targetBallWidth;
  }
  
  public PVector pointAngle(PVector start, float angle, float length){
    float radiansAngle = radians(angle);
    return new PVector(start.x + cos(radiansAngle) * length, start.y - sin(radiansAngle) * length);
  }
  
  public void lineAngle(float x, float y, float angle, float length)
  {
    line(x, y, x+cos(angle) * length, y-sin(angle) * length);
  }
  
  // state transition from inside of state:
  public int getNextStateID() {
    return nextStateID;
  } 
}