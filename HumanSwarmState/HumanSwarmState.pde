/*
* Simple finite state machine
* v1.1
*/

StateMgr stateMgr;

int STATEA;
int STATEB;
int STATEC;

void setup() {
  size(600, 400);
  smooth();
  noStroke();
  
  stateMgr = new StateMgr();
  
  STATEA = stateMgr.addState(new StateA(stateMgr));
  STATEB = stateMgr.addState(new StateB(stateMgr));
  STATEC = stateMgr.addState(new StateC(stateMgr, STATEA));
  
  stateMgr.setState(STATEA);
}

void draw() {
  stateMgr.getCurrentState().draw();
  stateMgr.updateStates();
  /*
  // state transition from application:
  // switch from state B to state A or C after 2 seconds (randomly)
  if (stateMgr.getCurrentStateID() == STATEB && stateMgr.getTimeInState() > 2000) {
    if (int (random(2)) == 0)
      stateMgr.setState(STATEA);
    else
      stateMgr.setState(STATEC);
  }
  */
}

void keyPressed() {
 
  switch(key)
  {
    case '1':
      stateMgr.setState(STATEA);
      break;
    case '2':
      stateMgr.setState(STATEB);
      break;
    case '3':
      stateMgr.setState(STATEC);
      break;
  }
} 