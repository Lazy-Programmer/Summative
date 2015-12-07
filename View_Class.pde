class View{
  PVector position;
  PVector startPosition;
  PVector absolutePosition;
  PVector size;
  
  View(PVector tposition, PVector tsize){
    position = tposition;
    startPosition = position;
    absolutePosition = position;
    size = tsize;
  }
  
  void update(PVector tposition){
    startPosition.x = tposition.x;
    startPosition.y = tposition.y;
  }
  
  void mouseScroll(){
    position.x = startPosition.x - width/2 - (width/2 - mouseX);
    position.y = startPosition.y - height/2 - (height/2 - mouseY);
  }
}
