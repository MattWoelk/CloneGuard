PImage a;
int xpos;
int ypos;
int xsp;
int ysp;

void setup(){
  size(800,600);
  a = loadImage("images/1.png");
  xpos = 500;
  ypos = 200;
  xsp = 0;
  ysp = 0;
}

void draw(){
  background(000);
  image(a, xpos,ypos);
  xpos += xsp;
  ypos += ysp;
}

void keyPressed(){
  char k = (char)key;
  switch(k){
  case 'j':
    xsp -= 5;
    break;
  case 'l':
    xsp += 5;
    break;
  default:
    break;
  }
    
}

void keyReleased(){
  char k = (char)key;
  switch(k){
  case 'j':
    xsp += 5;
    break;
  case 'l':
    xsp -= 5;
    break;
  default:
    break;
  }
}
