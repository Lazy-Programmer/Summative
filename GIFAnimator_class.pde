class GIFAnimator{
    PVector size;
    PVector position;
    int index;
    int fps;
    int stall;
    boolean stalling;
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
      stall = -1;
      stalling = false;
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
      deltaTime += timer.timeSinceLastCall/10;
      if(deltaTime >= 60 - fps){
        index -= 1;
        if(index <= -1){
          index = slides.size() - 1;
        }
        deltaTime = 0;
      }
      
      //draw the image
      if(stalling){
        image(slides.get(stall), position.x, position.y, size.x, size.y);
      }else{
        image(slides.get(index), position.x, position.y, size.x, size.y);
      }
      if(index == stall && stall > 0){
        stalling = true;
      }
    }
}

void loadGif(GIFAnimator animation, String filepath){
  JSONArray values = loadJSONArray(sketchPath(filepath));
  for(int i = 0; i < values.size(); i++){//load walls
    JSONObject entity = values.getJSONObject(i);
    animation.addSlide(entity.getString("slide"));
    animation.fps = entity.getInt("speed");
  }
}
