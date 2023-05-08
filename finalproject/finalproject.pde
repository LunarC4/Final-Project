import processing.sound.*;
import processing.serial.*;

Serial myPort;
SoundFile file;

Upbeat Up;
Downbeat Down;
Leftbeat Left;
Rightbeat Right;

int x;
int y;
int b;

PImage Leek;
PImage Hats;
PImage Confetti;

String portName;
String val;

void setup() {
  frameRate(60);
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');

  file = new SoundFile(this, "Miku.wav");
  
  Leek = loadImage("leeku.png");
  Hats = loadImage("mikudayo.png");
  Confetti = loadImage("confetti.gif");

  size(900, 900);
  background(#4287f5);

  Up = new Upbeat();
  Down = new Downbeat();
  Left = new Leftbeat();
  Right = new Rightbeat();
  
  file.play();
  file.amp(0.5);
  
  textSize(28);
  fill(255);
}

void draw() {
  //refreshes to keep cursor from clogging up space
  background(#4287f5);
  fill(255);
  text("Welcome to Miku Simulator!\nUse the joystick to move.\nHit the sides to create a dance party.\nPress down to release confetti.\nHave fun! There is no wrong way to play.", 150, 200);
  fill(#4287f5);
  Up.drawing();
  Down.drawing();
  Left.drawing();
  Right.drawing();
 
   //cursor:
  image(Leek, x/1.3, y/1.3);
  
  //changing panels to be colorful/dancing when joystick moves
  if (Integer.valueOf(y) <= 110) {
    fill(#e858bf);
    Up.drawing();
  }
  if (Integer.valueOf(y) >= 913) {
    fill(#9b42f5);
    Down.drawing();
  }
  if (Integer.valueOf(x) <= 110) {
    fill(#42f545);
    Left.drawing();
  }
  if (Integer.valueOf(x) >= 913) {
    fill(#f5d442);
    Right.drawing();
  }
  //confetti when joystick pressed
  if (b == 1) {
    image(Confetti, x/2, y/2);
  }
  
  //ends the visuals
  if (frameCount >= 3600) {
    background(#4287f5);
    image(Hats, 150, 250);
    fill(255);
    text("Miku is pleased with your dance moves!", 220, 200);
  }
}

void serialEvent(Serial myPort) {
  val = myPort.readStringUntil('\n');
  if (val != null) {
    val = trim(val);
    int[] vals = int(splitTokens(val, ","));
    x = vals[0];
    y = vals[1];
    b = vals[2];
  }
}
