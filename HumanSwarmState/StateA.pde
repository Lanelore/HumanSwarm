class StateA extends State {
  
  int ballWidth = 50;
  int ballGrowth = 1;
  int speed = 1;
  int xPos = ballWidth/2;
  int xDir = speed;
  int yPos = ballWidth/2;
  int yDir = speed;
  boolean xOnce = true;
  boolean yOnce = true;

  StateA() {
    super();
  }
  
  StateA(StateMgr _stateMgr) {
    super(_stateMgr); 
  }
  
  void draw() {
    background(0);
    noStroke();
    fill(124, 252, 0);
    ellipse(xPos, yPos, ballWidth, ballWidth);
    xPos = xPos + xDir;
    if (xPos > width - ballWidth/2)
    {
      xDir = -speed;
    }
    if (xPos < ballWidth/2)
    {
      xDir = speed;
    }
    yPos = yPos + yDir;
    if (yPos > height - ballWidth/2)
    {
      yDir = -speed;
    }
    if (yPos < ballWidth/2)
    {
          yDir = speed;
    }
    
    if (ballWidth > height || ballWidth < 20)
    {
      ballGrowth = ballGrowth * (-1);
    }
    
    ballWidth = ballWidth + ballGrowth;
  }  
  
}