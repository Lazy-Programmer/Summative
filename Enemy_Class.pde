class Enemy extends Living {
  int alertState = 0;
  int Objective;
  PVector playerLNP;
  boolean isAlert = false;

  Enemy(PVector tposition, PVector tsize, PVector tvelocity, float tspeed, float torientation, int thealth, int tteam, int tammo) {
    super(tposition, tsize, tvelocity, tspeed, torientation, thealth, tteam, tammo);
  }

  void calculateVelocity() {
  }

  void pathFind() {
  }

  boolean see() {
    boolean isVisionNotBlocked = true;
    for ( int i = 0; i < walls.size(); i++) {
      PVector wallCornerTopLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
      PVector wallCornerTopRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
      PVector wallCornerBottomLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
      PVector wallCornerBottomRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
      if (determineIntersect(new PVector(position.x + 5, position.y + 5), myPlayer.position, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(new PVector(position.x + 5, position.y + 5), myPlayer.position, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( new PVector(position.x + 5, position.y + 5), myPlayer.position, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(new PVector(position.x + 5, position.y + 5), myPlayer.position, wallCornerTopLeft, wallCornerTopRight) == true) {
        isVisionNotBlocked = false;
      }
    }


    if (isVisionNotBlocked == true) {
      playerLNP = myPlayer.position;
      isAlert = true;
    }
    return isVisionNotBlocked;
  }

  int getNode() {
    return 1;
  }

  void enemyAI() {
    switch(alertState) {
    case 0:

      //code to walk around idly
      break;
    case 1:
      //code to investigate
      break;
    case 2:
      //code to search
      break;
    case 3:
      //code to attack the player
      break;
    }
  }
}
