class Wall extends NonLiving {
  PImage backgroundImage;
  int imageIndex;
  boolean mark = false;
  boolean group = false;

  Wall(PVector tposition, PVector tsize, float torientation, int imageID, String taction) {
    super(tposition, tsize, new PVector(0, 0), torientation);
    action = taction;
    imageIndex = imageID;
    float tempX = 0, tempY = 0;
    if (torientation == 180) {
      position.x -= size.x;
      position.y -= size.y;
    } else if (torientation == 90) {
      tempX = size.y;
      tempY = size.x;
      position.x -= tempX;
    } else if (torientation == 270) {
      tempX = size.y;
      tempY = size.x;
      position.y -= tempY;
    }
  }

  void display() {
    textureMode(NORMAL);
    translate(position.x, position.y);//move to the position
    rotate(radians(orientation));//rotate
    if(group == false){
    imageMode(CENTER);//place the image from its center
    image(imageHolder.get(imageIndex), 0, 0, size.x, size.y);//display the image at the origin
    //println(size);
    }else{
    textureWrap(REPEAT);
     beginShape();
     texture(imageHolder.get(imageIndex));
     vertex(-size.x/2, -size.y/2, 0, 0);
     vertex(size.x/2, -size.y/2, size.x/32, 0);
     vertex(size.x/2, size.y/2, size.x/32, size.y/32);
     vertex(-size.x/2, size.y/2, 0, size.y/32);
     endShape();
    }
    rotate(-radians(orientation));//unrotate
    translate(-position.x, -position.y);//untranslate
  }

  boolean intersects(Wall subject) {//used to determine if a wall intersects this wall, originally going to be used for combining walls, see load level - organize
    PVector STL = new PVector(subject.position.x - subject.size.x/2, subject.position.y - subject.size.y/2);//corners of the subject wall
    PVector STR = new PVector(subject.position.x + subject.size.x/2, subject.position.y - subject.size.y/2);
    PVector SBL = new PVector(subject.position.x - subject.size.x/2, subject.position.y + subject.size.y/2);
    PVector SBR = new PVector(subject.position.x + subject.size.x/2, subject.position.y + subject.size.y/2);
    PVector[] Scorners = {STL, STR, SBL, SBR};//put them into an array
    PVector TL = new PVector(position.x - size.x/2, position.y - size.y/2);//corners of this wall
    PVector TR = new PVector(position.x + size.x/2, position.y - size.y/2);
    PVector BL = new PVector(position.x - size.x/2, position.y + size.y/2);
    PVector BR = new PVector(position.x + size.x/2, position.y + size.y/2);
    PVector[] corners = {TL, TR, BL, BR};//put them in an array
    for (int p1 = 0; p1 < 4; p1++) {
      for (int p2 = 0; p2 < 4; p2++) {
        for (int q1 = 0; q1 < 4; q1++) {
          for (int q2 = 0; q2 < 4; q2++) {
            if (determineIntersect(corners[p1], corners[p2], Scorners[q1], Scorners[q2]) == true && corners[p1] != corners[p2] && Scorners[q1] != Scorners[q2] && (subject.position.x == position.x || subject.position.y == position.y) ) {//test if any of the lines created by the corners of this wall intersect that of another
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  Wall combine(Wall subject) {
    float top;
    if (position.y - size.y/2 <= subject.position.y - subject.size.y/2) {
      top = position.y - size.y/2;
    } else {
      top = subject.position.y - subject.size.y/2;
    }
    float bottom;
    if (position.y + size.y/2 >= subject.position.y + subject.size.y/2) {
      bottom = position.y + size.y/2;
    } else {
      bottom = subject.position.y + subject.size.y/2;
    }
    float ySize = bottom - top;
    float left;
    if (position.x - size.x/2 <= subject.position.x - subject.size.x/2) {
      left = position.x - size.x/2;
    } else {
      left = subject.position.x - subject.size.x/2;
    }
    float right;
    if (position.x + size.x/2 >= subject.position.x + subject.size.x/2) {
      right = position.x + size.x/2;
    } else {
      right = subject.position.x + subject.size.x/2;
    }
    float xSize = right - left;
    PVector pos = new PVector(left + xSize/2, top + ySize/2);
    return new Wall(pos, new PVector(xSize, ySize), orientation, imageIndex, action);
  }
}
