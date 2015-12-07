class Player extends Living {//player class, can be used for 1 player or have multiple of them for multiple players
  /*weapon*/
  boolean isMovingLeft = false;
  boolean isMovingRight = false;
  boolean isMovingUp = false;
  boolean isMovingDown = false;

  Player(PVector tposition, PVector tsize, PVector tvelocity, float tspeed, float torientation, /* GIF STUFF*/ int thealth, int tteam, int tammo ) {
    super(tposition, tsize, tvelocity, tspeed, torientation, thealth, tteam, tammo);
  }

  void display() {//called to display the player along with its orientation
    rect(position.x - view.position.x, position.y - view.position.y, size.x, size.y);
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
  }
}
