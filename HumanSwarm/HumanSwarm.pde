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
float cursor_size_big = 100/scaleFactor;

int windowWidth = 3030/scaleFactor; // for real Deep Space this should be 3030
int windowHeight = 3712/scaleFactor; // for real Deep Space this should be 3712
int wallHeight = 1914/scaleFactor; // for real Deep Space this should be 1914 (Floor is 1798)
int floorHeight = windowHeight - wallHeight;

float opacityPrevUsers = 30;
float opacityPrevUsersBright = 80;

int numberPerson = 0;
int frame = 0;
long time;
int duration = 3600;
boolean showID = false;

String file = "tracking.csv";
Table table;

int show = 0xffff;

void settings()
{
  size(windowWidth, windowHeight);
}

void setup() {
  
  noStroke();
  fill(0);
  
  initTracking(false, wallHeight * scaleFactor);
  table = loadTable(file, "header");
  time = System.currentTimeMillis();
  
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
  
  //get all already drawn pixels and reset transformation parameters 
  loadPixels();
  popMatrix();
  clearWall();

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
    case '0':
      stateMgr.setState(STATEA);
      break;
    case '1':
      stateMgr.setState(STATEB);
      break;
    case '2':
      stateMgr.setState(STATEC);
      break;
    case '3':
      stateMgr.setState(STATED);
      break;
    case '4':
      stateMgr.setState(STATEE);
      break;
    case '5':
      stateMgr.setState(STATEF);
      break;
    case '6':
      stateMgr.setState(STATEG);
      break;
    case '7':
      stateMgr.setState(STATEH);
      break;
    case '8':
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