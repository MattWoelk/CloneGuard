PImage a;
int xpos;
int ypos;
int xsp;
Shot shots[];
int shotcount;
int maxshots;

boolean jumping;
int jumpvelocity; //the starting speed of the jump
double jumpspeed; //the current speed of vertical movement

boolean keys[]; //I'd love to use hashes instead.

Level level;

void setup(){
  size(600,400);
  a = loadImage("images/1.png");
  xpos = 500;
  ypos = 200;
  xsp = 0;

  keys = new boolean[4];
  for(int i = 0; i < 4; i++){
    keys[i] = false;
  }
  
  maxshots = 30;
  shots = new Shot[maxshots];
  shotcount = 0;
  for(int i = 0; i < maxshots; i++){
    shots[i] = new Shot();
  }
  
  jumping = false;
  jumpvelocity = -10;
  jumpspeed = 0;
  
  level = new Level(0);
}

void draw(){
  background(000);

  level.paint();
  
  if(jumping)
    jumpspeed += 0.5;
  if(ypos + jumpspeed > height - 100){
    ypos = height - 100;
    jumpspeed = 0;
    jumping = false;
  }
  ypos += jumpspeed;
  
  image(a, xpos,ypos);
  if(keys[0] || keys[1])
    xpos += xsp;
  for(int i = 0; i < maxshots; i++){
    shots[i].paint();
  }
}

void keyPressed(){
  char k = (char)key;
  switch(k){
  case 'j':
    if(!keys[0])
      xsp -= 5;
    keys[0] = true;
    break;
  case 'l':
    if(!keys[1])
      xsp += 5;
    keys[1] = true;
    break;
  case 'x':
    if(!keys[2])
      keys[2] = true;
    shoot();
    break;
  case 'z':
    if(!keys[3]){
      //jumping = true;
      jump();
    }
    keys[3] = true;
    break;
  default:
    break;
  }
}

void keyReleased(){
  char k = (char)key;
  switch(k){
  case 'j':
    if(keys[0])
      xsp += 5;
    keys[0] = false;
    break;
  case 'l':
    if(keys[1])
      xsp -= 5;
    keys[1] = false;
    break;
  case 'z':
    if(keys[3])
      //jumping = false;
    keys[3] = false;
    break;
  default:
    break;
  }
}

void shoot(){
  shots[shotcount].set(xpos - 15,ypos + 30,true);
  shotcount = (shotcount + 1) % maxshots;
}

void jump(){
  if(!jumping){
    jumping = true;
    jumpspeed = jumpvelocity;
  }
}
