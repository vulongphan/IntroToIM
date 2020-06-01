//DRAWING DOUBLE ARCHIMEDIAN SPIRAL

float r = 0;
float theta_1 = 0; // inital theta angle for the first spiral
float theta_2 = radians(180); //initial theta angle for the second spiral 
float theta_incre = 0.01; //increment for theta
float r_incre = 0.1; //increment for radius

void setup(){
  size (500,500);
  background (255);
  frameRate(480);
}

  

void draw(){
  //Calculate the x,y coordinate for each spiral
  float x_1 = r * cos (theta_1);
  float y_1 = r * sin (theta_1);
  float x_2 = r * cos (theta_2);
  float y_2 = r * sin (theta_2);
  
  noStroke();
  fill(0);
  
  //Draw the first spiral using filled ellipse
  ellipse(x_1+width/2, y_1 + height/2, 16 ,16);
  
  //Draw the second spiral using filled ellipse
  ellipse(x_2+width/2, y_2 + height/2, 16 ,16);

  //Increment the theta angle for each spiral
  theta_1 += theta_incre;
  theta_2 += theta_incre;
  
  //Increment the radius of both spirals
  r+=r_incre;
  
  //if the spiral is large enough, reset the process
  if (r>=width/2){
    background(255);
    r = 0;
    theta_1 = 0;
    theta_2 = radians(180);
  }
}

  
  
