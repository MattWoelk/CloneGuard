public class Level{
  String lines[];
  char blocks[][]; 
  int blockSize;

  public Level(int num){
    blockSize = 60;
    blocks = new char[100][100];

    load(num);
  }

  public void load(int num){
    lines = loadStrings("level" + num + ".txt");
    for(int i = 0; i < lines.length; i++){
      char temp[] = new char[100];
      for(int j = 0; j < lines[i].length(); j++){
          blocks[j][i] = lines[i].charAt(j);
      }
    }
  }

  public void paint(){
    for(int i = 0; i < 30; i++){
      for(int j = 0; j < 20; j++){
        if(blocks[i][j] == 'o'){
          fill(255);
        }else if(blocks[i][j] == 'x'){
          fill(100);
        }else
          fill(0);
        rect(i*blockSize,j*blockSize,blockSize,blockSize);
      }
    }
  }

  //to see if the x,y point is within a brick. 
  //(this will have to be changed if ever the character is falling REALLY fast.)
  public boolean collide(int x, int y){
    return blocks[floor(y/blockSize)][floor(x/blockSize)] == 'x';
  }

  //to be used in the same frame (of time) as collide, because the x value isn't used.
  public int topOfBrick(int x, int y){
    return (int)Math.floor(y/blockSize)*blockSize;
  }
}
