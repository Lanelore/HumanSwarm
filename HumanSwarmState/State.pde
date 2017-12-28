class State {
  
  int stateID; 
  StateMgr stateMgr;
  PlayArea playArea;
  int bgColor = color(0);
  int greenColor = color(0, 255, 0);
  
  State() {
  }
  
  State(StateMgr _stateMgr) {
    stateMgr = _stateMgr;
    this.playArea = stateMgr.playArea;
  }
  
  public void setup() {
  }
  
  public void draw() {
  }
  
  public int getNextStateID() {
    return stateID;
  }
 
  public void setID(int _stateID) {
    stateID = _stateID;
  }

  public int getID() {
    return stateID;
  }
  
  public void setStateMgr(StateMgr _stateMgr) {
    stateMgr = _stateMgr;
  }
  
  public boolean isActive(){
    return stateMgr.currentStateID == this.stateID ? true : false;
  }
}