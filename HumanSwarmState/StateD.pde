// StateD starts with a circle in the middle. 
// It growths star like paths in 6 directions and then pans into several paths
// it ends in a line that vanishes completeley, leaving the area black

class StateD extends State {
  // speed parameter
  float translateSpeed = 0.5; // how many pixel per frame are traversed
  float timeUntilStar = 200;
  float armGrowthSpeed = 2;

  PShape s;
  int scale = 5;
  int shapeWidth = 237 * scale;
  int shapeHeight = 113 * scale;
  float translate = 0;        // counts 
  float ballWidth = playArea.areaHeight/2;
  float armLength = 200; // final armLength
  float armWidth = 50;
  float currentArmLength = 0;

  StateD() {
    super();
  }
  
  StateD(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  void setup(){
    // The file "bot.svg" must be in the data folder
    // of the current sketch to load successfully
    s = loadShape("Path.svg");
    s.disableStyle();  // Ignore the colors in the SVG
  }
  
  void draw() {
    if (!this.isActive()){
      return;
    }
    
    background(bgColor);
    playArea.drawPlayArea();    
    noStroke();
    fill(greenColor);
    
    
    translate(+width/2, +height/2);
   // scale(0.5);
    translate(-width/2, -height/2);
    ellipse(playArea.x + playArea.areaWidth/2, playArea.y + playArea.areaHeight/2, ballWidth, ballWidth);
    
    stroke(greenColor);    
    drawStar();    
    //   drawTunnels();
  }   
  
  void drawStar(){
    strokeWeight(armWidth);
    if (currentArmLength < armLength){
      currentArmLength += armGrowthSpeed;
    }
    lineAngle((int) (playArea.x + playArea.areaWidth/2), (int) (playArea.y + playArea.areaHeight/2), radians(0), currentArmLength); 
    lineAngle((int) (playArea.x + playArea.areaWidth/2), (int) (playArea.y + playArea.areaHeight/2), radians(60), currentArmLength); 
    lineAngle((int) (playArea.x + playArea.areaWidth/2), (int) (playArea.y + playArea.areaHeight/2), radians(120), currentArmLength); 
    lineAngle((int) (playArea.x + playArea.areaWidth/2), (int) (playArea.y + playArea.areaHeight/2), radians(180), currentArmLength); 
    lineAngle((int) (playArea.x + playArea.areaWidth/2), (int) (playArea.y + playArea.areaHeight/2), radians(240), currentArmLength);     
    lineAngle((int) (playArea.x + playArea.areaWidth/2), (int) (playArea.y + playArea.areaHeight/2), radians(300), currentArmLength); 
  }
  
  void lineAngle(int x, int y, float angle, float length)
  {
    line(x, y, x+cos(angle)*length, y-sin(angle)*length);
  }
  
  void drawTunnels(){
    translate -= translateSpeed;
    translate(translate, 0);
    
    int yDrawHeight = (height - shapeHeight) / 2;
    shape(s, 0, yDrawHeight, shapeWidth, shapeHeight);   
    
    if (translate == shapeWidth * (-1)){
        println("reached Width!");
    }
  }
}

/*
  
PShape s;

void setup() {
  size(100, 100);
  // The file "bot.svg" must be in the data folder
  // of the current sketch to load successfully
  s = loadShape("bot.svg");
}

void draw() {
  shape(s, 10, 10, 80, 80);
}
*/