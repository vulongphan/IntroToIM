/*
  This project is modified from https://github.com/sparkfun/SIK-Guide-Code (3 buttons trumpet)
*/

//set the pins for the button and buzzer
int firstKeyPin = 5;
int secondKeyPin = 4;
int thirdKeyPin = 3;
int fourthKeyPin = 2;

int buzzerPin = 10;


void setup() {
  //set the button pins as inputs (to read whether the button is pressed or not, if it is then digitalRead of the Pin will give value LOW, and HIGH otherwise
  pinMode(firstKeyPin, INPUT_PULLUP);
  pinMode(secondKeyPin, INPUT_PULLUP);
  pinMode(thirdKeyPin, INPUT_PULLUP);
  pinMode(fourthKeyPin, INPUT_PULLUP);

  //set the buzzer pin as an output
  pinMode(buzzerPin, OUTPUT);
}

void loop() {

  if (digitalRead(firstKeyPin) == LOW) { //if the first key is pressed
    if (digitalRead(secondKeyPin) == HIGH && digitalRead(fourthKeyPin) == HIGH){ // if the second key and fourth keys are not pressed
      tone(buzzerPin, 440); //play A
      } 
    else{ //if the second key is pressed
      tone(buzzerPin, 494); //play B
      }
   }
  
  else if (digitalRead(secondKeyPin) == LOW) { //if the second key is pressed
    if (digitalRead(thirdKeyPin) == HIGH){ //if the third key is not pressed
      tone(buzzerPin, 523); //play the frequency for C
      }
    else { //if the third key pressed
      tone(buzzerPin, 587); //play D
      }
  }
  else if (digitalRead(thirdKeyPin) == LOW) { //if the third key is pressed
    if (digitalRead(fourthKeyPin) == HIGH) { //if the fourth key is not pressed
      tone(buzzerPin, 660); //play E
      }
    else {
      tone(buzzerPin, 699); //play F
      }
   }
  else if (digitalRead(fourthKeyPin) == LOW){ //if the fourth key is pressed
    if (digitalRead (firstKeyPin) == HIGH){
      tone (buzzerPin, 784); //play G
    }
    else{
      tone(buzzerPin, 880); // Play higher A
      }
    }
  else{
    noTone(buzzerPin);                        //if no key is pressed turn the buzzer off    
    }
}

/*
  note  frequency
  c     262 Hz
  d     294 Hz
  e     330 Hz
  f     349 Hz
  g     392 Hz
  a     440 Hz
  b     494 Hz
  C     523 Hz
*/
