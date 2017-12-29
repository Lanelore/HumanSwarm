// StateF starts with a black screen 
// a butterfly flies into the screen, draws a few arcs, leaves and reappears
// in the end it leaves for good
class StateF extends State {

  StateF() {
    super();
  }
  
  StateF(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void draw() {
    if (!this.isActive()){
      return;
    }
    
    background(bgColor);
    playArea.drawPlayArea();
    
    noStroke();
    fill(greenColor);
  }
}