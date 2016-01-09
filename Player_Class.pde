class Player extends Living {//player class, can be used for 1 player or have multiple of them for multiple player
  boolean isMovingLeft = false;
  boolean isMovingRight = false;
  boolean isMovingUp = false;
  boolean isMovingDown = false;
  boolean isShooting = false;
  boolean dashing = false;
  float distDashed = 0;
  int equipedWeapon = 1;
  int weapon1 = 1;
  int weapon2 = 2;

  Player(PVector tposition, PVector tsize, PVector tvelocity, float tspeed, float torientation, /* GIF STUFF*/ int thealth, int tteam, int tammo) {
    super(tposition, tsize, tvelocity, tspeed, torientation, thealth, tteam, tammo);
  }

  void display() {
    orientation = atan2( position.y-view.convertCoords(mouseX, mouseY).y, position.x-view.convertCoords(mouseX, mouseY).x )*180/PI + 180;
    translate(position.x, position.y);
    rotate(radians(orientation - 90));
    rect(0, 0, size.x, size.y);
    //for(int i = 0; i < animation.size(); i++){
    if (animation.size() > currAnimation) {
      animation.get(currAnimation).position.x = 0;
      animation.get(currAnimation).position.y = 0;
      animation.get(currAnimation).display();
    }
    //}
    rotate(-radians(orientation));
    translate(-position.x, -position.y);
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
      println(speed*4);
    }
    //---------------------------------
  }

  int collisionSide(ArrayList<? extends Entity> entities, int entityID) {
    if (position.x + size.x/2 <= entities.get(entityID).position.x - entities.get(entityID).size.x/2 && position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(entityID).position.x - entities.get(entityID).size.x/2) {
      return 4; //1: Up, 2: Right, 3: Down, 4: Left
    } else if (position.x - size.x/2 >= entities.get(entityID).position.x + entities.get(entityID).size.x/2 && position.x - size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(entityID).position.x + entities.get(entityID).size.x/2) {
      return 2;
    } else if (position.y + size.y/2 <= entities.get(entityID).position.y - entities.get(entityID).size.y/2 && position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(entityID).position.y - entities.get(entityID).size.y/2) {
      return 1;
    } else if (position.y - size.y/2 >= entities.get(entityID).position.y + entities.get(entityID).size.y/2 && position.y - size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(entityID).position.y + entities.get(entityID).size.y/2) {
      return 3;
    }
    return 0;
  }

  void moveAdvanced(ArrayList<? extends Entity> entities) {
    position.x += velocity.x * timer.timeSinceLastCall;
    position.y += velocity.y * timer.timeSinceLastCall;
    int doesCollide = collisionAdvanced(entities);
    if (!(doesCollide ==  -1)) {//if it is not colliding with anything, move.
      position.x -= velocity.x * timer.timeSinceLastCall;
      position.y -= velocity.y * timer.timeSinceLastCall;
      while (doesCollide == -1) {
        position.x -= (velocity.x * timer.timeSinceLastCall)/20;
        position.y -= (velocity.y * timer.timeSinceLastCall)/20;
      }
      dashing = false;
      distDashed = 0;
    }
  }

  void shoot() {
    PVector firingPos;
    firingPos = new PVector(position.x + cos(orientation), position.y + sin(orientation ));
    if ( (weapon1 == -1 && equipedWeapon == 1) || equipedWeapon == 0) {
      fist.fire(firingPos, view.convertCoords(mouseX, mouseY), 1);
    } else if ((weapon1 == 1 && equipedWeapon == 1) || (weapon2 == 1 && equipedWeapon == 2) ) {
      pistol.fire(firingPos, view.convertCoords(mouseX, mouseY), 1);
    } else if ( (weapon1 == 2 && equipedWeapon == 1) || (weapon2 == 2 && equipedWeapon == 2) ) {
      shotgun.fire(firingPos, view.convertCoords(mouseX, mouseY), 1);
    }
  }
}
