class PlayArea
{
  float x;
  float y;
  float areaWidth;
  float areaHeight;
  
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
    fill(0, 0, 255);
    rect(x, y, areaWidth, areaHeight);
  }
}