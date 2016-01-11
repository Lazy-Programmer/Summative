abstract class Enemy extends Living {
  int alertState = 0;
  PVector target;
  boolean isAlert = false;
  ArrayList<Integer> path = new ArrayList<Integer>();
  int delay = 100;

  Enemy(PVector tposition, PVector tsize, float tspeed, float torientation, int thealth, int tteam) {
    super(tposition, tsize, new PVector(0, 0), tspeed, torientation, thealth, tteam, -1);
  }

  boolean see(PVector subject) {
    boolean isVisionNotBlocked = true;
    for ( int i = 0; i < walls.size(); i++) {
      PVector wallCornerTopLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
      PVector wallCornerTopRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
      PVector wallCornerBottomLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
      PVector wallCornerBottomRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
      if (determineIntersect(new PVector(position.x, position.y), subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(new PVector(position.x, position.y), subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( new PVector(position.x, position.y), subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(new PVector(position.x, position.y), subject, wallCornerTopLeft, wallCornerTopRight) == true) {
        isVisionNotBlocked = false;
      }
    }
    return isVisionNotBlocked;
  }

  boolean collisionSee(PVector subject) {
    boolean isVisionNotBlocked = true;
    PVector topLeft = new PVector(position.x - size.x/2, position.y - size.y/2);
    PVector topRight = new PVector(position.x + size.x/2, position.y - size.y/2);
    PVector bottomLeft = new PVector(position.x - size.x/2, position.y + size.y/2);
    PVector bottomRight = new PVector(position.x + size.x/2, position.y + size.y/2);
    for ( int i = 0; i < walls.size(); i++) {
      PVector wallCornerTopLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
      PVector wallCornerTopRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
      PVector wallCornerBottomLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
      PVector wallCornerBottomRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
      if (determineIntersect(topLeft, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(topLeft, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( topLeft, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(topLeft, subject, wallCornerTopLeft, wallCornerTopRight) == true) {
        isVisionNotBlocked = false;
      } else if(determineIntersect(topRight, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(topRight, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( topRight, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(topRight, subject, wallCornerTopLeft, wallCornerTopRight) == true){
        isVisionNotBlocked = false;
      }else if(determineIntersect(bottomLeft, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(bottomLeft, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( bottomLeft, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(bottomLeft, subject, wallCornerTopLeft, wallCornerTopRight) == true){
        isVisionNotBlocked = false;
      }else if(determineIntersect(bottomRight, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(bottomRight, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( bottomRight, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(bottomRight, subject, wallCornerTopLeft, wallCornerTopRight) == true){
        isVisionNotBlocked = false;
      }
    }
    return isVisionNotBlocked;
  }

  int getNode() {
    return 1;
  }

  void pathFind() {
    if (delay > 0) {
      delay -= timer.timeSinceLastCall;
    }
    if (delay <= 0) {
      path = Astar(PVectorToNode(position), PVectorToNode(myPlayer.position), navPoints);
      delay = 100;
    }
  }
  
    void moveToTarget() {
    float angle = atan2( ( target.y - position.y ), ( target.x - position.x ) ) * 180 / PI;
    velocity.x = speed * cos( angle * PI / 180 );
    velocity.y = speed * sin( angle * PI / 180 );
  }

  abstract void enemyAI();

  abstract void attack();
}
