
class StateC extends State {
  
  StateC() {
    super();
  }
  
  StateC(StateMgr _stateMgr, int _idOfStateA) {
    super(_stateMgr); 
    idOfStateA = _idOfStateA;
  }
  
  float centerX;
  float centerY;
  
  void setup(){
    centerX = playArea.x + playArea.areaWidth/2;
    centerY = playArea.y + playArea.areaHeight/2;
  }
  
  void draw() {
    //fill(0, 0, 255);
    //rect(0, 0, width, height);  
    
    background(255);
    noStroke();
    playArea.drawPlayArea();
 
    noFill();
    stroke(0);
    
    
    PVector startPoint = new PVector(centerX, centerY);
    PVector startControlPoint = new PVector(playArea.x, centerY);
    PVector endControlPoint = new PVector(playArea.x, playArea.y + playArea.areaHeight);    
    PVector endPoint = new PVector(centerX, playArea.y + playArea.areaHeight);
   
    //curve that I want an object/sprite to move down
    bezier(startPoint.x, startPoint.y, startControlPoint.x, startControlPoint.y, endControlPoint.x, endControlPoint.y, endPoint.x, endPoint.y);
     
    fill(255);

    float t = (frameCount/200.0)%1;
    float x = bezierPoint(startPoint.x, startControlPoint.x, endControlPoint.x, endPoint.x, t);
    float y = bezierPoint(startPoint.y, startControlPoint.y, endControlPoint.y, endPoint.y, t);    
   
    println("x " + x + ", y " + y);
    fill(0,255,0);
    ellipse(x, y, 20, 20);
    
    
    /*
    
    noFill();
    bezier(85, 20, 10, 10, 90, 90, 15, 80);
    fill(255);
    int steps = 10;
    for (int i = 0; i <= steps; i++) {
      float t1 = i / float(steps);
      float x1 = bezierPoint(85, 10, 90, 15, t1);
      float y1 = bezierPoint(20, 10, 90, 80, t1);
      ellipse(x1, y1, 5, 5);      
    }
    */
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
  
  int idOfStateA;
}