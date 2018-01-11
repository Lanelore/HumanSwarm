// StateI shows a green heart that disappears after a while
// this is the end of the animation
class StateI extends State {
  // speed parameter
  float timer = 0;
  float timeUntilHeartAppears = 100;
  float timeUntilHeartDisappears = 800;

  float centerX = playArea.x + playArea.areaWidth/2;
  float centerY = playArea.y + playArea.areaHeight/2;

  PShape s;
  float scale = 0.3f;
  int shapeWidth = (int) (641 * scale);
  int shapeHeight = (int) (577 * scale);

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

    if (timer > timeUntilHeartDisappears * 1.5) {
      // the animation is now finished
      // we can close this now and save the data or do whatever
      clearTable();
      saveTable(table, file);
      //ToDo: delete oldest tracking data if tracked persons > 200
      exit();
    }
  }
}