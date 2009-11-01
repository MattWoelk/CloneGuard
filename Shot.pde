public class Shot{
  boolean active;
  int x;
  int y;
  int speed;
  PImage img;

  boolean ground[][];
  int blocksize = 30;

  public Shot(){
    x = 0;
    y = 0;
    speed = -8;
    img = loadImage("images/peew.png");
    ground = new boolean[20][20];
    for(int i = 0; i < 20; i++){
      for(int j = 0; j < 20; j++){
        ground[i][j] = false;
      }
    }
    for(int i = 0; i < 20; i++){
      ground [i][5] = true;
    }
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
