// StateA starts with a black screen and continues to show the first green text
// it shows the second red text
class StateA extends State {
  // speed parameter
  float timer = 0;
  float timeUntilGreenTextAppears = 500;
  float timeUntilRedTextAppears = 900;
  float timeUntilTextDisappears = 1500;
  
  String green = "Berühre GRÜN";
  String red = "Vermeide ROT";
  
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;
  int nextStateID;

  StateA() {
    super();
  }
  
  StateA(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void setup(){
    nextStateID = super.getNextStateID();
    //player[0].setGain(gain);
    //player[0].loop();
  }
  
  public void draw() {
    if (!this.isActive()){
      return;
    }
       
    //background(bgColor);
    playArea.drawPlayArea();
    
    timer += 1;
    if (timer > timeUntilGreenTextAppears && timer < timeUntilTextDisappears){
      
        
      fill(greenColor);
      text(green, centerX, centerY - playArea.areaHeight/8);
  
      if (timer > timeUntilRedTextAppears){
          fill(redColor);
          text(red, centerX, centerY + playArea.areaHeight/8);
      }
    }
    
    if (timer > timeUntilTextDisappears){
      nextStateID = stateID + 1;
    }
  }  
  
  // state transition from inside of state:
  public int getNextStateID() {
    return nextStateID;
  } 
}