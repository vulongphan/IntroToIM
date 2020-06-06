/*
Name: Phan Vu Long 
Assignment due date: 7 June
My chart shows the number of deaths by COVID-19 in the UAE daily in May 2019
The number of daily cases is represented by a vertical line
Red lines signifies that the number of cases increases compared to the previous day
Blue lines signifies that the number of cases stays the same or decreases compared to the previous case
I manually input data from source https://www.worldometers.info/coronavirus/country/united-arab-emirates/ to my data.csv file which is in the same file directory as this pde file
*/

int data[];
int scaling_factor = 30;
int x_origin = 5; //x_coordinate of the origin
int y_origin = 470; //y_coordinate of the origin
void setup() {
  size(500, 500);

  //load data into an array
  String o_file[] = loadStrings("data.csv");

  //since the the file only has 1 line so the array only has 1 element
  //load data into an integer array
  data = int (split(o_file[0], ','));

  //Check the input data
  //printArray(data);
}

void draw() {
  int d = width/data.length; //distance between each vertical line 
  stroke(0);
  line(x_origin, y_origin, x_origin, height-y_origin); //vertical y_axis
  line (x_origin, y_origin, width, y_origin); //horizotal x-axis

  for (int i = 0; i < data.length; i++) {
    if (i > 0 && data[i]>data[i-1]) {
      stroke(255, 0, 0);
      line((i+1)*d, y_origin, (i+1)*d, height-data[i]*scaling_factor);
    } 
    else {
      stroke(0, 0, 255);
      line((i+1)*d, y_origin, (i+1)*d, height-data[i]*scaling_factor);
    }
    text(str(data[i]),(i+1)*d-5, height-data[i]*scaling_factor);
    text("Death Cases by COVID_19 in the UAE", 8, 25);
    text("May 2020", width/2-30, 490);
  }
}
