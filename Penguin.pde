class Penguin {
  
  float x, y;
  
  int w=100;
  int h= 140;

  
  Penguin(float X, float Y) {
    
    x = X;
    y = Y;
    
    penguin=loadImage("penguin.png");
    penguin.resize(w,h);
    
  }
  
  void show(){
 
    image(penguin,x,y);
    /*fill(100);
    rect(x,y,w,h);*/
  }
  
  void move(int Xvalue){
    x=x+Xvalue;
  }
  
  void testScreen(int Xvalue){
    if( x> width - w ){//20 avant
      x=x-Xvalue;  
    }
    else if( x < 0 ){
      x=x+Xvalue;
    }
  }
    
    boolean checkCollision(Obstacles obs){
    
        
        return
        x < obs.x + obs.wi &&
        y < obs.y + obs.he &&
        x + w > obs.x &&
        y + h > obs.y;

        
        
      
      }
      
    }
    
      
