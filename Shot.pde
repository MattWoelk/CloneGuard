public class Shot{
  boolean active;
  public int x;
  public int y;
  int SPEED;
  PImage img;
  
  public Shot(){
    x = 0;
    y = 0;
    SPEED = -8;
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
      image(img, x,y);
    } 

    //if walls are everywhere, make this so it only dies when it hits a wall.
    if(x < -60 || x > width)
      active = false;
  }

  public void set(int x, int y, boolean active){
    this.x = x;
    this.y = y;
    this.active = active;
  }
}
