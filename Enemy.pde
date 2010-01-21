public class Enemy{
  int xpos;
  int ypos;
  int life;
  int height;
  PImage anim[];
  PImage animl[];
  int animCount;
  public Enemy(int x, int y){
    this.xpos = x;
    this.ypos = y;
    height = 40;
    life = 2;
    animCount = 1;

    anim = new PImage[3];
    for(int i = 0; i < 3; i++){
      anim[i] = loadImage("Images/e" + (3 - i) + ".png");
    }
  }

  public void paint(){
    image(anim[animCount], xpos, ypos - height, height, height);
  }

  public boolean isShot(int x, int y){
    if(intersect(x,y)){
      System.out.println("It is heppeneed@!!");
      animCount = 0;
      return true;
    }else{
      return false;
    }
  }

  public boolean intersect(int x, int y){
    return (x <= xpos + height && x >= xpos && y <= ypos + height && y > ypos);
  }
}
