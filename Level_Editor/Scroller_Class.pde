class Scroller{
  int x, y;
  int w, h;
  int r, g, b;
  char demention;
  Button left, right;
  
  Scroller(int xx, int yy, int ww, int hh){
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    
    demention = 'x';
    
    left = new Button(int(x - w*0.45), y, int(w*0.1), h);
    left.roundness = 0;
    left.backColour(0, 180, 180);
    left.buttonText = " ";
    right = new Button(int(x + w*0.45), y, int(w*0.1), h);
    right.roundness = 0;
    right.backColour(0, 180, 180);
    right.buttonText = " ";
  }
  
  void colour(int rr, int gg, int bb){
    r = rr;
    g = gg;
    b = bb;
  }
  
  void changeDem(char dem){
    if(dem == 'X' || dem == 'x'){
    
    }else if(dem == 'y' || dem == 'Y'){
      left.y = int(y - h/2 + h*0.05);
      left.x = x;
      left.w = w;
      left.h = int(h*0.1);
      
      right.y = int(y + h/2 - h*0.05);
      right.x = x;
      right.w = w;
      right.h = int(h*0.1);
    }
  }
  
  void display(){
    //draw bar
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);
    fill(140);
    rect(x, y, w, h);
    
    //buttons
    left.backColour(r, g, b);
    right.backColour(r, g, b);
    left.update();
    left.display();
    right.update();
    right.display();
  }
}
