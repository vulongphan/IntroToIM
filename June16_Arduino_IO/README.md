## Introduction of my project

In this project, I attempted to use digital and analog inputs inorder to control digital and analog outputs. Two digital and analogs inputs
are the switch and the photoresistor respectively. The input read from the switch (that it is either on or off) is then used to control
the state of the first LED (whether it blinks or stays bright). The input read from the photoresistor is also used to control the blinking
state of the second LED (if I use my hand to cover the photoresistor then the LED will start blinking, otherwise it stays bright).

## Circuit schematics and photograph of my project

Following is my circuit schematics

![](circuit_schematic.png)

Following is a photograph of my project

![](control_2LEDS.png)

## Challenges

One of the challenges was to decide which is the correct position in the circuit to read the input from. For example, I use my A0 pin
to read the voltage provided in the beginning (which is 5V). The correct position to read 5V is the point between the switch and 
the 10 kiloOhm resistor. I chose a point between the resistor and the LED at first and pin A2 read a lower number than 5V. 

Another challenge was to fully understand the funtionality of the button. Now I know that the button only works for diagonal legs 
and do not work for horizontally_aligned legs.
