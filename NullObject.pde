class NullObject extends Obstacles {
  
  NullObject(float X, float Y) {
    
    super(X,Y);
    
    obsType = "null";
    
  }
  
  void show(){
    noFill();
    noStroke();
    rect(x,y,wi,he);
  } 
}
