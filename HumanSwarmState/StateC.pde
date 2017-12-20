// StateC starts with one circle in the middle
// After floating around, it splits into 2 and 4 balls and combines again in the middle

class StateC extends State {
  // speed parameter
  float animationSpeed = 200;  
  
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;
  float ballWidth = playArea.areaHeight/2;
  float targetBallWidth = ballWidth;
  float startSize = targetBallWidth;
  int counter = 0;
  float previousT = 0;
  int ballAmount = 1;
  PVector referenceVector = new PVector(centerX - playArea.areaHeight/2 + ballWidth/8, centerY);
  boolean delayGrowth = false;
  float delayTime = 0;
  boolean stopNow = false;
  boolean start1 = false;  // starts with the first previousT flip
  
  PVector[] pointsA = 
    {
      new PVector(centerX, centerY), 
        new PVector(playArea.x + ballWidth/2, centerY),      
        new PVector(playArea.x + ballWidth/2, playArea.y + playArea.areaHeight - ballWidth/2),
      new PVector(centerX, playArea.y + playArea.areaHeight - ballWidth/2), 
        new PVector(playArea.x + playArea.areaWidth - ballWidth/2, playArea.y + playArea.areaHeight - ballWidth/2),
        new PVector(playArea.x + playArea.areaWidth - ballWidth/2, playArea.y + playArea.areaHeight - ballWidth/2),
      new PVector(playArea.x + playArea.areaWidth - ballWidth/2, centerY), 
        new PVector(playArea.x + playArea.areaWidth - ballWidth/2, playArea.y + ballWidth/2),
        new PVector(centerX, playArea.y + ballWidth/2),
      new PVector(centerX, centerY)
    };
    
  // ends on the right side  
  PVector[] pointsB1 = 
    {
      new PVector(centerX, centerY), 
        new PVector(centerX, playArea.y + playArea.areaHeight - ballWidth/4),
        new PVector(playArea.x + ballWidth/4, playArea.y + playArea.areaHeight - ballWidth/4),
      new PVector(playArea.x + ballWidth/4, centerY),
        new PVector(playArea.x + ballWidth/4, playArea.y + ballWidth/4),
        new PVector(centerX, playArea.y + ballWidth/4),
      new PVector(centerX, centerY),
        new PVector(centerX, playArea.y + playArea.areaHeight - ballWidth/4),
        new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + playArea.areaHeight),
      new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + playArea.areaHeight * 0.75 - ballWidth/4),
    };
  
  // ends on the left side
  PVector[] pointsB2 = 
  {
    new PVector(centerX, centerY), 
      new PVector(centerX, playArea.y + playArea.areaHeight - ballWidth/4),
      new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + playArea.areaHeight - ballWidth/4),
    new PVector(playArea.x + playArea.areaWidth - ballWidth/4, centerY),
      new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + ballWidth/4),
      new PVector(centerX, playArea.y + ballWidth/4),
    new PVector(centerX, centerY),
      new PVector(centerX, playArea.y + playArea.areaHeight - ballWidth/4),
      new PVector(playArea.x + ballWidth/4, playArea.y + playArea.areaHeight),
    new PVector(playArea.x + ballWidth/4, playArea.y + playArea.areaHeight * 0.75 - ballWidth/4),
  };
  
  // left side top #1 (to the right)
  PVector[] pointsC1 = 
  {
    new PVector(playArea.x + ballWidth/4, playArea.y + playArea.areaHeight * 0.75 - ballWidth/4),
      new PVector(playArea.x + ballWidth/4, playArea.y + ballWidth/2),
      new PVector(playArea.x + ballWidth, playArea.y + playArea.areaHeight / 5),
    new PVector(centerX, playArea.y + playArea.areaHeight / 5),
      new PVector(playArea.x + playArea.areaWidth - ballWidth/1.5, playArea.y + playArea.areaHeight / 5), // outer
      new PVector(centerX + playArea.areaHeight/2 - ballWidth/8, playArea.y + ballWidth/1.5),
    new PVector(centerX + playArea.areaHeight/2 - ballWidth/8, centerY),
      new PVector(centerX + playArea.areaHeight/2 - ballWidth/8, centerY + playArea.areaHeight/2 - ballWidth/2), // outer
      new PVector(centerX, centerY),
    new PVector(centerX, centerY)
  };
  
  // left side bottom #3 (to the top)
  PVector[] pointsC2 = 
  {
    new PVector(playArea.x + ballWidth/4, playArea.y + playArea.areaHeight * 0.75 - ballWidth/4),
      new PVector(playArea.x + ballWidth/4, playArea.y + ballWidth/2),
      new PVector(playArea.x + ballWidth, playArea.y + playArea.areaHeight / 5 * 3),
    new PVector(centerX, playArea.y + playArea.areaHeight / 5 * 3),
      new PVector(playArea.x + playArea.areaWidth - ballWidth, playArea.y + playArea.areaHeight / 5 * 3), //inner
      new PVector(playArea.x + playArea.areaWidth - ballWidth, centerY - playArea.areaHeight/2 + ballWidth/8),
    new PVector(centerX, centerY - playArea.areaHeight/2 + ballWidth/8),
      new PVector(centerX - playArea.areaHeight/2 + ballWidth/2, centerY - playArea.areaHeight/2 + ballWidth/8), //inner
      new PVector(centerX, centerY),
    new PVector(centerX, centerY)  
  };
  
  // right side top #2 (to the bottom)
  PVector[] pointsC3 = 
  {
    new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + playArea.areaHeight * 0.75 - ballWidth/4),
      new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + ballWidth/2),
      new PVector(playArea.x + playArea.areaWidth - ballWidth, playArea.y + playArea.areaHeight / 5 * 2),
    new PVector(centerX, playArea.y + playArea.areaHeight / 5 * 2), 
      new PVector(playArea.x + ballWidth, playArea.y + playArea.areaHeight / 5 * 2), //inner
      new PVector(playArea.x + ballWidth, centerY + playArea.areaHeight/2 - ballWidth/8),
    new PVector(centerX, centerY + playArea.areaHeight/2 - ballWidth/8),
      new PVector(centerX + playArea.areaHeight/2 - ballWidth/2, centerY + playArea.areaHeight/2 - ballWidth/8), //inner
      new PVector(centerX, centerY),
    new PVector(centerX, centerY) 
  };
  
  // right side bottom #4 (to the left)
  PVector[] pointsC4 = 
  {
    new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + playArea.areaHeight * 0.75 - ballWidth/4),
      new PVector(playArea.x + playArea.areaWidth - ballWidth/4, playArea.y + ballWidth/2),
      new PVector(playArea.x + playArea.areaWidth - ballWidth, playArea.y + playArea.areaHeight / 5 * 4),
    new PVector(centerX, playArea.y + playArea.areaHeight / 5 * 4),
      new PVector(playArea.x + ballWidth/1.5, playArea.y + playArea.areaHeight / 5 * 4), // outer
      new PVector(centerX - playArea.areaHeight/2 + ballWidth/8, playArea.y + playArea.areaHeight - ballWidth/1.5),
    new PVector(centerX - playArea.areaHeight/2 + ballWidth/8, centerY),
      new PVector(centerX - playArea.areaHeight/2 + ballWidth/8, centerY - playArea.areaHeight/2 + ballWidth/2), // outer
      new PVector(centerX, centerY),
    new PVector(centerX, centerY)
  };
    
  StateC() {
    super();
  }
  
  StateC(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  void setup() { }
  
  void draw() {    
    // only only draw if this state is active
    if (!this.isActive()){
      return;
    }
        
    // draw the background once and draw all other balls and paths above via the specific followPath
    background(bgColor);
    playArea.drawPlayArea();
    
    // increase or decrease to the defined targetWidth
    if (ballWidth > targetBallWidth){        
      ballWidth -= 1;
    } else if (ballWidth < targetBallWidth){
      ballWidth += 1;
    }
      
    // create the defined amount of balls with their curved lines
    if (ballAmount == 1){
      followPath(pointsA);      
    } else if (ballAmount == 2){
      followPath(pointsB1);
      followPath(pointsB2);
    } else if (ballAmount == 4){
      followPath(pointsC1);
      followPath(pointsC2);
      followPath(pointsC3);
      followPath(pointsC4);
    } 
    
    // stopNow ensures that only one out of multiple balls increases the ballAmount and targetWidth
    stopNow = false;
  }
  
  void followPath(PVector[] points){   
    // t describes the current percentage of this curve's animation (0 = start, 1 = end)
    float t = (frameCount / animationSpeed) % 1;  
    // futueT is the t that will come after the current t - used to detect a futue flip
    float futureT = ((frameCount + 1) / 200.0f) % 1;  
        
    // increase the ball amount and target width BEFORE the array ends
    // this ensures that this function always gets called with the correct points array
    if (futureT < t){
      if (!start1){
        start1 = true;       
        printCircleArc(points, 0);
        return;
      } else if (counter + 4 >= points.length && !stopNow && !delayGrowth){
        println("targetBallWidth " + targetBallWidth);
        ballAmount *= 2;
        targetBallWidth = ballWidth/2;
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
    if (t < previousT && !delayGrowth){  
      if (counter + 4 >= points.length){
        counter = 0;
      } else{
        counter += 3;
      } 
    }     
    
    // save the current t to previousT so we can use both values to detect a flip in the next frame
    previousT = t;

    printCircleArc(points, t); 
  }
  
  void printCircleArc(PVector[] points, float t){
    noFill();
    stroke(bgColor);    
    PVector startPoint = new PVector(points[counter].x, points[counter].y);
    PVector startControlPoint = new PVector(points[counter + 1].x, points[counter + 1].y);
    PVector endControlPoint = new PVector(points[counter + 2].x, points[counter + 2].y); 
    PVector endPoint = new PVector(points[counter + 3].x, points[counter + 3].y);
    // curve that I want an object/sprite to move down
    //bezier(startPoint.x, startPoint.y, startControlPoint.x, startControlPoint.y, endControlPoint.x, endControlPoint.y, endPoint.x, endPoint.y);
    
    noStroke();
    fill(255);
    float x = bezierPoint(startPoint.x, startControlPoint.x, endControlPoint.x, endPoint.x, t);
    float y = bezierPoint(startPoint.y, startControlPoint.y, endControlPoint.y, endPoint.y, t);    
    fill(greenColor);
    // green circle that moves along the curve
    ellipse(x, y, ballWidth, ballWidth);
        
    // increase the ball size at the end of StateC
    // use a refernce point to check when it's time and wait delayTime before starting the growth
    if (x == referenceVector.x && y == referenceVector.y){
      delayGrowth = true;
    }
    if (delayGrowth && ballWidth < startSize){
      delayTime += 1;
    }
    if (delayGrowth && delayTime > 300){      
     // delayGrowth = false;
      delayTime = 0;
      targetBallWidth = startSize;
    } 
  }

  // state transition from inside of state:
  // after 3 seconds, next state is A
  int getNextStateID() {
    println("ballWidth " + ballWidth + ", startSize " + startSize + "; delayGrowth " + delayGrowth);
    if (delayGrowth && ballWidth == startSize)
    {
      return stateID + 1; 
    }
    return super.getNextStateID();
  } 
}