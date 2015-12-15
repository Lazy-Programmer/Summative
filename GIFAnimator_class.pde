class GIFAnimator{
  PVector size;
  PVector position;
  int index;
  int fps;
  float deltaTime;
  boolean visible;
  ArrayList <PImage> slides;
  
  GIFAnimator(float xx, float yy, float ww, float hh){
    position.x = xx;
    position.y = yy;
    size.x = ww;
    size.y = hh;
    index = 0;
    fps = 2;
    deltaTime = 0;
    visible = true;
    slides = new ArrayList<PImage>();
  }
  
  void setPosition(PVector tposition, PVector tsize){
    position = tposition;
    size = tsize;
  }
  
  void addSlide(PImage slide){
    slides.add(slide);
  }
  
  void erase(){
    slides.clear();
  }
  
  PImage get(int i){
    return slides.get(i);
  }
  
  //display the animator
  void display(){
    deltaTime += frameRate/60;
    if(deltaTime >= 60 - fps){
      index -= 1;
      if(index <= 0){
        index = slides.size() - 1;
      }
      deltaTime = 0;
    }
    
    //draw the image
    image(slides.get(index), position.x, position.y, size.x, size.y);
  }
  
  //display if there is a pattern
  /*void display(int [] in){
    deltaTime += 1/frameRate;
    if(deltaTime >= fps){
      index += 1;
      if(index >= in.length){
        index = 0;
      }
      deltaTime = 0;
    }*/
    
    //draw the image
   // image(slides.get(in[index]), position.x, position.y, size.x, size.y);
  //}
}
