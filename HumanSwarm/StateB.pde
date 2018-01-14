// StateB consists of a green screen that morphs into a ball

class StateB extends State {
  // speed parameter
  float lerpSpeed = 0.025 * (1/timeScale);
  
  // Morph Setup
  // Two ArrayLists to store the vertices for two shapes
  // This example assumes that each shape will have the same
  // number of vertices, i.e. the size of each ArrayList will be the same
  ArrayList<PVector> circle = new ArrayList<PVector>();
  ArrayList<PVector> square = new ArrayList<PVector>();
  
  // An ArrayList for a third set of vertices, the ones we will be drawing
  // in the window
  ArrayList<PVector> morph = new ArrayList<PVector>();
  
  int squareWidth = windowWidth/2;
  float circelWidth = playArea.areaHeight/2;
  
  // This boolean variable will control if we are morphing to a circle or square
  boolean state = false;
  boolean didOnce = false;

  StateB() {
    super();
  }
  
  StateB(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  void setup(){      
    // Create a circle using vectors pointing from center
    for (int angle = 0; angle < 360; angle += 9) {
      // Note we are not starting from 0 in order to match the
      // path of a circle.  
      PVector v = PVector.fromAngle(radians(angle-135));
      v.mult(circelWidth/2);
      circle.add(v);
      // Let's fill out morph ArrayList with blank PVectors while we are at it
      morph.add(new PVector());
    }
  
    // A square is a bunch of vertices along straight lines
    // Top of square
    for (int x = -squareWidth; x < squareWidth; x += squareWidth/5) {
      square.add(new PVector(x, -squareWidth));
    }
    // Right side
    for (int y = -squareWidth; y < squareWidth; y += squareWidth/5) {
      square.add(new PVector(squareWidth, y));
    }
    // Bottom
    for (int x = squareWidth; x > -squareWidth; x -= squareWidth/5) {
      square.add(new PVector(x, squareWidth));
    }
    // Left side
    for (int y = squareWidth; y > -squareWidth; y -= squareWidth/5) {
      square.add(new PVector(-squareWidth, y));
    }
  }
  
  void draw() {
    if (!this.isActive()){
      return;
    }
    
    //background(bgColor);
    playArea.drawPlayArea();

    noStroke();
    fill(greenColor);
  
    // We will keep how far the vertices are from their target
    float totalDistance = 0;
    
    // Look at each vertex
    for (int i = 0; i < circle.size(); i++) {
      PVector v1;
      
      // Are we lerping to the circle or square?
      if (state) {
        v1 = circle.get(i);
      }
      else {
        v1 = square.get(i);
      }
      // Get the vertex we will draw
      PVector v2 = morph.get(i);
      // Lerp to the target
      v2.lerp(v1, lerpSpeed);
      // Check how far we are from target
      totalDistance += PVector.dist(v1, v2);
    }
    
    // If all the vertices are close, switch shape
    if (totalDistance < 0.1) {
      state = !state;
      
      print(state ? "Circle " : "Square ");
    }
    
    if (!state && !didOnce){
       background(greenColor);
    } else {
       didOnce = true;
    }
    
    // Draw relative to center
    translate(playArea.x + playArea.centerX, playArea.y + playArea.centerY);
    // Draw a polygon that makes up all the vertices
    beginShape();
    for (PVector v : morph) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
  
    // state transition from inside of state:
  // after 3 seconds, next state is A
  int getNextStateID() {
    if (!state && didOnce)
    {
      return stateID + 1; 
    }
    return super.getNextStateID();
  } 
}