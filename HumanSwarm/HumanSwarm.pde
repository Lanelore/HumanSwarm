/*
* Simple finite state machine
* v1.1
*/

StateMgr stateMgr;

int STATEA;
int STATEB;
int STATEC;
int STATED;
int STATEE;
int STATEF;
int STATEG;
int STATEH;
int STATEI;

int scaleFactor = 4;
float cursor_size = 75/scaleFactor;

int windowWidth = 3030/scaleFactor; // for real Deep Space this should be 3030
int windowHeight = 3712/scaleFactor; // for real Deep Space this should be 3712
int wallHeight = 1914/scaleFactor; // for real Deep Space this should be 1914 (Floor is 1798)

float opacityPrevUsers = 60;
int numberPerson = 0;
int frame = 0;
long time;
int duration = 500000;
boolean showID = false;

String file = "tracking.csv";
Table table;

int show = 0xffff;

void settings()
{
  size(windowWidth, windowHeight);
}

void setup() {
 
  
  //size(600, 400);
  //smooth();
  //noStroke();  
  
  noStroke();
  fill(0);

  initTracking(false, wallHeight * scaleFactor);
  table = loadTable(file, "header");
  time = System.currentTimeMillis();
  
  //PlayArea playArea = new PlayArea(width * 0.1, height * 0.1, width * 0.8, height * 0.8);
  
  PlayArea playArea = new PlayArea(width * 0.1, wallHeight + wallHeight * 0.1, width * 0.8, wallHeight * 0.8);
  stateMgr = new StateMgr(playArea);
  
  STATEA = stateMgr.addState(new StateA(stateMgr));
  STATEB = stateMgr.addState(new StateB(stateMgr));
  STATEC = stateMgr.addState(new StateC(stateMgr));
  STATED = stateMgr.addState(new StateD(stateMgr));
  STATEE = stateMgr.addState(new StateE(stateMgr));
  STATEF = stateMgr.addState(new StateF(stateMgr));  
  STATEG = stateMgr.addState(new StateG(stateMgr));
  STATEH = stateMgr.addState(new StateH(stateMgr));
  STATEI = stateMgr.addState(new StateI(stateMgr));
   
  stateMgr.setState(STATEA);
}

void draw() {
  
  pushMatrix();
  numberPerson = 0;
  clearWindow();
  
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
  
  //get all already drawn pixels and reset transformation parameters 
  loadPixels();
  popMatrix();

  if (frame == duration) {
    saveTable(table, file);
    //ToDo: sort table?
    exit();
  }
  
  //show previous trackers
  readCsv();

  //show current trackers and save them
  currentTrackingData();

  frame++;
  
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
    case '4':
      stateMgr.setState(STATED);
      break;
    case '5':
      stateMgr.setState(STATEE);
      break;
    case '6':
      stateMgr.setState(STATEF);
      break;
    case '7':
      stateMgr.setState(STATEG);
      break;
    case '8':
      stateMgr.setState(STATEH);
      break;
    case '9':
      stateMgr.setState(STATEI);
      break;
  case 'p':
    //ShowPath = !ShowPath;
    break;
  case 't':
    //ShowTrack = !ShowTrack;
    break;
  }

  // use keys <0> .. <9> to toggle foot drawing of tracks 0 .. 9
  if (key >= '0' && key <= '9')
  {
    show = show ^ (int)pow(2, key - '0');
  }
} 