
class StateC extends State {
  
  int idOfStateA;
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;
  float ballWidth = playArea.areaHeight/2;
  float targetBallWidth = ballWidth;
  int counter = 0;
  float previousT = 0;
  int ballAmount = 1;
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
    
  StateC() {
    super();
  }
  
  StateC(StateMgr _stateMgr, int _idOfStateA) {
    super(_stateMgr); 
    idOfStateA = _idOfStateA;
  }
  
  void setup() {  }
  
  void draw() {    
    background(255);
    playArea.drawPlayArea();
    
    if (ballWidth > targetBallWidth){        
      ballWidth -= 1;
    }
      
    if (ballAmount == 1){
      followPath(pointsA);      
    } else if (ballAmount == 2){
      followPath(pointsB1);
      followPath(pointsB2);
    }
    
    if (ballAmount == 4){
      background(0);
    }
  }
  
  void followPath(PVector[] points){
    float t = (frameCount / 200.0f) % 1;
    if (t < previousT){
      if (counter + 4 >= points.length){
        counter = 0;
        ballAmount *=2;
        targetBallWidth = ballWidth/2;
      } else {
        counter += 3;
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