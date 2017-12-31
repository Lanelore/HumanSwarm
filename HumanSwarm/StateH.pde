// the existing user data gets visualized with red dots
// the test users try to spread out to not touch the red areas
class StateH extends State {
  // speed parameters
  float timeUntilNextState = 1000;
  
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;
  int nextStateID;

  StateH() {
    super();
  }
  
  StateH(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void setup(){
     nextStateID = super.getNextStateID();
  }
  
  public void draw() {
    if (!this.isActive()){
      return;
    }
    
    //background(bgColor);
    playArea.drawPlayArea();
    
    if (timeUntilNextState > 0){
      timeUntilNextState -= 1;
    } else {
      // switch to the next state after the time is over
      println("switch");
      nextStateID = stateID + 1;
    }
    
    // visualize all previous user data - call the function for each user position
    visualizeUser(centerX, centerY);
  }  
  
  public void visualizeUser(float x, float y){
     noStroke();
     fill(redColor);
     ellipse(x, y, 20, 20);  
  }
  
  // state transition from inside of state:
  public int getNextStateID() {
    return nextStateID;
  } 
}