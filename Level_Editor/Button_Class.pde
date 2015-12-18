class Button{
  int x, y;
  int w, h;
  int roundness;
  int r, g, b, a;
  int textR, textG, textB;
  int textSize;
  boolean hovering;
  boolean clickDown;
  boolean visible;
  String buttonText;
  
  Button(int xx, int yy, int ww, int hh){
    //position variables
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    
    //colour variables
    r = g = b = 0;
    a = 255;
    textR = textG = textB = 255;
    
    //other variables
    hovering = false;
    clickDown = false;
    buttonText = "undefined";
    roundness = 10;
    textSize = 18;
    visible = true;
  }
  
  Button(){
    //position variables
    x = width/2;
    y = height/2;
    w = int(width*0.1);
    h = int(height*0.1);
    
    //colour variables
    r = g = b = 0;
    textR = textG = textB = 255;
    
    //other variables
    hovering = false;
    clickDown = false;
    buttonText = "undefined";
    roundness = 10;
    textSize = 18;
    visible = true;
  }
  
  //change the background colour
  void backColour(int rr, int gg, int bb){
    r = rr;
    g = gg;
    b = bb;
  }
  
  //change the text colour
  void textColour(int rr, int gg, int bb){
    textR = rr;
    textG = gg;
    textB = bb;
  }
  
  //update the status of the button
  void update(){
    clicked();
    checkHover();
    display();
  }
  
  //check if the mouse is hovering over the button
  void checkHover(){
      if(mouseX < x-w/2 || mouseX > x+w/2 || mouseY < y-h/2 || mouseY > y+h/2){
        if(hovering){
          r -= 40;
          g -= 40;
          b -= 40;
          hovering = false;
        }
      }else{
        if(!hovering){
           r += 40;
           g += 40;
           b += 40;
           hovering = true;
        }
      }
  }
  
  //click detection method
  boolean clicked(){
    boolean res = false;
      if(mouseX < x-w/2 || mouseX > x+w/2 || mouseY < y-h/2 || mouseY > y+h/2){
      }else{
        if(mousePressed){
          if(!clickDown){
            r -= 80;
            g -= 80;
            b -= 80;
            clickDown = true;
          }
          res = true;
        }else if(!mousePressed && clickDown){
          r += 80;
          g += 80;
          b += 80;
          clickDown = false;
        }
      }
    return res;
  }
  
  void display(){
    if(visible){
      rectMode(CENTER);
      fill(r, g, b, a);
      rect(x, y, w, h, roundness);
      
      //draw the text
      fill(textR, textG, textB, a);
      textSize(textSize);
      textAlign(CENTER,CENTER);
      text(buttonText,x,y);
      textAlign(CORNER,CORNER);
    }
  }
}
