/*
* Simple finite state machine
* v1.1
*/
import ddf.minim.*;
AudioPlayer[] player;
Minim minim;

//float mainGain = -30;
//float minGain = -60;
//float incrementGain = 0.8;

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

// this variable controls the time scale of all animations of each and every state
// 0.5 means double speed in case we half half of the usual fps (30 instead of 60)
float timeScale = 0.5f;

int scaleFactor = 1;
float cursor_size = 75/scaleFactor;
float cursor_size_big = 150/scaleFactor;

int windowWidth = 3030/scaleFactor; // for real Deep Space this should be 3030
int windowHeight = 3712/scaleFactor; // for real Deep Space this should be 3712
int wallHeight = 1914/scaleFactor; // for real Deep Space this should be 1914 (Floor is 1798)
int floorHeight = windowHeight - wallHeight;

float opacityPrevUsers = 70;
float opacityPrevUsersBright = 150;

Audio audio;

int numberPerson = 0;
int frame = 0;
int time;
boolean showID = false;

String file = "tracking.csv";
Table table;
ArrayList<Integer> trackingData = new ArrayList<Integer>();

int show = 0xffff;

void settings()
{
 
  //size(windowWidth, windowHeight, P2D);
  fullScreen(P2D, SPAN);
}

void setup() {
  
  player = new AudioPlayer[10];
  minim = new Minim(this);
  //for all circles
  
  player[0] = minim.loadFile("Magic.mp3");
  //for butterflies
  player[1] = minim.loadFile("Nature.mp3");
  //for danger (red area)
  player[2] = minim.loadFile("Shark.mp3");
  //for red points
  player[3] = minim.loadFile("Jungle.mp3");
  //for heart
  player[4] = minim.loadFile("Ending_long.mp3");
   
  textSize(40 * 4/scaleFactor);
  textAlign(CENTER, CENTER);
  
  noCursor();
  noStroke();
  fill(0);
  
  initTracking(false, wallHeight * scaleFactor);
  table = loadTable(file, "header");
  time = (int)System.currentTimeMillis();
  
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
  
  audio = new Audio();
  
}

void draw() {
  
  audio.play();
  
  pushMatrix();
  clearWindow();
  numberPerson = 0;
  
  stateMgr.getCurrentState().draw();
  stateMgr.updateStates();
  
  //get all already drawn pixels and reset transformation parameters 
  //loadPixels();
  popMatrix();
  clearWall();

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
  }

} 