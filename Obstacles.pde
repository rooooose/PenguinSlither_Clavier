class Obstacles {
  
  float x, y;
  
  int wi=100;
  int he=100;
  
  int k; //renvoie aux indices du tableau d'obstacles
  String obsType;
  
  boolean isAlive;
  
  int speed;
  
  
  Obstacles(float X, float Y) {
    
    x = X;
    y = Y;
    
    hole=loadImage("hole.png");
    hole.resize(wi,he);
    
    obsType = "trou";
    
    isAlive = true;
  }
  
  void update(){
    
    changeSpeed();
    
   /* float rand= random(100);
    z = random(-300,300+rand);*/
      
      for (k=0;k<6;k++){
        
        if (obs[k].y > height){
        
     
          objectAlea = int(random(10));
        
          if(objectAlea <= 3){
           
             
             switch(k) {
              case 0: 
                obs[k] = new NeutralFish(50, y);  
                break;
              case 1: 
                obs[k] = new NeutralFish(250, y); 
                break;
              case 2: 
                obs[k] = new NeutralFish(450, y);
                break;
            }
             
            
          }
          else if(objectAlea == 4){
              
            switch(k) {
              case 0: 
                obs[k] =  new NullObject(50, y);  
                break;
              case 1: 
                obs[k] =  new NullObject(250, y);  
                break;
              case 2: 
                obs[k] = new NullObject(450, y); 
                break;
            }
          }
          
          else if(objectAlea == 5 && timer>=20){
            
            switch(k) {
              case 0: 
                obs[k] =  new BonusFish(50, y);  
                break;
              case 1: 
                obs[k] =  new BonusFish(250, y);  
                break;
              case 2: 
                obs[k] = new BonusFish(450, y); 
                break;
            }
          }
            
          else{
            
             switch(k) {
              case 0: 
                obs[k] = new Obstacles(50, y);  
                break;
              case 1: 
                obs[k] = new Obstacles(250, y);  
                break;
              case 2: 
                obs[k] = new Obstacles(450, y); 
                break;
            }
            
          }
          
          
          //int positionY = int(random(2));
          
          /*switch(positionY) {
              case 0: 
                obs[k].y = y3; 
                break;
              case 1: */
                obs[k].y = -he;   
                /*break;
              case 2: 
                obs[k].y = y3;  
                break;
            }*/
          
            
          
          
          
          //if(z>0){
           // obs[k].y = -he-200; 
            
          //}
          /*else{
            obs[k].y = -he+z;
          }*/
  
      
          }
          
        }
        y = y + speed;
        
      }
  
  void show(){
    /*fill(100);
    rect(x,y,wi,he);*/
   
      image(hole,x,y);
   
    
  }  

  
  /*
  void changeSpeed(){
    if(timer<20 || slowdown){
      speed = 6;
    }
    else if(timer>=20 && timer<50){
      speed=7;
    }
    else if(timer>=50 && timer<120){
      speed=8;
    }
    else if(timer>=120){
      speed=9;
      
    }
    if(gameover==true){
      speed=0;
      
    }
  }*/
  
  /*faster version*/
  
  void changeSpeed(){
    if(timer<20 || slowdown){
      speed = 7;
    }
    else if(timer>=20 && timer<50){
      speed=8;
    }
    else if(timer>=50 && timer<120){
      speed=9;
    }
    else if(timer>=120){
      speed=10;
      
    }
    else if(timer>=180){
      speed=11;
      
    }
    else if(timer>=210){
      speed=12;
      
    }
    else if(timer>=240){
      speed=13;
      
    }
    else if(timer>=270){
      speed=14;
      
    }
    if(gameover || pause){
      speed=0;
      
    }
  }
  
}
