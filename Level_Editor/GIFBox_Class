class GIFBox{
  int x, y;
  int w, h;
  int r, g, b;
  float yOffset;
  ArrayList <TextRect> slides;
  
  GIFBox(int xx, int yy, int ww, int hh){
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    yOffset = 0;
    
    r = g = b = 0;
    slides = new ArrayList<TextRect>();
  }
  
  void backColour(int rr, int gg, int bb){
    r = rr;
    g = gg;
    b = bb;
  }
  
  void addSlide(String filename){
    slides.add(new TextRect(x, y, w, int(h/8), loadImage(filename)));
    slides.get(slides.size() - 1).text = "Slide " + str(slides.size());
    slides.get(slides.size() - 1).textColour(28, 196, 26);
  }
  
  void display(){
    //set the right text
    for(int i = 0; i < slides.size(); i++){
      slides.get(i).text = "Slide " + str(i + 1);
    }
    
    rectMode(CENTER);
    fill(r, g, b);
    rect(x, y, w, h);
    for(int i = 0;  i < slides.size(); i++){
      slides.get(i).y = (y-h/2+h/16) + (i)*slides.get(i).h - int(yOffset);
      if(slides.get(i).y - slides.get(i).h/2 >= y-h/2 && slides.get(i).y <= y+(h/2)){
        slides.get(i).display();
      }
    }
  }
}

class TextRect{
  int x, y;
  int w, h;
  int r, g, b;
  int tr, tg, tb;
  boolean hovering;
  boolean clickDown;
  PImage image;
  String text;
  
  TextRect(int xx, int yy, int ww, int hh, PImage img){
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    
    image = img;
    
    hovering = false;
    clickDown = false;
    
    r = g = b = 0;
    tr = tg = tb = 255;
    text = "undefined";
  }
  
  void backColour(int rr, int gg, int bb){
    r = rr;
    g = gg;
    b = bb;
  }
  
  void textColour(int rr, int gg, int bb){
    tr = rr;
    tg = gg;
    tb = bb;
  }
  
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
  
  void checkHover(){
      if(mouseX < x-w/2 || mouseX > x+w/2 || mouseY < y-h/2 || mouseY > y+h/2){
        if(hovering){
          r -= 80;
          g -= 80;
          b -= 80;
          hovering = false;
        }
      }else{
        if(!hovering){
           r += 80;
           g += 80;
           b += 80;
           hovering = true;
        }
      }
  }
  
  void display(){
    //update
    checkHover();
    
    rectMode(CENTER);
    fill(r, g, b);
    stroke(tr, tg, tb);
    rect(x, y, w, h);
    fill(tr, tg, tb);
    textAlign(RIGHT, CENTER);
    text(text, x, y);
    
    //image
    image(image, x + w/4, y - h/2, h, h);
  }
}
