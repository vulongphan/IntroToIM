/*
Name: Phan Vu Long
 Assignment due date: June 10
 This project models after a simple computer game in which the player has to 'dig up' each tile on the screen one by one and can only win when all tiles have been uncovered except for the one with the bomb, otherwise the player loses
 I first have to create a class Tile and put them in a 2D array and later on draw each them on the screen. Then I have to check which tile the mouse clicks on in order to uncover the tile. 
 I also have to check when the player clicks on the tile with the bomb then the game ends
 */


import java.util.Random; //use Random module to create random x and y coordinates of the bomb
import processing.sound.*; //use the Sound library to play sounds


//Global variable declarations and initializations
int board_h = 4; //height of the board is 4 times the side of the tile
int board_w = 4; //width of the board is 4 times the side of the tile
int tile_size = 150; //note that width and height of the screen equals board_h (or board_h) multiplied by tile_size

Tile[][] array = new Tile[board_w][board_h]; //allocate an array of Tile objects
boolean lose = false; //boolean variale to store the state of the game (if the player has lost or the bomb is found)
int count = 0;//if the count = board_h * board_h, this means all tiles have been uncovered except the one with the bomb - the player wins

//Images
PImage bomb; 
PImage digging_img;
PImage tile_image;
PImage shovel_img;

// x,y coordinates of the bomb
int x_bomb;
int y_bomb;

//SoundFile objects to play sounds
SoundFile digging_sound;
SoundFile explosion_sound;

class Tile {
  int x, y; //x,y coordinate
  boolean on_tile = false; //if the mouse is pointing to the tile
  boolean show = true; //if the tile is being shown
  boolean play_sound = true; //if the sound should be playing 
  PImage tile = tile_image;
  PImage digging =digging_img;
  SoundFile digging$ = digging_sound;
  SoundFile explosion = explosion_sound;
  Tile(int x_pos, int y_pos) { //Constructor
    x = x_pos;
    y = y_pos;
  }
  void check_mouse() {//check if the mouse is pointing to the tile
    if (mouseX >=x && mouseX <= x + tile_size && mouseY >= y && mouseY <= y + tile_size) {
      on_tile = true;
    } else {
      on_tile = false;
    }
  }
  void show() {//showing the tile
    tile.resize(tile_size, tile_size);
    image(tile, x, y, tile_size, tile_size);
  }
  void tile_picked() { //showing the shovel if the tile is picked
    image(digging, x, y, tile_size, tile_size);
  }
}

void you_win() { //showing the winning screen
  background(150);
  fill(0);
  textSize(22);
  textAlign(CENTER, TOP);
  text ("YOU WIN !", width/2, height/2);
}

void you_lose() { //showing losing screen
  delay(800);
  background(150);
  fill(0);
  textSize(22);
  textAlign(CENTER, TOP);
  text ("YOU LOSE !", width/2, height/2);
}


void setup() { 
  frameRate(20);
  size(600, 600);
  frameRate(400);
  //Load images and sound files
  tile_image = loadImage("brick-tile.jpg");
  digging_img = loadImage("gold_mine.png");
  shovel_img = loadImage("shovel.png");
  digging_sound = new SoundFile(this, "digging.wav");
  explosion_sound = new SoundFile (this, "explosion.wav");
  bomb = loadImage("bomb.png");

  //Randomize the position of the bomb
  Random random = new Random();
  x_bomb = (random.nextInt(board_w))*(width/board_w);
  y_bomb = (random.nextInt(board_h))*(width/board_h);


  for (int r = 0; r<board_w; r++) { //populate the array
    for (int c = 0; c < board_h; c++) {
      array[r][c] = new Tile(c*width/board_w, r*height/board_h);
    }
  }
}

void draw() {
  if (lose == false) {
    if (count <= board_h*board_w-1 ) {
      for (int r = 0; r<board_w; r++) { //populate the tiles to cover the board
        for (int c = 0; c < board_h; c++) {
          if (array[r][c].show == true) { //if the tile has not been clicked on yet then keep showing the tile and checking if the mouse is on the tile
            array[r][c].show();
            array[r][c].check_mouse();
          } else { //if the "show" attribute of the tile is false, this means the tile has been picked
            if (array[r][c].play_sound == true ) { //if the sound should be played
              array[r][c].digging$.play();
              array[r][c].play_sound = false; //after this iteration, the sound should not be played again
              delay(800);
            }
            if (array[r][c].x == x_bomb && array[r][c].y == y_bomb) { // if the tile is clicked on and if it is the position of the bomb
              image(bomb, x_bomb, y_bomb, tile_size, tile_size); //show the bomb
              array[r][c].explosion.play(); 
              lose = true;
            } else { //if the tile is clicked on and the bomb is not there
              array[r][c].tile_picked();
            }
          }
        }
      }
      image(shovel_img, mouseX-35, mouseY-55, 60, 60);
    }
    if (count == board_h*board_w -1) { //winning condition
      delay(800);
      you_win();
      lose = true;
    }
  } else { //losing condition
    you_lose();
  }
}

void mousePressed() {//call back function when the mouse is pressed
  for (int r = 0; r<board_w; r++) { //check which Tile the mouse clicks on using nested for loop
    for (int c = 0; c < board_h; c++) {
      if (array[r][c].on_tile == true) {
        if (array[r][c].show == true) {
          count +=1; //increment the number of mouse clicks on the chosen tiles
        }
        array[r][c].show = false;
      }
    }
  }
}
