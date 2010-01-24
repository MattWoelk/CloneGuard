public class Enemy{
  Level level;
  int xpos;
  int ypos;
  int yvel;
  int yacc;
  int xsp;
  int life;
  int height;
  int width;
  public boolean active;
  PImage anim[];
  PImage animl[];
  int animCount;

  public Enemy(int x, int y, Level level){
    this.level = level;
    this.xpos = x;
    xsp = 0;
    height = 40;
    this.ypos = y-height;
    width = 40;
    life = 2;
    animCount = 1;
    yvel = 0;
    yacc = 0;

    anim = new PImage[3];
    for(int i = 0; i < 3; i++){
      anim[i] = loadImage("Images/e" + (3 - i) + ".png");
    }

    active = true;
  }

  public void paint(){
    //jump();

    //WALKING AND SIDE COLLISION
    if(!level.wallCollision(xpos + xsp,ypos,width,height)){
      xpos += xsp;
    }
    //JUMPING AND VERTICAL COLLISIONS
    yvel += yacc;

    if(!level.groundCollision(xpos,ypos + yvel,width,height) && !level.ceilingCollision(xpos,ypos + yvel,width)){ //if (if we move) there is no floor or ceiling collision
      ypos += yvel;
      yacc = YACCEL;
    }else if(level.ceilingCollision(xpos,ypos + yvel,width)){ //ceiling collision
      ypos = level.roundUpToBlockTop(ypos) + 1; //align top of sprite with ceiling
      yvel = 0;
    }else{ //floor collision
      ypos = level.roundUpToBlockTop(ypos + yvel + height) - height; //stand on floor
      yacc = 0;
      yvel = 0;
    }
    image(anim[animCount], xpos, ypos, height, width);
  }

  public boolean isShot(int x, int y){
    if(intersect(x,y)){
      jump();
      animCount = 0;
      active = false;
      return true;
    }else{
      return false;
    }
  }

  public boolean intersect(int x, int y){
    return (x <= xpos + width && x >= xpos && y <= ypos + height && y > ypos);
  }

  public void jump(){
    if(yacc == 0){
      yacc = YACCEL;
      yvel = -20;
    }
  }
}
