PImage a;
int xpos;
int ypos;
int xsp;
int ysp;
Shot shots[];
int shotcount;
int maxshots;

boolean jumping;
int jumpvelocity; //the starting speed of the jump
double jumpspeed; //the current speed of vertical movement

boolean keys[]; //I'd love to use hashes instead.

void setup(){
  size(800,600);
  a = loadImage("images/1.png");
  xpos = 500;
  ypos = 200;
  xsp = 0;
  ysp = 0;
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
}

void draw(){
  background(000);

  if(jumping)
    jumpspeed += 0.5;
  if(ypos > height - 100){
    ypos = height - 100;
    jumpspeed = 0;
    jumping = false;
  }
  ypos += jumpspeed;

  image(a, xpos,ypos);
  if(keys[0] || keys[1])
    xpos += xsp;
  if(!keys[0])
    ypos += ysp;
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
    System.out.println("J");
    break;
  case 'l':
    if(!keys[1])
      xsp += 5;
    keys[1] = true;
    System.out.println("L");
    break;
  case 'x':
    if(!keys[2])
      keys[2] = true;
    System.out.println("X");
    shoot();
    break;
  case 'z':
    if(!keys[3]){
      //jumping = true;
      jump();
    }
    keys[3] = true;
    System.out.println("Z");
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
    System.out.println("J*");
    break;
  case 'l':
    if(keys[1])
      xsp -= 5;
    keys[1] = false;
    System.out.println("L*");
    break;
  case 'z':
    if(keys[3])
      //jumping = false;
    keys[3] = false;
    System.out.println("Z*");
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
