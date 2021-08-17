class BonusFish extends Obstacles {
  
  BonusFish(float X, float Y) {
    
    super(X,Y);
    
    bonusFish=loadImage("fishBonus.png");
    bonusFish.resize(wi,he);
    
    obsType = "bonus";

    
  }
  
  void show(){
    
    if(isAlive){
      image(bonusFish,x,y);
    }
    else{
      noFill();
      noStroke();
      rect(x,y,wi,he);
    } 
  
  
  }

}
