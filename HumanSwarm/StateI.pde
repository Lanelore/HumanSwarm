// StateI shows a green heart that disappears after a while
// this is the end of the animation
class StateI extends State {
  // speed parameter
  float timer = 0;
  float timeUntilHeartAppears = 400 * timeScale;
  float timeUntilHeartDisappears = 1200 * timeScale;
  
  boolean endMusic;
  
  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;

  PShape s;
  float scale = 0.3f;
  int shapeWidth = (int) (641 * scale) * 4/scaleFactor;
  int shapeHeight = (int) (577 * scale) * 4/scaleFactor;

  StateI() {
    super();
  }

  StateI(StateMgr _stateMgr) {
    super(_stateMgr);
  }

  public void setup() {
    // The file must be in the data folder
    // of the current sketch to load successfully
    s = loadShape("Heart.svg");
    s.disableStyle();  // Ignore the colors in the SVG
  }

  public void draw() {
    if (!this.isActive()) {
      return;
    }

    //background(bgColor);
    playArea.drawPlayArea();
    fill(greenColor);
    noStroke();

    timer += 1;
    if (timer > timeUntilHeartAppears && timer < timeUntilHeartDisappears) {
      shapeMode(CENTER);
      shape(s, centerX, centerY, shapeWidth, shapeHeight);
    }
    
    if (timer > timeUntilHeartDisappears * 1.1) {
      endMusic = true;
    }

    if (timer > timeUntilHeartDisappears * 1.5) {
      // the animation is now finished
      
      //save Tracking data - writeFromArray, if writeToArray activated
      //writeFromArray();
      clearTable();
      saveTable(table, file);
      //ToDo: delete oldest tracking data if tracked persons > 200
      exit();
    }
  }
  
  boolean endMusic(){
    return endMusic;
  }
}