class GIFAnimator{
  PVector size;
  PVector position;
  int index;
  int fps;
  float deltaTime;
  boolean visible;
  ArrayList <String> filenames;
  ArrayList <PImage> slides;
  
  GIFAnimator(float xx, float yy, float ww, float hh){
    position = new PVector(xx, yy);
    size = new PVector(ww, hh);
    index = 0;
    fps = 56;
    deltaTime = 0;
    visible = true;
    slides = new ArrayList<PImage>();
    filenames = new ArrayList<String>();
  }
  
  void setPosition(PVector tposition, PVector tsize){
    position = tposition;
    size = tsize;
  }
  
  void addSlide(String slide){
    slides.add(loadImage(slide));
    filenames.add(slide);
    index = slides.size() - 1;
  }
  
  void erase(){
    slides.clear();
    filenames.clear();
  }
  
  void remove(int index){
    slides.remove(index);
    filenames.remove(index);
  }
  
  PImage get(int i){
    return slides.get(i);
  }
  
  //display the animator
  void display(){
    deltaTime += frameRate/60;
    if(deltaTime >= 60 - fps){
      index -= 1;
      if(index <= -1){
        index = slides.size() - 1;
      }
      deltaTime = 0;
    }
    
    //draw the image
    if(slides.size() > 0){
      image(slides.get(index), position.x, position.y, size.x, size.y);
    }
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
