class Birb_Enemy extends Enemy {
  boolean isAttacking = false;
  int cooldown = 0;

  Birb_Enemy(PVector tposition, float torientation) {
    super(tposition, new PVector(37, 49), 0.2, torientation, 25, 2);
    addAnimation("data/Animations/BirbWalking.anim");
  }

  void enemyAI() {
    velocity.x = 0;//stop the bird from moving
    velocity.y = 0;
    if ( see(myPlayer.position) == true && isAlert == false) {//if the bird has seen the player
      isAlert = true;// then follow them
    }
    if ( collisionSee(myPlayer.position) == false && isAlert == true) {// is their something in my path
      alertState = 2;//then  pathfind
      path = Astar(PVectorToNode(position), PVectorToNode(myPlayer.position), navPoints);
    } else if (collisionSee(myPlayer.position) == true && isAlert == true) {
      alertState = 3;//then attack/aproach directly
    }
    switch(alertState) {
    case 0:
      //the enemy is unaware of the players presence
      break;
    case 2:
      //The enemy has seen the player but has lost them
      if (path.size() > 1) {
        target = navPoints.get(path.get(path.size()-2)).position;
        if (roughlyEqual(position, target, 10)) {//if you're almost at your point, go to the next one
          path.remove(path.size()-1);//remove your current target
        }
      }
      moveToTarget();
      PVector focus = new PVector();
      for (int i = path.size() -1; i >= 0; i--) {
        if (see(navPoints.get(path.get(i)).position) == true) {
          focus = navPoints.get(path.get(i)).position;//find the farthest point on you path you can see
        }
      }
      orientation = ( atan2( position.y-focus.y, position.x-focus.x )*180/PI + 180);//and look at it
      pathFind();
      break;
    case 3:
      //The enemy can see the player 
      orientation = ( atan2( position.y-myPlayer.position.y, position.x-myPlayer.position.x )*180/PI + 180);//look at the player
      if ( dist(position.x, position.y, myPlayer.position.x, myPlayer.position.y) <= 400) {//attaking range?
        //attack
        isAttacking = true;
        attack();
      } else {
        target = mapCoordinatesToCircle(myPlayer.position, 300, position);//move to attacking range
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
  }

  void display() {
    pushMatrix();
    //orientation = atan2( position.y-view.convertCoords(myPlayer.position.x, myPlayer.position.y).y, position.x-view.convertCoords(myPlayer.position.x, myPlayer.position.y).x )*180/PI + 180;
    translate(position.x, position.y);//move to the bird
    rotate(radians(orientation - 90));//rotate
    if (!(animation.size() > 0)) {//if there is not animation
      rectMode(CENTER);
      rect(0, 0, size.x, size.y);//display a rectangle
    }
    if (animation.size() > currAnimation) {//otherwise display the animation
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
      bulletVelocity = new PVector(cos(atan2( aim.y  - position.y, aim.x - position.x))*0.75, sin(atan2( aim.y - position.y, aim.x - position.x))*0.75);//create the velocity based on angle
      bullets.add(new feather(new PVector(position.x, position.y), bulletVelocity, orientation));//add the bullet to the array
    } else {
      cooldown -= timer.timeSinceLastCall;//wait if you are in cooldown
    }
  }
}
