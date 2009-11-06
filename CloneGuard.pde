PImage sprite;
int spriteHeight;

//MOVEMENT
int xpos;
int ypos;
int xsp; //speed in the x direction.

//SHOOTING
Shot shots[];
int shotcount;
int MAXSHOTS;
int shotTimer;

//JUMPING
boolean jumping;
int JUMPVELOCITY; //the starting speed of the jump
double jumpspeed; //the current speed of vertical movement

//INPUT
boolean keys[]; //I'd love to use hashes instead.

//LEVEL
Level level;

void setup(){
  size(600,400);
  sprite = loadImage("images/1.png");
  spriteHeight = 50;

  xpos = 500;
  ypos = 200;
  xsp = 0;

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
  shotTimer = 0;
  
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

  //JUMPING
  if(jumping)
    jumpspeed += 0.5;
  //COLLISION     are we going to collide if we move? if yes, move to a safe location, if not, give'er.



  ////////////////EDITING HERE/////////////////////////
  ////////////////EDITING HERE/////////////////////////
  ////////////////EDITING HERE/////////////////////////
  ////////////////EDITING HERE/////////////////////////
  ////////////////EDITING HERE/////////////////////////
  ////////////////EDITING HERE/////////////////////////
  ////////////////EDITING HERE/////////////////////////
  if(level.ycollide((int)(ypos + jumpspeed + spriteHeight),xpos)){
    ypos = level.topOfBrick(xpos,ypos);
    jumpspeed = 0;
    jumping = false;
  }else{
    jumping = true;//eventually we want jumping to always be true???
  }
  ypos += jumpspeed;
  
  //WALKING
  image(sprite, xpos,ypos);
  if(keys[0] || keys[1])
    xpos += xsp;
  for(int i = 0; i < MAXSHOTS; i++){
    shots[i].paint();
  }

  //SHOOTING
  if (keys[2]){
    shotTimer++;
    if (shotTimer > 9)
    {
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
  case 'x':
    if (keys[2] = true) 
    {
      keys[2] = false;
      shotTimer = 10;
    }
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
  shotcount = (shotcount + 1) % MAXSHOTS;
}


void jump(){
  if(!jumping){
    jumping = true;
    jumpspeed = JUMPVELOCITY;
  }
}
