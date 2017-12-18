
class StateC extends State {
  
  int idOfStateA;
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;
  float ballWidth = playArea.areaHeight/2;
  float targetBallWidth = ballWidth;
  int counter = 0;
  float previousT = 0;
  int ballAmount = 1;
  PVector referenceVector = new PVector(centerX - playArea.areaHeight/2 + ballWidth/8, centerY);
  boolean delayGrowth = false;
  float delayTime = 0;
  boolean stopNow = false;
  float animationSpeed = 200;
  
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
  
  StateC(StateMgr _stateMgr, int _idOfStateA) {
    super(_stateMgr); 
    idOfStateA = _idOfStateA;
  }
  
  void setup() {  }
  
  void draw() {    
    if (!this.isActive()){
      return;
    }
    
      background(255);
      playArea.drawPlayArea();
    
    if (ballWidth > targetBallWidth){        
      ballWidth -= 1;
    } else if (ballWidth < targetBallWidth){
      ballWidth += 1;
    }
      
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
    
    stopNow = false;
  }
  
  void followPath(PVector[] points){   
    float t = (frameCount / animationSpeed) % 1;          
    
  //  println("t " + t + ", framecount " + frameCount);               
    float futureT = ((frameCount + 1) / 200.0f) % 1;  
    println("t " + t + ", futureT " + futureT + ", previousT " + previousT + ", frameCount " + frameCount);
        
    if (futureT < t){
      if (counter + 4 >= points.length && !stopNow){
        ballAmount *= 2;
        targetBallWidth = ballWidth/2;
        println("ballAmount " + ballAmount);
        stopNow = true;
      } 
      println("future skip");
    }     
    
    if (t < previousT){
      if (counter + 4 >= points.length){
        counter = 0;
        println("end me");
      } else {
        counter += 3;
        println("increase");
      } 
    }          
        
    previousT = t;
    
    noFill();
    stroke(0);    
    PVector startPoint = new PVector(points[counter].x, points[counter].y);
    PVector startControlPoint = new PVector(points[counter + 1].x, points[counter + 1].y);
    PVector endControlPoint = new PVector(points[counter + 2].x, points[counter + 2].y); 
    PVector endPoint = new PVector(points[counter + 3].x, points[counter + 3].y);
    //curve that I want an object/sprite to move down
    bezier(startPoint.x, startPoint.y, startControlPoint.x, startControlPoint.y, endControlPoint.x, endControlPoint.y, endPoint.x, endPoint.y);
    
    noStroke();
    fill(255);
    float x = bezierPoint(startPoint.x, startControlPoint.x, endControlPoint.x, endPoint.x, t);
    float y = bezierPoint(startPoint.y, startControlPoint.y, endControlPoint.y, endPoint.y, t);    
    fill(0,255,0);
    ellipse(x, y, ballWidth, ballWidth);
    
    if (x == referenceVector.x && y == referenceVector.y){
      delayGrowth = true;
    }
    if (delayGrowth){
      delayTime += 1;
    }
    if (delayGrowth && delayTime > 300){      
      delayGrowth = false;
      delayTime = 0;
      targetBallWidth = playArea.areaHeight/2;
    }      
  }

  // state transition from inside of state:
  // after 3 seconds, next state is A
  int getNextStateID() {
    if (stateMgr.getTimeInState() > 3000)
    {
      //return idOfStateA; 
    }
    return super.getNextStateID();
  }  
}