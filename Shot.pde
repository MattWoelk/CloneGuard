public class Shot{
  boolean active;
  public int x;
  public int y;
  int SPEED;
  int WIDTH;
  PImage img;
  Level level;
  
  public Shot(Level level){
    this.level = level;
    x = 0;
    y = 0;
    SPEED = -8;
    WIDTH = 60;
    img = loadImage("images/peew.png");
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
      x = level.roundToBlockSide(x,sign(SPEED));
    }
    //dies if off the screen
    if(x < -60 || x > width)
      //kill the beam
      active = false;

      image(img, x,y);
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
