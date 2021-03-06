import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

class PlayArea {
  
  float x;
  float y;
  float areaWidth;
  float areaHeight;
  int playAreaColor = color(0, 0, 255);
  
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

  public void setup() {
  }
  
  public void drawPlayArea() {
    noFill();
    stroke(playAreaColor);
    strokeWeight(1);
    //fill(playAreaColor);
    rect(x, y, areaWidth, areaHeight);
  }
}