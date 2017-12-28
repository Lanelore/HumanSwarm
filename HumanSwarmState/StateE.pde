// StateE starts with the 6 ellipses formed in a circle
// out grows a path to the right direction that morphs into a shape
// it ends in a line that disappears and leaves a black screen

class StateE extends State {
  // speed parameter
  float translateSpeed = 0.5f; // how many pixel per frame are traversed

  PShape s;
  int scale = 10;
  int shapeWidth = 237 * scale;
  int shapeHeight = 113 * scale;
  float translate = 0;        // counts 
  float ballWidth = playArea.areaHeight/2;
  float maxArmLength = 350;
  
  PVector center;
  PVector point0;
  PVector point60;
  PVector point120;
  PVector point180;
  PVector point240;
  PVector point300;

  StateE() {
    super();
  }
  
  StateE(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  public void setup(){
    // The file "bot.svg" must be in the data folder
    // of the current sketch to load successfully
    s = loadShape("Path.svg");
    s.disableStyle();  // Ignore the colors in the SVG
    
    center = new PVector(playArea.x + playArea.areaWidth/2, playArea.y + playArea.areaHeight/2);
    point0 = pointAngle(center, 0, maxArmLength);
    point60 = pointAngle(center, 60, maxArmLength);
    point120 = pointAngle(center, 120, maxArmLength);
    point180 = pointAngle(center, 180, maxArmLength);
    point240 = pointAngle(center, 240, maxArmLength);
    point300 = pointAngle(center, 300, maxArmLength);
  }
  
  public void draw() {
    if (!this.isActive()){
      return;
    }
    
    background(bgColor);
    playArea.drawPlayArea();    
    noStroke();
    fill(greenColor);
    
    
    translate(+width/2, +height/2);
    scale(0.5f);
    translate(-width/2, -height/2);
    ellipse(playArea.x + playArea.areaWidth/2, playArea.y + playArea.areaHeight/2, ballWidth, ballWidth);
    
    stroke(greenColor);    
    drawDots();
    drawTunnels();
  }   
  
  public void drawDots(){
    noStroke();       

    ellipse(point0.x, point0.y, ballWidth, ballWidth);
    ellipse(point60.x, point60.y, ballWidth, ballWidth);
    ellipse(point120.x, point120.y, ballWidth, ballWidth);
    ellipse(point180.x, point180.y, ballWidth, ballWidth);
    ellipse(point240.x, point240.y, ballWidth, ballWidth);
    ellipse(point300.x, point300.y, ballWidth, ballWidth);
  }
  
  public PVector pointAngle(PVector start, float angle, float length){
    float radiansAngle = radians(angle);
    return new PVector(start.x + cos(radiansAngle) * length, start.y - sin(radiansAngle) * length);
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