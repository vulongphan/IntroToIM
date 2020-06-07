import java.util.Random;

int board_h = 3;
int board_w = 3;
int tile_size = 200;
//boolean show = false;

//PImage tile = loadImage();


//randomize the position of the bomb
Random random = new Random();
int x_bomb = (random.nextInt(board_w))*(tile_size);
int y_bomb = (random.nextInt(board_h))*(tile_size);

class Tile {
  int x, y;
  boolean on_tile = false;
  boolean show = true;
  //PImage image = loadImage();
  Tile(int x_pos, int y_pos) {
    x = x_pos;
    y = y_pos;
  }
  void check_mouse() {//check if the mouse is pointing to the tile
    if (mouseX >=x && mouseX <= x + tile_size && mouseY >= y && mouseY <= y + tile_size) {
      on_tile = true;
      println("Mouse is pointing to this tile");
    } else {
      on_tile = false;
    }
  }
  void show() {
    rect(x, y, tile_size, tile_size);
  }
}

Tile[][] array = new Tile[board_w][board_h];
PImage bomb;

void setup() {
  size(600, 600);
  bomb = loadImage("/Users/vulongphan/Desktop/Intro IM Summer Course/Assignments/my_bomb_game/bomb.png"); //remember to load image inside the setup() function

  for (int r = 0; r<board_w; r++) { //populate the array
    for (int c = 0; c < board_h; c++) {
      array[r][c] = new Tile(c*200, r*200);
    }
  }
}


void draw() {
  image(bomb, x_bomb, y_bomb, tile_size, tile_size); //show the bomb
  for (int r = 0; r<board_w; r++) { //populate the tiles to cover the board
    for (int c = 0; c < board_h; c++) {
      if (array[r][c].show == true) {
        array[r][c].show();
        array[r][c].check_mouse();
      }
    }
  }
  //println(x_bomb);
  //println(y_bomb);
}

void mousePressed() {
  for (int r = 0; r<board_w; r++) { //check which Tile the mouse clicks on, then do not show it
    for (int c = 0; r < board_h; r++) {
      if (array[r][c].on_tile == true) {
        array[r][c].show = false;
        println("Mouse clicked on this tile");
      }
    }
  }
}
