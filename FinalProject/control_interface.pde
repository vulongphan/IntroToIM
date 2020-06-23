/*
Name: Phan Vu Long
 Assignment due date: 24 June 
 Main concept: This is the control interface for the famous movie character "WALL-E".
 The interface comprises of a 2D model of "WALL-E" in the center, 4 direction arrows
 at the bottom right and three signalling boxes (on, off and obstacles) at the top
 right corner. When the robot is turned on, the white ON box will turn blue and "WALL_E"
 voice will be played. When the user presses one of the four arrows, the 2D model will
 move in the respective direction and the color of the respective arrow also changes 
 to demonstrate that an arrow key is pressed. When the robot encounters obstacles, the
 obstacle box will blink. When the robot is turned off, the off box will turn red and
 a sound of machine turning off will be played. At the off state, no command can be 
 given to the control interface
 */

import processing.serial.*; //to read and write on the Serial port
import processing.sound.*; //to play a sound file

Serial port; //declare the Serial port that will be used in this program
int input; 
//I need to use the input as int because Processing for some reason has
//trouble recogizing equal strings

//declare global variables for sound files
SoundFile power_on;
SoundFile walle_voice;
SoundFile power_off;

//declare global variable for the control interface
final int WIDTH  = 1200; //width of the canvas
final int HEIGHT = 800; //height of the canvas
final int model_xpos = WIDTH/3; //x-position of the model
final int model_ypos = HEIGHT/4; // y position of the model
final float back_width = WIDTH/3.5; //width of the back image
final float side_width = WIDTH/4; //width of the side image
final float model_height = HEIGHT/2; //height of the model

//declaration and initialization of an object of type Control_Interface
Control_Interface cit = new Control_Interface(); 

//declare global variables for images
PImage back; //image of the model back view
PImage right; //image of the model right side view
PImage left; //image of the model left side view

void setup() {
  size(1200, 800);
  frameRate(5); 
  //the frameRate has to be this low in order for the changes to be seen on the screen

  //initialize PImage and SoundFile objects
  back = loadImage("walle_back.png");
  right = loadImage("walle_right.png");
  left = loadImage ("walle_left.png");
  power_on = new SoundFile (this, "power_on.wav");
  walle_voice = new SoundFile(this, "walle_voice.mp3");
  power_off = new SoundFile(this, "power_off.wav");

  println(Serial.list()); //print out all available serial ports 

  port = new Serial(this, Serial.list()[1], 38400); 
  //my port is at index 1 in the list of available ports 

  port.bufferUntil('\n'); 
  //only call serialEvent() when the program reads a new line character from the port, 
  //I use a single line character so that serialEvent() is only called when Processing 
  //encounters commands from Arduino
}

class Control_Interface {
  //the state of the robot
  boolean obstacles = false;
  boolean power_on = false;

  //keep the count of the frames starting when the robot is turned on or off in order 
  //to control the on and off sounds (to avoid a sound to be played continuously on top of itself
  int count_on = 0;
  int count_off = 0;

  void up_arrow(int R, int G, int B ) { // the function to give the up_arrow a color 
    fill(R, G, B);
    noStroke();
    triangle(WIDTH * 13.25/15, HEIGHT * 15/20, WIDTH * 13.75/15, HEIGHT * 15/20, WIDTH * 13.5/15, HEIGHT * 14/20);
  }

  void right_arrow(int R, int G, int B) { //the function to give the right arrow a color
    fill(R, G, B);
    noStroke();
    triangle(WIDTH * 14/15, HEIGHT * 15.5/20, WIDTH * 14/15, HEIGHT * 16.5/20, WIDTH * 14.5/15, HEIGHT * 16/20);
  }

  void down_arrow(int R, int G, int B) { //the function to give the down arrow a color 
    fill(R, G, B);
    noStroke();
    triangle(WIDTH * 13.25/15, HEIGHT * 17/20, WIDTH * 13.75/15, HEIGHT * 17/20, WIDTH * 13.5/15, HEIGHT * 18/20);
  }

  void left_arrow(int R, int G, int B) { //the function to give the left arrow a color
    fill(R, G, B);
    noStroke();
    triangle(WIDTH * 13/15, HEIGHT * 15.5/20, WIDTH * 13/15, HEIGHT * 16.5/20, WIDTH * 12.5/15, HEIGHT* 16/20  );
  }

  void move_forward() { 
    //when the robot moves forward, cover the model at the resting state with a rectagle
    //and draw it at the new state 
    fill(0);
    rect(model_xpos, model_ypos, back_width, model_height);
    up_arrow(255, 0, 0); //turns upward arrow from yellow to red
    pushMatrix(); //remember the currrent position of the coordinate system
    translate(model_xpos, model_ypos - HEIGHT/10); //translate the model upwards
    image(back, 0, 0, back_width, model_height); //draw the image at the origin of the coordinate system
    popMatrix(); //move the coordinate system back to its previous position
  }

  void rotate_right() { 
    //when the robot rotates right, cover the model at the resting state
    //with a rectagle and draw it at the new state 
    fill(0);
    rect(model_xpos, model_ypos, back_width, model_height);
    right_arrow(255, 0, 0);
    image (right, model_xpos, model_ypos, side_width, model_height);
  }

  void rotate_left() { 
    //when the robot rotates left, cover the model at the resting state 
    //with a rectangle and draw it at the new state
    fill(0);
    rect(model_xpos, model_ypos, back_width, model_height);
    left_arrow(255, 0, 0);
    image(left, model_xpos, model_ypos, side_width, model_height);
  }

  void move_back() {
    //when the robot moves back, cover the model at the resting state 
    //with a rectangle and draw it at the new state
    fill(0);
    rect(model_xpos, model_ypos, back_width, model_height);
    down_arrow(255, 0, 0);
    pushMatrix();
    translate(model_xpos, model_ypos + HEIGHT/10); //translate the model downwards
    image(back, 0, 0, back_width, model_height); //draw the image at the origin of the coordinate system
    popMatrix();
  }

  void on_signal(int R, int G, int B) { //function to give the on_signal box a color
    fill(255);
    textSize(WIDTH/38);
    textAlign(TOP, RIGHT);
    text("ON", WIDTH*26.8/30, HEIGHT *1.3/20);
    fill(R, G, B);
    rect(WIDTH*28.5/30, HEIGHT *0.5/20, WIDTH * 1/30, HEIGHT * 1/20);
  }

  void off_signal(int R, int G, int B) { //function to give the off signal box a color
    fill(255);
    textSize(WIDTH/39);
    textAlign(TOP, RIGHT);
    text("OFF", WIDTH*26.8/30, HEIGHT *2.75/20);
    fill(R, G, B);
    rect(WIDTH*28.5/30, HEIGHT * 2/20, WIDTH * 1/30, HEIGHT * 1/20);
  }

  void obs_signal(int R, int G, int B ) { //function to give the obs signal box a color
    fill(255);
    textSize(WIDTH/39);
    textAlign(TOP, RIGHT);
    text("OBS", WIDTH*26.8/30, HEIGHT *4.2/20);
    fill(R, G, B);
    rect(WIDTH*28.5/30, HEIGHT * 3.5/20, WIDTH * 1/30, HEIGHT * 1/20);
  }


  void draw_interface() {
    //this function to draw elements of the interface based on the state of the robot
    //defaultly the arrows are yellow
    up_arrow(255, 255, 0);
    right_arrow(255, 255, 0);
    down_arrow(255, 255, 0);
    left_arrow(255, 255, 0);
    image(back, model_xpos, model_ypos, back_width, model_height);
    if (power_on == false) { //if the robot is powered off
      //on signal box is white, off signal box is red and obs_sinal box is white
      on_signal(255, 255, 255);
      off_signal(255, 0, 0);
      obs_signal(255, 255, 255);
    } else { //if the robot is powered on
      //on_signal box is turned on, obs_sinal box is white and off_signal box is white
      on_signal(0, 0, 255);
      obs_signal(255, 255, 255);
      off_signal(255, 255, 255);
      if (obstacles == true) { 
        //if there are obstacles, try the blinking effect (changing between 2 colors: red and yellow)
        if (frameCount % 2 == 1) {
          obs_signal(255, 0, 0); //red
        } else {
          obs_signal(255, 255, 0); //yellow
        }
      }
    }
  }
}


void draw() {
  background(0);
  cit.draw_interface();
}

//try to mimic the Serial port in Arduino by printing out all the information that is written to the port
void serialEvent(Serial port) {
  String inString = port.readStringUntil('\n');
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    input = int(inString);
    if (input == 1) { //if the switch on the robot is turned on
      println(input);
      cit.power_on = true; //change the state of the control interface
      cit.count_off = 1;
      if (cit.count_on == 0) {
        power_on.play();
        delay(500); //delay so that walle voice is not played over the starting sound
        walle_voice.play();
        cit.count_on +=1;
      }
    } else if (input == 0) { //if the switch on the robot is turned off
      println(input);
      //change the state of the robot back to default
      cit.power_on = false;
      cit.obstacles = false;
      cit.count_on = 0;
      if (cit.count_off == 1) { //only play the off sound once 
        power_off.play();
        cit.count_off += 2;
      }
    } else if (input == 2) { //if there are obstacles encountered
      cit.obstacles = true; //change the state of the robot
      println(input);
    } else if (input == 3) { //if there are no obstacles
      cit.obstacles = false; //change back the state of the robot to default
      println(input);
    }
  }
}

//trying to mimic the serial monitor in the process by printing out all the information 
//written to the port
void keyPressed() { //this should only be called when the power is on, power_on = true
  if (cit.power_on == true) {
    if (keyCode == UP) {
      cit.move_forward();
      //write "F" to port
      port.write('F'); //remember to write a single character only to the port
      print('F');
      port.write(' ');
      print(' ');
    } else if (keyCode == RIGHT) {
      cit.rotate_right();
      //write "R" to port
      port.write('R');
      print('R');
      port.write(' ');
      print(' ');
    } else if (keyCode == DOWN) {
      cit.move_back();
      //write "B" to port
      port.write('B');
      print('B');
      port.write(' ');
      print(' ');
    } else if (keyCode == LEFT) {
      cit.rotate_left();
      //write "L" to port
      port.write('L');
      print('L');
      port.write(' ');
      print(' ');
    }
  } else {
    return; //tell the program to pass this condition (to avoid warning)
  }
}
