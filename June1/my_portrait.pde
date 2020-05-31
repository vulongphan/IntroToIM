size(200,200);

//sideface
line(width*9/20,height*5/20, width*9/20, height*7/20);
line(width*11/20,height*5/20,width*11/20, height * 7/20);

//chin
line(width*9/20,height*7/20, width/2, height*7.5/20);
line(width/2, height*7.5/20, width*11/20, height *7/20);

//hair
fill(0,0,255);
triangle(width*9/20,height*5/20, width/2, height*5/20, width*9.5/20, height*4.5/20);
triangle(width/2, height*5/20, width*11/20,height*5/20, width*10.5/20, height*4.5/20);

//eyes
line(width*9.3/20, height*5.7/20, width*9.7/20, height*5.7/20);
line(width*10.3/20, height*5.7/20, width*10.7/20, height*5.7/20);

//nose
line(width/2, height *6/20, width/2, height*6.5/20);

//mouth
noFill();
arc(width/2, height*6.8/20, width/30, height/40, 0, radians(180));

//neck
line(width/2, height*7.5/20, width/2, height*8/20);

//body
triangle(width*7.5/20, height*8/20, width/2, height*13/20, width*12.5/20, height*8/20);

//legs
line(width/2, height*13/20, width*9/20, height*18/20);
line(width/2, height*13/20, width*11/20, height*18/20);

//arms
arc(width*7.5/20,height/2,width/20,height/5,radians(90), radians(270));
arc(width*12.5/20,height/2,width/20,height/5,radians(-90), radians(90));





