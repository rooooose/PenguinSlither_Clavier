import processing.serial.*;
import ddf.minim.*;
Minim minim;

AudioPlayer backgroundMusic, obsSound, fishSound1, fishSound2;
static final int FADE = 2500;

Penguin p;
Serial port;

float z;
int timer;

int timerGameOver;
int timerStartBonus;
int timerBonus;

boolean gameover, mute;
int objectAlea;

float y1, y2, y3;

int nbFish;
int score;

boolean slowdown = false;
boolean startgame = false;
boolean pause = false;


 int penguinW= 100;
 int penguinH= 140;

Obstacles[] obs;

int xvalue = 0;
int yvalue = 0;

PImage background, penguin, hole, bonusFish, neutralFish, restartButton, playButton, playButton1, pauseButton, volOn, volOff, Wtext, GOtext, PStext, Stext, nullObj;


void setup(){
  size(600, 1400);
  /*port = new Serial(this, "COM3", 9600);
  port.bufferUntil('\n');*/
  minim=new Minim(this);
  backgroundMusic=minim.loadFile("PenguinRush.mp3");
  
  background = loadImage("background.png");    
  background.resize(width,height);
  
  
  PStext = loadImage("penguinSlither.png");
  PStext.resize(550,117);
  
  Wtext = loadImage("welcome.png");
  Wtext.resize(300,105);
 
  GOtext = loadImage("gameOver.png");
  GOtext.resize(500,141);
  Stext = loadImage("score.png");
  Stext.resize(200,85);
  
  restartButton = loadImage("restartButton.png");
  restartButton.resize(200,200);
  playButton = loadImage("playButton.png");
  playButton.resize(200,200);
  
  volOn = loadImage("audioActivatedButton.png");
  volOn.resize(60,60);
  volOff = loadImage("audioDisactivatedButton.png");
  volOff.resize(60,60);
  
  playButton1 = loadImage("playButton.png");
  playButton1.resize(60,60);
  
  pauseButton = loadImage("pauseButton.png");
  pauseButton.resize(60,60);

  obs = new Obstacles[6];
  resetGame();

}


void draw(){
  
 image(background,0,0);
 
 
 if (startgame == false){
    fill(255,255,255,63);
    rect(0, 0, width, height);
    image(playButton, 200, 350);
    image(PStext, 30, 100);
    image(Wtext, 150, 700);
  }
 
 if(startgame == true){
   if(!backgroundMusic.isPlaying() && !pause){
        backgroundMusic.rewind();
        backgroundMusic.play();
      } 
    
    p.show();
    
    if(!gameover && !pause){
      //p.move();
    }
    
    if(!gameover){
      displayScore();
    }
    
    p.testScreen(25);
    
    println(timer);
    timer=millis()/1000 - timerGameOver;
    
    
    if (!gameover && !mute){
      image(volOn, 520, 20);
    }
    else if(!gameover && mute){
      image(volOff, 520, 20);
    }
    
    
    if(pause && !gameover){
      image(playButton1, 520, 90);
    }
    else if(!pause && !gameover){
      image(pauseButton, 520, 90);
    }
    
    
    for (Obstacles obs : obs){
   
      obs.show();
        
      obs.update();
      
  
          if(obs.obsType == "trou"){
            
            if (p.checkCollision(obs)){

              if(obs.isAlive){
                
                obsSound=minim.loadFile("obstacle.wav");
                obsSound.play();
                println("GAME OVER");
                gameover = true;
            
              }
              obs.isAlive = false;
            }
    
          }
          else if(obs.obsType == "poisson"){
            
              if (p.checkCollision(obs)){
                
                if(obs.isAlive)
                {
                   fishSound1=minim.loadFile("fish1.wav");
                   fishSound1.play();
                   nbFish++;
                   score = nbFish * timer;
                   
                }
  
                obs.isAlive = false;
                
            
              }
  
          }
          else if(obs.obsType == "bonus"){
            
              if (p.checkCollision(obs)){
              
                if(obs.isAlive)
                {
                   fishSound2=minim.loadFile("fish2.wav");
                   fishSound2.play();
                   
                   nbFish++;
                   score = nbFish * timer;
                   
                   timerStartBonus = timer;
                   slowdown = true;
                }
  
                obs.isAlive = false;
            
              }
          }
          if(slowdown){
            
            timerBonus = timer - timerStartBonus;
            
            if (timerBonus >= 5)
            {
              slowdown = false;
              timerBonus = 0;
            }
          
          }
  
          /*println("timerBonus : " + timerBonus);
          
          println("slowdown : " + slowdown);*/
  
      
      if (gameover == true){
        gameOver();
        timerGameOver=millis()/1000;
        }
    }   
  }
}


void keyPressed(){
  
  if(!gameover && !pause){
    
    if (keyCode == RIGHT){
        p.move(25);
         //println("right");
      }else if (keyCode == LEFT){
        p.move(-25);
      }
  }
}

void mousePressed(){
   if ((mouseX > 200 && mouseX < 400) && (mouseY > 350 && mouseY < 550) && startgame == false){
    startgame = true;
    println("start");
    
    fishSound2=minim.loadFile("fish2.wav");
    fishSound2.play();
    
   }else if ((mouseX > 200 && mouseX < 400) && (mouseY > 350 && mouseY < 550) && gameover == true) {
    gameover = false;
    println("reset");
    resetGame();
    
    fishSound2=minim.loadFile("fish2.wav");
    fishSound2.play();
    
   }else if ((mouseX > 520 && mouseX < 580) && (mouseY > 20 && mouseY < 80) && gameover == false && mute == false) {
     mute = true;
     backgroundMusic.mute();
   }else if ((mouseX > 520 && mouseX < 580) && (mouseY > 20 && mouseY < 80) && gameover == false && mute == true) {
     mute = false;
     backgroundMusic.unmute();
   }
   
   if((mouseX > 520 && mouseX < 580) && (mouseY > 90 && mouseY < 150) && !pause){
     pause=true;
     backgroundMusic.pause();
     
   }
   else if((mouseX > 520 && mouseX < 580) && (mouseY > 90 && mouseY < 150) && pause){
     pause=false;
     backgroundMusic.play();
   }
   
}


void gameOver(){
    fill(255,255,255,63);
    rect(0, 0, width, height);
    image(restartButton, 200, 350);
    image(GOtext, 50, 100);
    image(Stext, 70, 700);
    textSize(50);
    fill(0);
    text(score, 300, 768);
    
    backgroundMusic.close();
  }

void resetGame(){
  p = new Penguin(width-penguinW*3.5, height-penguinH*5); 
  nbFish = 0;
  score = 0;

  backgroundMusic=minim.loadFile("PenguinRush.mp3");
  backgroundMusic.shiftGain(backgroundMusic.getGain(),-10,FADE);

  if(mute) {
    backgroundMusic.mute();
  }
  
  int index = 0;
  
  //Road 1
  for (int i=0; i<2; i++){
    y1 = i * 500-1000;
    
    objectAlea = int(random(8));
    
    if(objectAlea == 0 ){
      
      obs[index] = new NeutralFish(50, y1);
    }
    else if(objectAlea == 1){
      
      obs[index] = new NullObject(50, y1);
    }
    else{
      
      obs[index] = new Obstacles(50, y1);
    }
    
    index ++;
  }

  //Road 2
  for (int i=0; i<2; i++){
    y2 = i *500 - 500;
    
    objectAlea = int(random(10));
    
    if(objectAlea == 0){

      obs[index] = new NeutralFish(250, y2);
    }
    else if(objectAlea == 1){
      
      obs[index] = new NullObject(250, y2);
    }
    else{
   
      obs[index] = new Obstacles(250, y2);
    }
    
    index ++;
  }
  
  //Road 3
  for (int i=0; i<2; i++){
    y3 = i * 500 - 1500;
    
    objectAlea = int(random(8));
    
    if(objectAlea == 0){
      
      obs[index] = new NeutralFish(450, y3);
    }
    else if(objectAlea == 1){
      
      obs[index] = new NullObject(450, y3);
    }
    else{
      
      obs[index] = new Obstacles(450, y3);
    }
    
    index ++;
  }
}

void displayScore(){
  
  fill(255,255,255);
  textSize(35);
  text(score,20,60);
      
}


//void serialEvent(Serial port) {
//    String serialStr = port.readStringUntil('\n');    /*on stocke dans une CDC ce qui arrive sur le port série jusqu'au retour à la ligne*/
//    serialStr = trim(serialStr);    /*trim=enleve les espaces*/
  //  int values[] = int(split(serialStr, ','));    /*un split = casse le tableau à chaque fois qu'on tombe sur une virgule, ce qui est à l'intérieur reste des caractères SAUF qu'on a mis int donc ca va etre des entiers héhé*/
  //  if( values.length == 4 ) {
      
//       xvalue = calculate( values[1], 331 ); //333

//    }  /*à la base ct 4 et apres on a mis 3 mais faudra pt modifier. ce if permet d'éviter que le programme plante à cause de la première trame qui est pourrie*/
//}

//int calculate(int returnValue,int baseValue){
//  int diff= returnValue - baseValue;
//  return round(diff/2);
  
//}
