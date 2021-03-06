class Audio{
   
  float mainGain = -30;
  float minGain = -80;
  float gain = minGain;
  float incrementGain = 1.2;
  
  AudioPlayer currentPlayer;
  AudioPlayer oldPlayer;
  
  int currentState = 0;
  int oldState = -1;
  boolean setup = true;
  
  boolean fadeIn = false;
  boolean fadeOut = false;
  boolean loadFile = false;
  
  void play(){
    
    //println("Gain: " + gain);
    
    if(oldState == -1){
      player[0].loop();
    }
    
    currentState = stateMgr.currentStateID;
    
    if(currentState != oldState){
      
      oldPlayer = currentPlayer;
      fadeOut = true;
    }
    
    if (currentState == 0) {
      
    mainGain = -10;
      
    currentPlayer = player[0];
  
    player[0].setGain(gain);
    //audio.play();
    
    fadeIn(player[0]);
    }
            
    else if(currentState == 5){
      
      currentPlayer = player[1];
      mainGain = 10;
      
    }
    
    else if(currentState == 6){
      
      mainGain = 0;
      currentPlayer = player[2];
    }
    
    else if(currentState == 7){
      
      mainGain = -10;
      currentPlayer = player[3];

    }
    
    else if(currentState == 8) {
    
      mainGain = -10;
      currentPlayer = player[4];
      
      if (((StateI)stateMgr.getState(8)).endMusic()){
        incrementGain = 0.1;
        fadeOut(currentPlayer);
      }
    }
    
   if(currentState == 5 || currentState == 6 || currentState == 7 || currentState == 8){
     makeTransition(oldPlayer, currentPlayer);
   }

   
   oldState = currentState;
    
}


void fadeOut(AudioPlayer player){
    
  if(gain > minGain){
    gain -= incrementGain;
    player.setGain(gain); 
    }
    
  else{
    player.pause();
    fadeIn = true;
    fadeOut = false;
}

}

void fadeIn(AudioPlayer player){
  
  if(gain < mainGain){
      gain+=incrementGain;
      player.setGain(gain);
    }
    
  else{
    fadeIn = false;
  }
}

void makeTransition(AudioPlayer transition, AudioPlayer player){
    
    if(fadeOut)
       fadeOut(transition);
       
    if(!fadeOut){
        player.setGain(gain);
        transition.pause();
        player.play();     
    }
     
    if(fadeIn)
       fadeIn(player);
        
}

}