/*
  Reference from https://github.com/sparkfun/SIK-Guide-Code (moter hookup)
  Name: Phan Vu Long
  Assignemt due date: 24 June
  Main concept: this program is to control 2 motors, 2 LEDS a buzzer, a distance sensor and a INPUT_PULLUP
  motor through Arduino.
  The robot can move in 4 directions (forward, backward, rotating left and right) based
  on the commands given by users through Processing. When the distance from the sensor to the obstacle
  is smaller than the given minimum distance, the motor will stop and the buzzer will play an alarm sound
*/

//echo and trigg pins for the sensor
const int trigPin = 6;
const int echoPin = 5;

//variable to store the distance measured by the distance sensor
float dist_sens = 0;

//pin for two blinking LEDs
const int ledPin = 3;

//pin for buzzer
const int buzzerPin = 2;

//the right motor will be controlled by the motor A pins on the motor driver
const int AIN1 = 13; //control pin 1 on the motor driver for the right motor
const int AIN2 = 12; //control pin 2 on the motor driver for the right motor
const int PWMA = 11; //speed control pin on the motor driver for the right motor

//the left motor will be controlled by the motor B pins on the motor driver
const int PWMB = 10; //speed control pin on the motor driver for the left motor
const int BIN2 = 9; //control pin 2 on the motor driver for the left motor
const int BIN1 = 8; //control pin 1 on the motor driver for the left motor

int switchPin = 7; //switch to turn the robot on and off

const int driveTime = 20;
//this is the number of milliseconds that it takes the robot to drive 1 inch
//it is set so that if you tell the robot to drive forward 25 units, the robot drives about 25 inches

const int turnTime = 8;
//this is the number of milliseconds that it takes to turn the robot 1 degree
//it is set so that if you tell the robot to turn right 90 units, the robot turns about 90 degrees

//the minimum distance from the obstacle to the sensor in order for the obstacle to be detected
const int min_dist = 12;

String dir; //direction that robot moves

int dist_move = 1; //this is the amount of units that the robot will move when it receives one forward
//or backward command from the user (1 inch) and 1 degree of turning
/********************************************************************************/
void setup()
{
  pinMode(switchPin, INPUT_PULLUP);   //set this as a pullup to sense whether the switch is flipped

  pinMode(ledPin, OUTPUT);

  //set the motor control pins as outputs
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  pinMode(PWMA, OUTPUT);

  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);
  pinMode(PWMB, OUTPUT);

  //set the trig and echo pins as output and input for the sensor
  //at first I forgot to declare the trigPin and echoPin as OUTPUT and INPUT respectively
  //and this is the reason why pulseIn() returns 0 since there is no pulse is sent (both pins are defaultly used as INPUT)
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  Serial.begin(38400);  //begin serial communication with the computer
}

/********************************************************************************/
void loop()
{

  if (digitalRead(switchPin) == LOW)
  { //if the switch is in the ON position
    Serial.println("1");

    //turn on 2 LEDS
    digitalWrite(ledPin, HIGH);

    //check for the distance
    dist_sens = getDistance();
    if (dist_sens < min_dist ) { //if an object is detected
      //write to port
      Serial.println("2");

      //play the alarm
      tone(buzzerPin, 1200, 250);
      tone(buzzerPin, 800, 250);

      //blinking 2 LEDS
      delay(100);
      digitalWrite(ledPin, LOW);
      //delay(100);

      //stop for a moment
      rightMotor(0);
      leftMotor(0);
      delay(200);

    }
    else { //if no obstacle in radius 10 units
      Serial.println("3");
    }

    //check for directions
    dir = Serial.readStringUntil(' ');
    //read until the program encounters a white space which is a command sent from Processing

    if (dir == "F")  //if the entered direction is forward
    {
      rightMotor(200);   //drive the right wheel forward
      leftMotor(200);    //drive the left wheel forward
      delay(driveTime * dist_move * 50); //drive the motors long enough travel 50 unit distance
      rightMotor(0);    //turn the right motor off
      leftMotor(0);     //turn the left motor off
    }
    else if (dir == "B") //if the entered direction is backward
    {
      rightMotor(-200);  //drive the right wheel backward
      leftMotor(-200);   //drive the left wheel backward
      delay(driveTime * dist_move * 50);   //drive the motors long enough travel 50 unit distance
      rightMotor(0);   //turn the right motor off
      leftMotor(0);    //turn the left motor off
    }
    else if (dir == "R") //if the entered direction is right
    {
      rightMotor(-200);  //drive the right wheel backward
      leftMotor(255);    //drive the left wheel forward
      delay(turnTime * dist_move * 60); //drive the motors long enough to turn 60 degrees
      rightMotor(0);   //turn the right motor off
      leftMotor(0);    //turn the left motor off
    }
    else if (dir == "L")  //if the entered direction is left
    {
      rightMotor(255);    //drive the right wheel forward
      leftMotor(-200);   //drive the left wheel backward
      delay(turnTime * dist_move * 60 );//drive the motors long enough to turn 60 degress
      rightMotor(0); //turn the right motor off
      leftMotor(0); //turn the left motor off
    }

  }
  else // if the switch is turned off
  {
    rightMotor(0); //turn the right motor off
    leftMotor(0); //turn the left motor off
    digitalWrite(ledPin, LOW);
    Serial.println("0");
  }
}
/********************************************************************************/
void rightMotor(int motorSpeed)   //function for driving the right motor
{
  if (motorSpeed > 0) //if the motor should drive forward (positive speed)
  {
    digitalWrite(AIN1, HIGH);   //set pin 1 to high
    digitalWrite(AIN2, LOW);   //set pin 2 to low
  }
  else if (motorSpeed < 0)   //if the motor should drive backward (negative speed)
  {
    digitalWrite(AIN1, LOW);   //set pin 1 to low
    digitalWrite(AIN2, HIGH); //set pin 2 to high
  }
  else      //if the motor should stop
  {
    digitalWrite(AIN1, LOW);  //set pin 1 to low
    digitalWrite(AIN2, LOW);  //set pin 2 to low
  }
  analogWrite(PWMA, abs(motorSpeed));  //now that the motor direction is set, drive it at the entered speed
}

/********************************************************************************/
void leftMotor(int motorSpeed)  //function for driving the left motor
{
  if (motorSpeed > 0)  //if the motor should drive forward (positive speed)
  {
    digitalWrite(BIN1, HIGH); //set pin 1 to high
    digitalWrite(BIN2, LOW);  //set pin 2 to low
  }
  else if (motorSpeed < 0)  //if the motor should drive backward (negative speed)
  {
    digitalWrite(BIN1, LOW); //set pin 1 to low
    digitalWrite(BIN2, HIGH); //set pin 2 to high
  }
  else  //if the motor should stop
  {
    digitalWrite(BIN1, LOW);  //set pin 1 to low
    digitalWrite(BIN2, LOW);  //set pin 2 to low
  }
  analogWrite(PWMB, abs(motorSpeed));   //now that the motor direction is set, drive it at the entered speed
}

/********************************************************************************/
//RETURNS THE DISTANCE MEASURED BY THE HC-SR04 DISTANCE SENSOR
float getDistance()
{
  float echoTime;   //variable to store the time it takes for a ping to bounce off an object
  float calculatedDistance;  //variable to store the distance calculated from the echo time


  //send out an ultrasonic pulse that's 10ms long
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  echoTime = pulseIn(echoPin, HIGH);      //use the pulsein command to see how long it takes for the
  //pulse to bounce back to the sensor
  //calculate the distance of the object that reflected the pulse (half the bounce time multiplied by the speed of sound)
  calculatedDistance = echoTime / 148.0;

  return calculatedDistance;      //send back the distance that was calculated
}
