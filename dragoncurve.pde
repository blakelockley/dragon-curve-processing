//Set of instructions for the line to "turn" left ("L") or right ("R").
//Declared with an inital value of "right", but is further created in setup().
String turns = "R";

//Animation - how far into drawing the curve, for each frame of animation.
int a = 0;

void setup() {
 
  size(550, 400);
  frameRate(250);
  
  colorMode(HSB, 100); //Range of hue set to 100.
  background(0, 0, 0); //Set background to black.
  
  //For loop, thats creates 11 interations of the Dragon Curve.
  for (int count = 0; count < 11; count++) {
  
  String pre = turns.substring(0, turns.length()); //Copy
  String halfA = pre.substring(0, pre.length() /2);
  String halfB = pre.substring(pre.length() /2 + 1, pre.length());
  pre = halfA + "L" + halfB; //Changes middle instruction of previous interation to "left".
  
  turns += "R" + pre; //Appends "right" plus altered previous interation.
  } 
}

void draw() { //Draw loop is called to update each frame.
 
  background(0, 0, 0); //Reset contents to just black background.
  
  //Move animation position, one further.
  if (a < turns.length()){
    a++;
  }
  
  //Starting point
  int x1 = 400;
  int y1 = 150;

  //Ending point (of first tiny line)
  int x2 = 405;
  int y2 = 150;

  //Direction
  int d = 1;
  // 0: Up, 1: Right, 2: Down, 3: Left
  // Turning right: d++, Turning left: d--

  //Colour
  int count= 0; //This is so hue is eenevly spread.
  int hue = 0;
  
  //Draws the fractal up to the animation position
  for(int i = 0; i < a; i++) {
    
    char c = turns.charAt(i); //Reads instructions from "turns". 
    
    //Depending on the instruction chanegs direction accordingly (refer to direction declartion).
    if (c == 'R') { 
      d = (d + 1) % 4; //Modulo operator, d can only ever be 0, 1, 2 or 3.
    } else if (c == 'L') {
      d = ((d - 1) < 0) ? 3 : d - 1; //Ternary conditional operator, same reason as above.
    }
  
    //Moves start point of next line to end point of previous line.
    x1 = x2;
    y1 = y2;
  
    //Depending on the direction of the next line moves ends points accordingly.
    //All lines are 5px long.
    switch (d) {
    
      case 0: //Up
      y2 -= 5;
      break;
    
      case 1: //Right
      x2 += 5;
      break;
    
      case 2: //Down
      y2 += 5;
      break;
    
      case 3: //Left
      x2 -= 5;
      break;
  
    }
  
    //Spreads hue evenly over entire curve.
    if (++count == turns.length()/100) {
    
      count = 0;
      hue++;
    }
  
    stroke(hue, 50, 100); //Sets colour of line to hue value.
    line(x1, y1, x2, y2); //Draws the line
  }
}