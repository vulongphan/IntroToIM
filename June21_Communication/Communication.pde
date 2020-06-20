/*
 Name: Phan Vu Long
 Due date: 21 June
 Adapted from http://www.openprocessing.org/sketch/48960
 The program is an attempt to utilize the communication between Arduino and Processing in order to create a new way of playing a game which I created before
 */



import processing.serial.*;
Serial port;

float input;

//Declare global variables
int WIDTH = 400;
int HEIGHT = 400;
int C_XSPEED = 2; //x-coordinate increment of the ball
int C_YSPEED = 3; //y-coordinate increment of the ball
int CIRCLESIZE = 15; //size of the ball
int B_XSPEED = 30; // x-cordinate increment of the bar 
int B_WIDTH = 100; //width of the bar
int B_HEIGHT = 20; //height of the bar

void setup() {
  size(400, 400); 
  smooth();
  frameRate(50);
  
  port = new Serial(this, Serial.list()[1], 9600);
  
  port.bufferUntil('\n'); //only call serialEvent() when the program reads a single line character from the port
}

class MovingCircle { //the class whose objects represent the ball
  float x, y, xSpeed, ySpeed; // atttibutes of the ball
  
  MovingCircle(float xpos, float ypos) {//Constructor declaration
    x = xpos;
    y = ypos;
    xSpeed = C_XSPEED;
    ySpeed = C_YSPEED;
  }

  void update() { //function that makes the ball moves
    x += xSpeed;
    y += ySpeed;
  }

  void checkCollisions() { //function that checks for the collision of the ball with the wall
    float r = CIRCLESIZE/2;
    if ( (x<r) || (x>width-r)) {
      xSpeed = -xSpeed;
    }
    if (y<r) {
      ySpeed = -ySpeed;
    }
  }

  void drawCircle() { //function to draw the ball
    fill(255);
    ellipse(x, y, CIRCLESIZE, CIRCLESIZE);
  }
} // End of the MovingCircle class


class Bar { //class whose objects represent a bar in the game
  float x, y, bar_w, bar_h;
  Bar(float y_pos, float w, float h) {
    x = input; 
    y = y_pos;
    bar_w = w;
    bar_h = h;
  }
  
  void update(){ //update the new x_postion of the Bar
    x = input;
  }
  void drawBar() { // to draw the bar
    rect(x, y, bar_w, bar_h, 7);
    println(x);
  }
}

MovingCircle myCircle = new MovingCircle(25, 72); //creating a ball
Bar myBar = new Bar(380, B_WIDTH, B_HEIGHT); //creating a bar
boolean lose = false; // the idea of using state machine
int score = 0; //declare the score

void draw() {
  // Always erase the screen first
  if (lose == false) { //if the game has not ended yet
    background(0);
    // update the position of the circle
    myCircle.update();
    // check for collisions with the walls
    myCircle.checkCollisions();
    // and finally draw the circle
    myCircle.drawCircle();

    myBar.update();
    myBar.drawBar();
    if (myCircle.x<myBar.x+myBar.bar_w+CIRCLESIZE/2 && myCircle.x>myBar.x-CIRCLESIZE/2 && myCircle.y>myBar.y-CIRCLESIZE/2) { //check if the ball hits the bar
      score+=1; //increment the score by 1
      myCircle.xSpeed = round(random(1,4));
      //myCircle.ySpeed = round (4-myCircle.xSpeed);
      myCircle.xSpeed = -myCircle.xSpeed;
      myCircle.ySpeed = -myCircle.ySpeed;
    }
      
     if (myCircle.y> width-CIRCLESIZE/2) { //if the ball passes the bottom boundary of the screen then the game ends, change the state of the game (the state machine concept)
          lose = true;
     } 
     
     //Shows score
     fill(255);
     textSize(11);
     textAlign(TOP,RIGHT);
     text("Score:"+str(score),width -50 ,20);
    }
    else { //if the game ended (state machine changes: lose = true)
          background(150);
          textSize(11);
          textAlign(CENTER,TOP);
          text("Gameover", 200, 150);
          text("Score:" + str(score), 200,200); 
        }
        
}

void serialEvent(Serial port){
  String inString = port.readStringUntil('\n');
  if (inString != null){
    inString = trim(inString);
    input = float(inString);
    input = map(input, 0,1023, 0, WIDTH-B_WIDTH); //map the input number to the appropriate range which is the x coordinate of the bar
}

}
