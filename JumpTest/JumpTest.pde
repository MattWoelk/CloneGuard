//THIS IS PERFECT
boolean keypress;
int a, x, y, v;
int ACCEL;

void setup(){
  size(600,400);

  ACCEL = 1;
  a = 0;
  v = 0;
  x = 100;
  y = 300;
  keypress = false;
}

void draw(){
  background(000);
  drawSprite(x,y);

  v += a;

  if(y + v <= 300){ //if (floor collision if we move)
    y += v;
  }else{
    y = 300; //stand on floor
    a = 0;
  }
}

void drawSprite(int x, int y){
  rect(x,y,20,20);
}

void keyPressed(){
  char k = (char)key;
  switch(k){
  case 'z':
    if(a == 0){
      System.out.println("z press acknowledged");
      a = ACCEL;
      v = -20;
    }
    keypress = true;
    break;
  }
}

void keyReleased(){
  char k = (char)key;
  switch(k){
    case'z':
      keypress = false;
      if(v <= -5){ //set these to zero to have a completely immediate response
        v = -5; //a velocity that still gives a little bit of arc
      }
      System.out.println("z released");
      break;
  }
}
