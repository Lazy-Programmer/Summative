class View {
  PVector position;
  PVector startPosition;
  PVector absolutePosition;
  PVector size;

  View(PVector tposition, PVector tsize) {
    position = tposition;
    startPosition = position;
    absolutePosition = position;
    size = tsize;
  }

  void update(PVector tposition) {//moves the view to the position
    startPosition.x = tposition.x;
    startPosition.y = tposition.y;
  }

  void mouseScroll() {//moves the view based on the mouse
    position.x = startPosition.x - width/2 - (width/2 - mouseX);
    position.y = startPosition.y - height/2 - (height/2 - mouseY);
  }
  
  PVector convertCoords(float xPos, float yPos) {//translates the coordinates to compensate for the screen "moving" mainly used for the mouse
    xPos += position.x;
    yPos += position.y;
    return new PVector(xPos, yPos);
  }
}
