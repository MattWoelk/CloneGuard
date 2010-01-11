public class Shot{
  boolean active;
  int deathCount;
  public int x;
  public int y;
  int SPEED;
  int WIDTH;
  PImage img;
  PImage pow[];
  Level level;
  
  public Shot(Level level){
    this.level = level;
    x = 0;
    y = 0;
    SPEED = -8;
    WIDTH = 60;
    img = loadImage("images/peew.png");
    pow = new PImage[6];
    for(int i = 0; i < 6; i++){
      pow[i] = loadImage("Images/puffg" + (5 - i) + ".png");
    }
    deathCount = 0;
  }

  public void shootRight(){
    SPEED = Math.abs(SPEED);
  }

  public void shootLeft(){
    SPEED = -1 * Math.abs(SPEED);
  }

  public void paint(){
    if(active){
      x += SPEED;

    //dies if it hits a wall
    if(level.isSolidBlock(x,y) || level.isSolidBlock(x + WIDTH,y)){
      //kill the beam
      active = false;
      deathCount = 6;
      x = level.roundToBlockSide(x,sign(SPEED));
    }
    //dies if off the screen
    if(x < -60 || x > level.levelWidth())
      //kill the beam
      active = false;

      image(img, x,y);
    }else if(deathCount > 0){
      image(pow[deathCount - 1],x-20+(WIDTH/2)+sign(SPEED)*(WIDTH/2),y-20);
      deathCount -= 1;
    }
  }

  public void set(int x, int y, boolean active){
    this.x = x;
    this.y = y;
    this.active = active;
  }

  public int sign(double value){
    if(value < 0){
      return -1;
    }else{
      return 1;
    }
  }
}
