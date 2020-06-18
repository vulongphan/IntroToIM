
Main idea of my project: A distance sensoring robot which can be controlled through Processing control interface

Some techical key points:

The robot:

When the sensor senses an object of a minimum distance, the information is written to the Serial port as "S" (Serial.print("S"))

The arduino program continues reading the last byte (Serial.read()). If it is "F", the robot will move forward; if it is "B", the robot will move 
backwards; if it is "R", the robot will rotate to the right; if it is "L", the robot will rotate to the left

The processing program:

The program keeps reading the Serial port and when it reaches "S" (myport.bufferUntil("S")), SerialEvent() is called which signals
a front barrier in the Processing control interface 

When an arrow is pressed, the information (one of the four characters "F", "B", "R", "L") is written to the port (myport.write())

The program will contain the main class Game with member functions such as draw_interface() - to show image of the robot with 
grey barriers in 4 directions and 4 grey arrows in the corner to signify the direction and the state of the robot, robot_move() - to color
one of the four aforementioned arrows and barriers red 

Member boolean attributes such as
forward, backward, right, left, stop (the 'stop' attribute is to signal the red barrier in the forward direction, the other 4 
attributes are there to signal when to show the red direction arrow of the robot) and integer attribute color to change the color
of the barrier and the arrow
