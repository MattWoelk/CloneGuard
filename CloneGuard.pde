PImage sprite;
PImage spriteMan[];
int spriteHeight;
int spriteWidth;

//MOVEMENT
int xpos;
int ypos;
int yvel;
int yacc;
int xsp; //current speed in the x direction.
int XVELOCITY; //the starting walk speed.
int YACCEL;
boolean facingLeft; //ISSUE: 

//SHOOTING
Shot shots[];
int shotcount;
int MAXSHOTS;
int shotTimer;

//INPUT
int keys[]; //ints (should be booleans)

//LEVEL
Level level;

void setup(){
  size(600,400);

  //SPRITE
  sprite = loadImage("images/1.png");
  spriteMan = new PImage[4];
  for(int i = 0; i < 4; i+=2){
    spriteMan[i] = loadImage("images/a" + i + ".png");
    spriteMan[i+1] = loadImage("images/a" + i + "b.png");
  }
  spriteHeight = 40;
  spriteWidth = 40;

  xpos = 401;
  xsp = 0;
  XVELOCITY = 5; 
  ypos = 201;
  yvel = 0;
  YACCEL = 1;
  yacc = YACCEL;


  facingLeft = true;

  //INPUT
  keys = new int[4];
  for(int i = 0; i < 4; i++){
    keys[i] = 0;
  }
  
  //SHOOTING
  MAXSHOTS = 30;
  shots = new Shot[MAXSHOTS];
  shotcount = 0;
  for(int i = 0; i < MAXSHOTS; i++){
    shots[i] = new Shot();
  }
  shotTimer = 100;
  
  //LEVEL
  level = new Level(0);
}


void draw(){
  if(xsp > 0)
    facingLeft = false;
  else if (xsp < 0)
    facingLeft = true;

  background(000);
  level.paint();
  fill(255);
  rect(xpos,ypos,spriteWidth,spriteHeight);
  
  drawSprite();

  //WALKING AND SIDE COLLISION
  if((keys[0] > 0 || keys[1] > 0) && isNotWall(xpos + xsp,ypos)){
    xpos += xsp;
  }

  //JUMPING AND VERTICAL COLLISIONS
  yvel += yacc;

  if(!groundCollision(xpos,ypos)){ //if (not floor collision if we move)
    ypos += yvel;
  }else{
    ypos = level.roundUpToBlockTop(ypos + yvel + spriteHeight) - spriteHeight; //stand on floor
    yacc = 0;
  }

  //SHOOTING
  for(int i = 0; i < MAXSHOTS; i++){
    shots[i].paint();
  }
  if (keys[2] > 0){
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
    if(keys[0] == 0){
      xsp -= XVELOCITY;
    }
    keys[0] = 1;
    break;
  case 'l':
    if(keys[1] == 0){
      xsp += XVELOCITY;
    }
    keys[1] = 1;
    break;
  case 'x':
    if(keys[2] == 0)
      keys[2] = 1;
    break;
  case 'z':
    if(yacc == 0){
      yacc = YACCEL;
      yvel = -20;
    }
    keys[3] = 1;
    break;
  default:
    break;
  }
}


void keyReleased(){
  char k = (char)key;
  switch(k){
  case 'j':
    if(keys[0] > 0)
      xsp += XVELOCITY;
    keys[0] = 0;
    break;
  case 'l':
    if(keys[1] > 0)
      xsp -= XVELOCITY;
    keys[1] = 0;
    break;
  case 'x':
    if (keys[2] > 0){
      keys[2] = 0;
      shotTimer = 10;
    }
    break;
  case 'z':
    keys[3] = 0;
    if(yvel <= -5){ //set these to zero to have a completely immediate response
      yvel = -5; //a velocity that still gives a little bit of arc
    }
    break;
  default:
    break;
  }
}


void shoot(){
  shots[shotcount].set(xpos,ypos + (int)(spriteHeight/2),true);
  if(!facingLeft){
    shots[shotcount].shootRight(); //sets direction of shot.
    shots[shotcount].x += (int)spriteWidth/2;
  }else{
    shots[shotcount].shootLeft();
    shots[shotcount].x -= (int)spriteWidth/2;
  }
  shotcount = (shotcount + 1) % MAXSHOTS;
}


boolean isNotWall(int x, int y){
  return !level.isSolidBlock((int)(Math.signum(xsp)*spriteWidth/2 + spriteWidth/2) + x,y + spriteHeight -1);
}


boolean groundCollision(double x, double y){
  //checks left and right points of sprite
  return level.isSolidBlock(x, y + yvel + spriteHeight) || 
    level.isSolidBlock(x + spriteWidth, y + yvel + spriteHeight);
}


boolean ceilingCollision(double x, double y){
  //checks left and right points of sprite
  return level.isSolidBlock(x,y + yvel) || 
      level.isSolidBlock(x + spriteWidth,y + yvel);
}

  
void drawSprite(){
  if(facingLeft && yacc != 0)
    image(spriteMan[2], xpos, ypos,spriteWidth,spriteHeight);
  if(facingLeft && yacc == 0)
    image(spriteMan[0], xpos, ypos,spriteWidth,spriteHeight);
  if(!facingLeft && yacc != 0)
    image(spriteMan[3], xpos,ypos,spriteWidth,spriteHeight);
  if(!facingLeft && yacc == 0)
    image(spriteMan[1], xpos,ypos,spriteWidth,spriteHeight);
}
