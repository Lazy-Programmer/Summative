class Cat_Enemy extends Enemy {
  boolean isAttacking = false;
  Cat_Enemy(PVector tposition, float torientation) {
    super(tposition, new PVector(29, 56), 0.25, torientation, 25, 2);
  }

  void enemyAI() {
    velocity.x = 0;
    velocity.y = 0;
    if ( see(myPlayer.position) == true && isAlert == false) {
      isAlert = true;
    }
    if ( collisionSee(myPlayer.position) == false && isAlert == true) {
      alertState = 2;
      path = Astar(PVectorToNode(position), PVectorToNode(myPlayer.position), navPoints);
    } else if (collisionSee(myPlayer.position) == true && isAlert == true) {
      alertState = 3;
    }
    switch(alertState) {
    case 0:
      //the enemy is unaware of the players presence
      break;
    case 2:
      //The enemy has seen the player but has lost them
      if (path.size() > 1) {
        target = navPoints.get(path.get(path.size()-2)).position;
        if (roughlyEqual(position, target, 10)) {
          path.remove(path.size()-1);
        }
      }
      moveToTarget();
      PVector focus = new PVector();
      for (int i = path.size() -1; i >= 0; i--) {
        if (see(navPoints.get(path.get(i)).position) == true) {
          focus = navPoints.get(path.get(i)).position;
        }
      }
      orientation = ( atan2( position.y-focus.y, position.x-focus.x )*180/PI + 180);
      break;
    case 3:
      //The enemy can see the player 
      if ( dist(position.x, position.y, myPlayer.position.x, myPlayer.position.y) <= 40) {
        //attack
        isAttacking = true;
        attack();
      } else {
        orientation = ( atan2( position.y-myPlayer.position.y, position.x-myPlayer.position.x )*180/PI + 180);
        target = mapCoordinatesToCircle(myPlayer.position, 50, position);
        if (roughlyEqual(position, target, 5) == false) {
          moveToTarget();
        } else {
          velocity.x = 0;
          velocity.y = 0;
        }
        //move to attack
      }
      break;
    }
    pathFind();
  }

  void attack() {
    //animation
    
  }
}
