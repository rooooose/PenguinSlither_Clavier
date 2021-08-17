class NeutralFish extends Obstacles {
  
  NeutralFish(float X, float Y) {
    
    super(X,Y);
    
    neutralFish=loadImage("fishNeutral.png");
    neutralFish.resize(wi,he);
    
    obsType = "poisson";

    
  }
  
  void show(){
    
    if(isAlive){
      image(neutralFish,x,y);
    }
    else{
      noFill();
      noStroke();
      rect(x,y,wi,he);
    } 
  
  
  }

}
