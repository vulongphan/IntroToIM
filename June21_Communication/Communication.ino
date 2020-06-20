int const INPUT_PIN = A0; //the input pin to measure the voltage at the potentiometer
void setup() {
  // put your setup code here, to run once:
  pinMode(A0, INPUT);
  Serial.begin(9600); //initiate the communication at 9600 bits

}

void loop() {
  // put your main code here, to run repeatedly:
  int vol = analogRead(A0); //read the voltage at A0 
  Serial.println(vol);
  delay(2); //stablize the ADC after the last reading
}
