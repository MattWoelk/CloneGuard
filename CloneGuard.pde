//It is currently possible to jump while not yet touching the ground.


PImage sprite;
int spriteHeight;
int spriteWidth;

//MOVEMENT
int xpos;
int ypos;
int xsp; //curret speed in the x direction.
int XVELOCITY; //the starting walk speed.

//SHOOTING
Shot shots[];
int shotcount;
int MAXSHOTS;
int shotTimer;

//JUMPING
boolean jumping;  //indicates whether the character is in the air or not.
int JUMPVELOCITY; //the starting speed of the jump
double jumpspeed; //the current speed of vertical movement

//INPUT
boolean keys[]; //I'd love to use hashes instead.

//LEVEL
Level level;

void setup(){
  size(600,400);
  sprite = loadImage("images/1.png");
  spriteHeight = 60;
  spriteWidth = 60;

  xpos = 500;
  ypos = 200;
  xsp = 0;
  XVELOCITY = 5; 

  //INPUT
  keys = new boolean[4];
  for(int i = 0; i < 4; i++){
    keys[i] = false;
  }
  
  //SHOOTING
  MAXSHOTS = 30;
  shots = new Shot[MAXSHOTS];
  shotcount = 0;
  for(int i = 0; i < MAXSHOTS; i++){
    shots[i] = new Shot();
  }
  shotTimer = 100;
  
  //JUMPING
  jumping = true;
  JUMPVELOCITY = -10;
  jumpspeed = 0;
  
  //LEVEL
  level = new Level(0);
}


void draw(){
  background(000);
  level.paint();
  fill(255);
  rect(xpos,ypos,spriteWidth,spriteHeight);
  image(sprite, xpos, ypos);

  //WALKING AND SIDE COLLISION
  if((keys[0] || keys[1]) && !level.isSolidBlock((int)(Math.signum(xsp)*spriteWidth/2) + (int)(spriteWidth/2) + (xpos + xsp),ypos)){
    xpos += xsp;
  }
                          //right now the side collision and the floor collision are not agreeing with their xpos, this is causing
                          //...the ability to jump onto ledges that are higher than you can jump.
  //JUMPING
  if(jumping)
    jumpspeed += 0.5;//0.5
  
  //JUMPING AND GROUND COLLISION
  if(level.isSolidBlock(xpos,(int)(ypos + jumpspeed + spriteHeight)) || 
      level.isSolidBlock(xpos + spriteWidth,(int)(ypos + jumpspeed + spriteHeight))){
    ypos = level.topOfBlock(xpos,(int)(ypos + jumpspeed + spriteHeight));
    jumpspeed = 0;
    jumping = false;
  }else{
    jumping = true;
  }
  ypos += jumpspeed;
  
  //SHOOTING
  for(int i = 0; i < MAXSHOTS; i++){
    shots[i].paint();
  }
  if (keys[2]){
    shotTimer++;
    if (shotTimer > 9){
      shotTimer = 0;
      shoot();
    }
  }
}


void keyPressed(){
  char k = (char)key;
  switch(k){
  case 'j':
    if(!keys[0])
      xsp -= XVELOCITY;
    keys[0] = true;
    break;
  case 'l':
    if(!keys[1])
      xsp += XVELOCITY;
    keys[1] = true;
    break;
  case 'x':
    if(!keys[2])
      keys[2] = true;
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
      xsp += XVELOCITY;
    keys[0] = false;
    break;
  case 'l':
    if(keys[1])
      xsp -= XVELOCITY;
    keys[1] = false;
    break;
  case 'x':
    if (keys[2] = true){
      keys[2] = false;
      shotTimer = 10;
    }
    break;
  case 'z':
    if(keys[3])
    keys[3] = false;
    break;
  default:
    break;
  }
}


void shoot(){
  shots[shotcount].set(xpos - 15,ypos + 30,true);
  shotcount = (shotcount + 1) % MAXSHOTS;
}


void jump(){
  if(!jumping){
    jumping = true;
    jumpspeed = JUMPVELOCITY;
  }
}
