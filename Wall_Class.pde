class Wall extends NonLiving {
  PImage backgroundImage;
  boolean isImage;
  int imageIndex;
  
  Wall(PVector tposition, PVector tsize, float torientation, String filename /* GIF STUFF*/) {
    super(tposition, tsize, new PVector(0, 0), torientation/*GIF STUFF*/);
    File file = new File(sketchPath(filename));
    boolean isInMem = false;
    if(file.exists()){
      for(int i = 0; i < imageHolderFilename.size(); i++){
        if(filename == imageHolderFilename.get(i)){
          imageIndex = i;
          isInMem = true;
        }
      }
      if(!isInMem){
        imageHolder.add(loadImage(filename));
        imageHolderFilename.add(filename);
        imageIndex = imageHolder.size() - 1; 
      }
      isImage = true;
    }else{
      isImage = false;
    }
  }
  
  void display() {//default display method, should only be called when a child does not have its own yet or it encounters an error
      translate(position.x, position.y);
      rotate(radians(orientation));
      if(isImage){
        imageMode(CENTER);
        image(imageHolder.get(imageIndex), 0 , 0 , size.x, size.y);
      }else{
        rect(0, 0, size.x, size.y);
      }
      rotate(-radians(orientation));
      translate(-position.x,-position.y);
    }
}
