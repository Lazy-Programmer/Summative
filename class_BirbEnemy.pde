class Birb_Enemy extends Enemy {
  boolean isAttacking = false;
  int cooldown = 0;

  Birb_Enemy(PVector tposition, float torientation) {
    super(tposition, new PVector(37, 49), 0.2, torientation, 15, 2);
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
      orientation = ( atan2( position.y-myPlayer.position.y, position.x-myPlayer.position.x )*180/PI + 180);
      if ( dist(position.x, position.y, myPlayer.position.x, myPlayer.position.y) <= 400) {
        //attack
        isAttacking = true;
        attack();
      } else {
        target = mapCoordinatesToCircle(myPlayer.position, 300, position);
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

  void display() {
    pushMatrix();
    //orientation = atan2( position.y-view.convertCoords(myPlayer.position.x, myPlayer.position.y).y, position.x-view.convertCoords(myPlayer.position.x, myPlayer.position.y).x )*180/PI + 180;
    translate(position.x, position.y);
    rotate(radians(orientation - 90));
    if (!(animation.size() > 0)) {
      rectMode(CENTER);
      rect(0, 0, size.x, size.y);
    }
    if (animation.size() > currAnimation) {
      animation.get(currAnimation).position.x = 0;
      animation.get(currAnimation).position.y = 0;
      animation.get(currAnimation).display();
      if (animationTime > 0) {
        animationTime -= timer.timeSinceLastCall;
        if (animationTime <= 0) {
          animation.get(currAnimation).stall = -1;
          animation.get(currAnimation).stalling = false;
          currAnimation = prevAnimation;
          prevAnimation = -1;
          animationTime = -1.0;
        }
      }
    }
    popMatrix();
  }

  void attack() {
    if (cooldown < 1) {//if the gun is not reloading or waiting to fire, fire
      cooldown = 1500;
      PVector aim = mapCoordinatesToCircle(position, 300, myPlayer.position);// map the target to a circle to keep the accuracy constant rather than dependant on distance to target
      PVector bulletVelocity;
      bulletVelocity = new PVector(cos(atan2( aim.y  - position.y, aim.x - position.x))*0.75, sin(atan2( aim.y - position.y, aim.x - position.x))*0.75);
      bullets.add(new feather(new PVector(position.x,position.y), bulletVelocity, orientation));
    }else {
      cooldown -= timer.timeSinceLastCall;
    }
  }
}
