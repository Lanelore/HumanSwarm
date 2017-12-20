class PlayArea {
  
  float x;
  float y;
  float areaWidth;
  float areaHeight;
  color playAreaColor = color(0, 0, 255);
  
  PlayArea() {
    this.x = 0;
    this.y = 0;
    this.areaWidth = width;
    this.areaHeight = height;
  }
  
  PlayArea(float playAreaStartX, float playAreaStartY, float playAreaWidth, float playAreaHeight){
    this.x = playAreaStartX;
    this.y = playAreaStartY;
    this.areaWidth = playAreaWidth;
    this.areaHeight = playAreaHeight;
  }

  void setup() {
  }
  
  public void drawPlayArea() {
    noFill();
    stroke(playAreaColor);
    //fill(playAreaColor);
    rect(x, y, areaWidth, areaHeight);
  }
}