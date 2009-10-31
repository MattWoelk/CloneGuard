public class Shot{
  boolean active;
  int x;
  int y;
  int speed;
  PImage img;

  public Shot(){
    x = 0;
    y = 0;
    speed = -8;
    img = loadImage("images/peew.png");
  }

  public void paint(){
    if(active){
      x += speed;
      image(img, x,y);
    } 

    //if walls are everywhere, make this so it only dies when it hits a wall.
    if(x < -60 || x > width)
      active = false;
  }

  public void set(int x, int y, boolean bol){
    this.x = x;
    this.y = y;
    active = bol;
  }
}
