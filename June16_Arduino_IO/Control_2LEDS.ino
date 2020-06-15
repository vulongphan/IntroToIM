void setup() {
  // put your setup code here, to run once:
  //set up A0, A2 as input pins (to read analog input photoresitor and digital input button)
  //set up pin 2 and pin 8 as output pins (for the two LEDS)
  pinMode(A0, INPUT);
  pinMode(A2, INPUT);
  pinMode(2, OUTPUT);
  pinMode(8, OUTPUT);
  Serial.begin(9600);
  //digitalWrite(8,255);

}

void loop() {
  // put your main code here, to run repeatedly
  digitalWrite(2, HIGH); // in every loop set the voltage at pin 2 to be HIGH = 5V
  
  int switchPosition = digitalRead(A2); //switchPosition holds value LOW or HIGH
  int pot = analogRead(A0); //pot receives value from 0 to 1023

  if (switchPosition == HIGH) { //this means the button is pushed
    //note that input A2 must read at the point before the current enters the resistor to get value of HIGH,
    //otherwise A2 will read a value smaller than HIGH which we dont want because we are controlling the input digitally
    //Serial.println("input to A2 is read and at 5V");
    delay(100);
    analogWrite(2, LOW);
    delay(100);

  }

  pot = map(pot, 0, 1023, 0, 255); //rescale analog reading from A0 
    if (pot<180){ //when we put our finger to cover the photoresistor, the potential read at A0 falls below 180
      //then we make the second led blinking as well
      analogWrite(8,0);
      Serial.println(pot);
      delay(100);
      analogWrite(8, 255);
      Serial.println(pot);
      delay(100);
    }

}
