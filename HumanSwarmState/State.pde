
class State
{
  int stateID; 
  StateMgr stateMgr;
  PlayArea playArea;
  
  State() {
  }
  
  State(StateMgr _stateMgr) {
    stateMgr = _stateMgr;
    this.playArea = stateMgr.playArea;
  }
  
  void setup() {
  }
  
  void draw() {
  }
  
  int getNextStateID() {
    return stateID;
  }
 
  void setID(int _stateID) {
    stateID = _stateID;
  }

  int getID() {
    return stateID;
  }
  
  void setStateMgr(StateMgr _stateMgr) {
    stateMgr = _stateMgr;
  }
  
  boolean isActive(){
    return stateMgr.currentStateID == this.stateID ? true : false;
  }
}