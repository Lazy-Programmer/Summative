class Cat_Enemy extends Enemy {
  boolean isAttacking = false;
  PVector imageSize = new PVector(72, 72);
  boolean strike = false;

  Cat_Enemy(PVector tposition, float torientation) {
    super(tposition, new PVector(30, 56), 0.25, torientation, 25, 2);
    addAnimation("data/Animations/catWalking.anim");
    addAnimation("data/Animations/catAttack.anim");
  }

  void addAnimation(String filepath) {
    animation.add(new GIFAnimator(position.x, position.y, imageSize.x, imageSize.y));
    if (animation.size() > 0) {
      loadGif(animation.get(animation.size() - 1), filepath);
    }
    currAnimation = 0;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);//move to the cat 34,15
    rotate(radians(orientation - 90));//rotate 
    if (!(animation.size() > 0)) {//if there is not animation, display a rectangle
      rectMode(CENTER);
      rect(0, 0, imageSize.x, imageSize.y);
    }
    if (animation.size() > currAnimation) {//otherwise display the animation
      animation.get(currAnimation).position.x = 0;
      animation.get(currAnimation).position.y = 16;
      animation.get(currAnimation).display();
      if (animationTime > 0) {
        animationTime -= timer.timeSinceLastCall;
        if (animation.get(currAnimation).index == animation.get(currAnimation).stall && !strike) {//if the cat hits the ground and has not already done damage
          if (dist(myPlayer.position.x, myPlayer.position.y, position.x, position.y) <= 200) {//if the player is in range
            myPlayer.health -=  dist(myPlayer.position.x, myPlayer.position.y, position.x, position.y)/10;
          }
          strike = true;
        }
        if (animationTime <= 0) {
          animation.get(currAnimation).stall = -1;
          animation.get(currAnimation).stalling = false;
          currAnimation = prevAnimation;
          prevAnimation = -1;
          animationTime = -1.0;
          strike = false;
        }
      }
    }
    popMatrix();
  }

  void enemyAI() {
    velocity.x = 0;//stop the cat from moving
    velocity.y = 0;
    if ( see(myPlayer.position) == true && isAlert == false) {//if the cat has seen the player
      isAlert = true;//chase them
    }
    if ( collisionSee(myPlayer.position) == false && isAlert == true) {//do you have an unobstructed line of sight
      alertState = 2;//no, then pathfind to them
      path = Astar(PVectorToNode(position), PVectorToNode(myPlayer.position), navPoints);
    } else if (collisionSee(myPlayer.position) == true && isAlert == true) {
      alertState = 3;//yes, then go straight for them
    }
    switch(alertState) {
    case 0:
      //the enemy is unaware of the players presence
      break;
    case 2:
      //The enemy has seen the player but has lost them
      if (path.size() > 1) {
        target = navPoints.get(path.get(path.size()-2)).position;
        if (roughlyEqual(position, target, 10)) {//if you're almost at your target, go to the next one
          path.remove(path.size()-1);//and remove your current one
        }
      }
      moveToTarget();
      PVector focus = new PVector();
      for (int i = path.size() -1; i >= 0; i--) {
        if (see(navPoints.get(path.get(i)).position) == true) {//look at the farthest point on your path you can see
          focus = navPoints.get(path.get(i)).position;
        }
      }
      orientation = ( atan2( position.y-focus.y, position.x-focus.x )*180/PI + 180);//look at that point
      pathFind();
      break;
    case 3:
      //The enemy can see the player 
      if (isAttacking == false) {
        if ( dist(position.x, position.y, myPlayer.position.x, myPlayer.position.y) <= 60) {//are you within range?
          //attack
          isAttacking = true;
          attack();//attack
        } else {//otherwise
          target = mapCoordinatesToCircle(myPlayer.position, 50, position);//move toward the player
          if (roughlyEqual(position, target, 5) == false) {
            moveToTarget();
          } else {
            velocity.x = 0;
            velocity.y = 0;
          }
          //move to attack
        }
        orientation = ( atan2( position.y-myPlayer.position.y, position.x-myPlayer.position.x )*180/PI + 180);//look at the player
      }
      if (isAttacking) {
        attack();
      }
      break;
    }
  }

  void attack() {
    if (isAttacking && prevAnimation == -1) {
      animation.get(1).fps = 1;
      playAnimation(1, 500, 1);
      isAttacking = false;
    }
  }
}
