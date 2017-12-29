// StateF starts with a black screen 
// a butterfly flies into the screen, draws a few arcs, leaves and reappears
// in the end it leaves for good
class StateF extends State {
  // speed parameter
  float animationSpeed = 200;  
  
  PShape s;
  float scale = 0.5f;
  int shapeWidth = (int) (93 * scale);
  int shapeHeight = (int) (61 * scale);
  
  int counter = 0;
  float previousT = 0;
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;
  
  PVector[] pointsA = 
  {
    new PVector(centerX, centerY), 
      new PVector(playArea.x, centerY),      
      new PVector(playArea.x, playArea.y + playArea.areaHeight),
    new PVector(centerX, playArea.y + playArea.areaHeight)
  };

  StateF() {
    super();
  }
  
  StateF(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void setup(){
    // The file must be in the data folder
    // of the current sketch to load successfully
    s = loadShape("Butterfly.svg");
    s.disableStyle();  // Ignore the colors in the SVG
  }
  
  public void draw() {
    if (!this.isActive()){
      return;
    }
    
    background(bgColor);
    playArea.drawPlayArea();
    
    noStroke();
    fill(greenColor);
    followPath(pointsA);      
    //shape(s, centerX, centerY, shapeWidth, shapeHeight); 
  }
  
  public void followPath(PVector[] points){   
    // t describes the current percentage of this curve's animation (0 = start, 1 = end)
    float t = (frameCount / animationSpeed) % 1;  
    // futueT is the t that will come after the current t - used to detect a futue flip
    float futureT = ((frameCount + 1) / 200.0f) % 1;  
        
    // increase the ball amount and target width BEFORE the array ends
    // this ensures that this function always gets called with the correct points array
    if (futureT < t){
      if (counter + 4 >= points.length){
        counter = 0;
      } else{
        counter += 3;
      } 
    }     

    printCircleArc(points, t); 
    
    // save the current t to previousT so we can use both values to detect a flip in the next frame
    previousT = t;
  }
  
  public void printCircleArc(PVector[] points, float t){
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
    
    float x2 = bezierPoint(startPoint.x, startControlPoint.x, endControlPoint.x, endPoint.x, previousT);
    float y2 = bezierPoint(startPoint.y, startControlPoint.y, endControlPoint.y, endPoint.y, previousT);   
    PVector prevPoint = new PVector(x2, y2);
    float a = calcRotationAngleInDegrees(prevPoint, currentPoint);
    println("angle " + a + ", currentpoint " + currentPoint + ", prevPoint " + prevPoint);
    // green circle that moves along the curve
    ellipse(x, y, 20, 20);     
        
    fill(greenColor);
    translate(x, y);
    shapeMode(CENTER);
    rotate(radians(a)); //frameCount
    shape(s, 0, 0, shapeWidth, shapeHeight); 
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
}