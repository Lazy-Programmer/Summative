class Player extends Living {//player class, can be used for 1 player or have multiple of them for multiple player
  boolean isMovingLeft = false;
  boolean isMovingRight = false;
  boolean isMovingUp = false;
  boolean isMovingDown = false;
  boolean isShooting = false;
  boolean dashing = false;
  float distDashed = 0;
  // int equipedWeapon = 1;
  //int weapon1 = 1;
  //int weapon2 = 2;
  int ammoMax = 45;

  Player(PVector tposition, PVector tsize, PVector tvelocity, float tspeed, float torientation, /* GIF STUFF*/ int thealth, int tteam, int tammo) {
    super(tposition, tsize, tvelocity, tspeed, torientation, thealth, tteam, tammo);
    addAnimation("data/Animations/MainCharacterWalk.anim");
    addAnimation("data/Animations/MainCharacterShootingStanding.anim");
    addAnimation("data/Animations/MainCharacterShootingWalking.anim");
  }

  void display() {
    pushMatrix();
    orientation = atan2( position.y-view.convertCoords(mouseX, mouseY).y, position.x-view.convertCoords(mouseX, mouseY).x )*180/PI + 180;//rotate the player based on angle to cursor
    translate(position.x, position.y);//move to the player's position
    rotate(radians(orientation - 90));//rotate
    if (!(animation.size() > 0)) {//display rectangle if there is no animation
      rectMode(CENTER);
      rect(0, 0, size.x, size.y);
    }
    if (animation.size() > currAnimation) {//display animation
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

  void calculateVelocity() {// used to determine what direction the player is going in
    if (isMovingLeft && isMovingRight && isMovingUp && isMovingDown) {//ignors input if all the directional keys are pressed
      velocity.x = 0;
      velocity.y = 0;
    } else if (isMovingLeft && isMovingRight) {//ignores left and right inputs if both are pressed
      if (isMovingUp == true) {///Up
        velocity.x = 0;
        velocity.y = -speed;
      } else if (isMovingDown == true) {//Down
        velocity.x = 0;
        velocity.y = speed;
      }
    } else if (isMovingUp && isMovingDown) {//ignores up and down inputs if both are pressed
      if (isMovingLeft == true) {//Left
        velocity.x = -speed;
        velocity.y = 0;
      } else if (isMovingRight == true) {//Right
        velocity.x = speed;
        velocity.y = 0;
      }
    } else if (isMovingLeft == true && isMovingUp == true) {//Up and Left
      velocity.x =-speed / 1.4;
      velocity.y =-speed / 1.4;
    } else if (isMovingLeft == true && isMovingDown == true) {//Down and Left
      velocity.x =-speed / 1.4;
      velocity.y =speed / 1.4;
    } else if (isMovingRight == true && isMovingUp == true) {//Up and Right
      velocity.x =speed / 1.4;
      velocity.y =-speed / 1.4;
    } else if (isMovingRight == true && isMovingDown == true) {//Down and Right
      velocity.x =speed / 1.4;
      velocity.y =speed / 1.4;
    } else if (isMovingLeft == true) {//Left
      velocity.x = -speed;
      velocity.y = 0;
    } else if (isMovingRight == true) {//Right
      velocity.x = speed;
      velocity.y = 0;
    } else if (isMovingUp == true) {//Up
      velocity.x = 0;
      velocity.y = -speed;
    } else if (isMovingDown == true) {//down
      velocity.x = 0;
      velocity.y = speed;
    } else {//not moving; no directional keys pressed
      velocity.x = 0;
      velocity.y = 0;
    }

    //testing for the shoulder dash
    float angle = 360 - (atan2( position.y-view.convertCoords(mouseX, mouseY).y, position.x-view.convertCoords(mouseX, mouseY).x )*180/PI + 180);
    if (dashing) {
      velocity.x = (dist(position.x, position.y, view.convertCoords(mouseX, mouseY).x, view.convertCoords(mouseX, mouseY).y)*cos(radians(angle)))/(dist(position.x, position.y, view.convertCoords(mouseX, mouseY).x, view.convertCoords(mouseX, mouseY).y)/(speed*4));
      velocity.y = -(dist(position.x, position.y, view.convertCoords(mouseX, mouseY).x, view.convertCoords(mouseX, mouseY).y)*sin(radians(angle)))/(dist(position.x, position.y, view.convertCoords(mouseX, mouseY).x, view.convertCoords(mouseX, mouseY).y)/(speed*4));

      distDashed += speed*4;
      if (distDashed >= 20 || distDashed >= dist(position.x, position.y, view.convertCoords(mouseX, mouseY).x, view.convertCoords(mouseX, mouseY).y)/(speed*4)) {
        distDashed = 0;
        dashing = false;
      }
      //println(speed*4);
    }
    //---------------------------------
  }

  void moveAdvanced(ArrayList<? extends Entity> entities) {
    position.x += velocity.x * timer.timeSinceLastCall;//move the player based on time
    position.y += velocity.y * timer.timeSinceLastCall;
    int doesCollide = collisionAdvanced(entities);
    if (!(doesCollide ==  -1)) {//if it is not colliding with anything, move.
      if (entities.get(doesCollide).action.equals("ammo") ) {// if they collide with ammo, pick it up and remove it
        myPlayer.ammo += 6;
        if (myPlayer.ammo > 45) {
          myPlayer.ammo = 45;
        }
        walls.remove(doesCollide);
        entities.remove(doesCollide);
      } else if (entities.get(doesCollide).action.equals("health")) {//if thecollide with health pick it up and remove it
        myPlayer.health += 25;
        if (myPlayer.health > 100) {
          myPlayer.health = 100;
        }
        walls.remove(doesCollide);
        entities.remove(doesCollide);
      } else {//if they collide with something, move them back
        position.x -= velocity.x * timer.timeSinceLastCall;
        position.y -= velocity.y * timer.timeSinceLastCall;
      }
      while (doesCollide == -1) {// if they get stuck in something, nudge them back out the way they came
        position.x -= (velocity.x * timer.timeSinceLastCall)/20;
        position.y -= (velocity.y * timer.timeSinceLastCall)/20;
      }
      dashing = false;
      distDashed = 0;
    }
  }

  int collidingWith(ArrayList<? extends Entity> entities) {
    position.x += velocity.x * timer.timeSinceLastCall;
    position.y += velocity.y * timer.timeSinceLastCall;
    int doesCollide = collisionAdvanced(entities);
    position.x -= velocity.x * timer.timeSinceLastCall;
    position.y -= velocity.y * timer.timeSinceLastCall;
    return doesCollide;
  }

  void shoot() {
    PVector firingPos;
    firingPos = new PVector(position.x, position.y); //(position.x, position.y);// position from were they player is standing
    if ( ammo > 0 ) {// if you have ammo
      if (pistol.fire(firingPos, view.convertCoords(mouseX, mouseY), team) == true) {// fire
        ammo --;// if you fired, remove ammo
      }
    }
  }
}
