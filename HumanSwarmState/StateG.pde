// StateF starts with a black screen 
// a butterfly flies into the screen, draws a few arcs, leaves and reappears
// in the end it leaves for good
class StateG extends State {
  // speed parameter
  float animationSpeed = 200;  
  
  PShape s;
  float scale = 0.5f;
  int shapeWidth = (int) (206 * scale);
  int shapeHeight = (int) (367 * scale);
  
  int counter = 0;
  float previousT = 0;
  float previousTCopy = 0;
  float t = 0;
  float futureT = 0;
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;
  PVector referenceVector = new PVector(centerX + playArea.areaHeight/2, centerY);
  
  boolean startB = false;
  boolean stopNow = false;
  boolean start1 = false;  // starts with the first previousT flip
  boolean finished = false;
  
  int nextStateID;
  
  PVector[] pointsA = 
  {
    new PVector(-shapeWidth, centerY),
      new PVector(playArea.x, centerY),      
      new PVector(centerX, playArea.y),
    new PVector(centerX, centerY),
      new PVector(centerX, playArea.y + playArea.areaHeight),      
      new PVector(centerX + playArea.areaHeight/2, playArea.y + playArea.areaHeight),
    new PVector(centerX + playArea.areaHeight/2, centerY),
      new PVector(centerX + playArea.areaHeight/2, playArea.y),
      new PVector(centerX + shapeWidth, playArea.y),
    new PVector(centerX + shapeWidth, centerY),
      new PVector(centerX + shapeWidth, playArea.y + playArea.areaHeight),
      new PVector(centerX, centerY + playArea.areaHeight/3),
    new PVector(centerX - playArea.areaHeight/3, centerY + playArea.areaHeight/3),
      new PVector(playArea.x, centerY + playArea.areaHeight/3),
      new PVector(playArea.x, centerY),
    new PVector(centerX - playArea.areaHeight/3, centerY),
      new PVector(centerX, centerY),
      new PVector(centerX, centerY),
    new PVector(centerX, height + shapeWidth)
  };

  StateG() {
    super();
  }
  
  StateG(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void setup(){
    // The file must be in the data folder
    // of the current sketch to load successfully
    s = loadShape("Shark.svg");
    s.disableStyle();  // Ignore the colors in the SVG
    nextStateID = super.getNextStateID();
  }
  
  public void draw() {
    if (!this.isActive()){
      return;
    }
    
    background(bgColor);
    playArea.drawPlayArea();
    
    noStroke();
    fill(redColor);
    
    if (!finished){
      finished = followPath(pointsA);      
    } 
    
    if (finished){
     // nextStateID = stateID + 1;
    }
    
    stopNow = false;

    // it is important for the flip calculation to reset the previousT in each function call (both a and b butterfly)
    // both of them need the same previousT value to calculate the rotation though
    // this is why we make a copy specifically for both butterfly orientations
    previousTCopy = previousT;
  }
  
  public boolean followPath(PVector[] points){   
    // t describes the current percentage of this curve's animation (0 = start, 1 = end)
    t = (frameCount / animationSpeed) % 1;  
    // futueT is the t that will come after the current t - used to detect a futue flip
    futureT = ((frameCount + 1) / 200.0f) % 1;  
        
    // increase the ball amount and target width BEFORE the array ends
    // this ensures that this function always gets called with the correct points array
    if (futureT < t){
      if (!start1){
        start1 = true;       
        printCircleArc(points, 0, previousT);
        return false;
      } else if (counter + 4 >= points.length && !stopNow){
        stopNow = true;
      } 
    }     
    
    // reset the t value until the animation actually starts - the ball stays in the middle
    if (!start1){
        t = 0;
        previousT = 0;
        counter = 0;
    }
    
    // increase the counter AFTER the old array ends when we have the NEW array
    // this gets called one frame after the previous if statement
    if (t < previousT){  
      if (counter + 4 >= points.length){
        counter = 0;
        return true;
      } else {
        counter += 3;
      } 
    }     

    printCircleArc(points, t, previousT); 
    
    // save the current t to previousT so we can use both values to detect a flip in the next frame
    previousT = t;
    return false;
  }
  
  public void printCircleArc(PVector[] points, float t, float previousT){
    noFill();
    stroke(100);    
    PVector startPoint = new PVector(points[counter].x, points[counter].y);
    PVector startControlPoint = new PVector(points[counter + 1].x, points[counter + 1].y);
    PVector endControlPoint = new PVector(points[counter + 2].x, points[counter + 2].y); 
    PVector endPoint = new PVector(points[counter + 3].x, points[counter + 3].y);
    // curve that I want an object/sprite to move down
    bezier(startPoint.x, startPoint.y, startControlPoint.x, startControlPoint.y, endControlPoint.x, endControlPoint.y, endPoint.x, endPoint.y);
    
    noStroke();
    fill(255);
    float x = bezierPoint(startPoint.x, startControlPoint.x, endControlPoint.x, endPoint.x, t);
    float y = bezierPoint(startPoint.y, startControlPoint.y, endControlPoint.y, endPoint.y, t);   
    PVector currentPoint = new PVector(x, y);
    
    float x2 = bezierPoint(startPoint.x, startControlPoint.x, endControlPoint.x, endPoint.x, previousTCopy);
    float y2 = bezierPoint(startPoint.y, startControlPoint.y, endControlPoint.y, endPoint.y, previousTCopy);   
    PVector prevPoint = new PVector(x2, y2);
      
    PVector point1 = prevPoint;
    PVector point2 = currentPoint;
        
    if (previousT > t){
      point1 = currentPoint;
      float x3 = bezierPoint(startPoint.x, startControlPoint.x, endControlPoint.x, endPoint.x, futureT);
      float y3 = bezierPoint(startPoint.y, startControlPoint.y, endControlPoint.y, endPoint.y, futureT); 
      point2 = new PVector(x3, y3);
    }
    float a = calcRotationAngleInDegrees(point1, point2);
    
    // green circle that moves along the curve
    ellipse(x, y, 20, 20);     
        
    pushMatrix();    
    fill(redColor);
    translate(x, y);
    shapeMode(CENTER);
    rotate(radians(a)); //frameCount
    shape(s, 0, 0, shapeWidth, shapeHeight); 
    popMatrix();
    
    // increase the ball size at the end of StateC
    // use a refernce point to check when it's time and wait delayTime before starting the growth
    if (x == referenceVector.x && y == referenceVector.y){
      startB = true;
    }
  }
  
  /**
   * Calculates the angle from centerPt to targetPt in degrees.
   * The return should range from [0,360), rotating CLOCKWISE, 
   * 0 and 360 degrees represents NORTH,
   * 90 degrees represents EAST, etc...
   *
   * Assumes all points are in the same coordinate space.  If they are not, 
   * you will need to call SwingUtilities.convertPointToScreen or equivalent 
   * on all arguments before passing them  to this function.
   *
   * @param centerPt   Point we are rotating around.
   * @param targetPt   Point we want to calcuate the angle to.  
   * @return angle in degrees.  This is the angle from centerPt to targetPt.
   */
  public float calcRotationAngleInDegrees(PVector centerPt, PVector targetPt)
  {
    // calculate the angle theta from the deltaY and deltaX values
    // (atan2 returns radians values from [-PI,PI])
    // 0 currently points EAST.  
    // NOTE: By preserving Y and X param order to atan2,  we are expecting 
    // a CLOCKWISE angle direction.  
    double theta = Math.atan2(targetPt.y - centerPt.y, targetPt.x - centerPt.x);

    // rotate the theta angle clockwise by 90 degrees 
    // (this makes 0 point NORTH)
    // NOTE: adding to an angle rotates it clockwise.  
    // subtracting would rotate it counter-clockwise
    theta += Math.PI/2.0;

    // convert from radians to degrees
    // this will give you an angle from [0->270],[-180,0]
    double angle = Math.toDegrees(theta);

    // convert to positive range [0-360)
    // since we want to prevent negative angles, adjust them now.
    // we can assume that atan2 will not return a negative value
    // greater than one partial rotation
    if (angle < 0) {
       angle += 360;
    }

    return (float) angle;
  }
  
    // state transition from inside of state:
  public int getNextStateID() {
    return nextStateID;
  } 
}