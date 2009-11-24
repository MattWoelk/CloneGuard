public class Level{
  String lines[];
  char blocks[][]; 
  int BLOCKSIZE;
  int sizes[]; //numbers of blocks in each row.
  int blength; //number of blocks horizontal.
  
  public Level(int num){
    BLOCKSIZE = 60;
    blocks = new char[100][20];

    load(num);
  }
  
  public void load(int num){
    lines = loadStrings("level" + num + ".txt");
    for(int i = 0; i < lines.length; i++){
      char temp[] = new char[100];
      for(int j = 0; j < lines[i].length(); j++){
        //NB: X AND Y ARE BACKWARDS...........
        blocks[j][i] = lines[i].charAt(j);
      }
    }
    blength = blocks.length;
    sizes = new int[blength];
    for(int i = 0; i < blength; i++){
      sizes[i] = blocks[i].length;
    }
  }
  
  public void paint(){
    int blength = blocks.length;
    //IMP: only draw what's on-screen?
    for(int i = 0; i < blength; i++){
      for(int j = 0; j < sizes[i]; j++){
        if(blocks[i][j] == '-'){
          fill(255);
        }else if(blocks[i][j] == 'x'){
          fill(100);
        }else
          fill(0);
        rect(i*BLOCKSIZE,j*BLOCKSIZE,BLOCKSIZE,BLOCKSIZE);
      }
    }
  }
  
  //to see if the x,y point is within a block. 
  public boolean isSolidBlock(double x, double y){
    //NB: (this will have to be changed if ever the character is falling REALLY fast)
    return blocks[floor((float)x/BLOCKSIZE)][floor((float)y/BLOCKSIZE)] == 'x';
  }
  
  public int roundUpToBlockTop(int y){
    return floor(y/BLOCKSIZE)*BLOCKSIZE;
  }
}
