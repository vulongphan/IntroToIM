/*
Name: Phan Vu Long
Assignment due date: June 7
In this assignment, I intend to re-create a clock with its color representing the time in the day; however, I have not managed to get the color correctly since I only have three basic colors to work with
I also have chance to practice transformation in processing
*/

void setup() {
  size(200, 200);
  background(255);
  smooth();
  //noStroke();
}

void draw() {

  if (frameCount % 1 == 0) { //do something every 1 frames 
    fill(frameCount*2 %255, frameCount*5 %255, 
      frameCount*3 % 255);
    circle(100, 100, 80);
    pushMatrix();
    translate(100, 100);
    rotate(radians(frameCount  % 360));
    line(0, 0, 26, 26);
    line(26, 26, 25, 20);
    line(26, 26, 20, 25);
    popMatrix();

    pushMatrix();
    translate(100, 100);
    rotate(radians(frameCount/12 % 360));
    line(0, 0, 13, 13);
    line(13, 13, 12, 8);
    line(13, 13, 8, 12);
    popMatrix();
  }
}
