abstract class Entity {
  int health;
  PVector position;
  PVector size;
  PVector velocity;
  float orientation;
  //GIF STUFF

  Entity(PVector tposition, PVector tsize, PVector tvelocity, float torientation /* GIF STUFF*/, int thealth) {
    position = tposition;
    size = tsize;
    velocity = tvelocity;
    orientation = torientation;
    health = thealth;
  }

  void display() {//default display method, should only be called when a child does not have its own yet or it encounters an error
    rect(position.x - view.position.x, position.y - view.position.y, size.x, size.y);
  }

  PVector collideEntity(ArrayList<? extends Entity> entities) {//default collision code, does no predictive analysis, returns the direction the entity should move to be push out of the other entity
    for ( int i = 0; i < entities.size(); i ++) {
      if (position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2) {
        float angle = atan2(  entities.get(i).position.y - position.y, entities.get(i).position.x - position.x )  * 180 / PI;
        return  new PVector(cos( angle * PI / 180 ), sin( angle * PI / 180 ) );
      }
    }
    return new PVector(0, 0);
  }

  int collisionAdvanced(ArrayList<? extends Entity> entities) {//advanced collision, only returns whether or not there is a collision
    for (int i = 0; i < entities.size(); i++) {
      if (( position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.y >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y <= entities.get(i).position.y + entities.get(i).size.y/2 ) || /* advanced x collision begins*/( ( /* left to right */(position.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2 && position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2) || /* right to left */ (position.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 && position.x - size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2) ) && /* begin y calculations, make sure it does pass through the y values as well */( /* start with inside the y range to outside the y range */(position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2 && /* see if it went out*/(position.y - size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y + entities.get(i).size.y/2 || position.y + size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y - entities.get(i).size.y/2)) || /* followed by out of range than in range */ ( /* testing wheather it will be in range, was done first as it was copied and adjusted from in range to out range */position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2  + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2 && /* check if it starts out of range */(position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2 || position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2)) || /* finishing off with detecting whether it goes from in range to in range */( position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2 && position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2) )) /*){*//* by range in this line I mean between values, in other words, in range for y is " pos.y >= wall.y && pos.y <= wall.y + wall.size.y" and out of range is outside thoses values*/ || /* advanced y collision begins, just copied the advanced x collision and changed "x"s to "y"s, at least thats what I hope I will do and work*/ ( ( /* up to down */(position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2 && position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2) || /* down to up */ (position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2 && position.y - size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2) ) && /* begin x calculations, make sure it does pass through the x values as well */( /* start with inside the x range to outside the x range */(position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && /* see if it went out*/(position.x - size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x + entities.get(i).size.x/2 || position.x + size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x - entities.get(i).size.x/2)) || /* followed by out of range than in range */ ( /* testing wheather it will be in range, was done first as it was copied and adjusted from in range to out range */position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2  + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2 && /* check if it starts out of range */(position.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 || position.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2)) || /* finishing off with detecting whether it goes from in range to in range */( position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2) )) ) {/* by range in this line I mean between values, in other words, in range for x is " pos.x >= wall.x && pos.x <= wall.x + wall.size.x" and out of range is outside thoses values*/
        return i;
      }
    }
    return -1;
  }

  void move() {//moves the entity based on its directional velocity and time since last call
    position.x += velocity.x * timer.timeSinceLastCall;
    position.y += velocity.y * timer.timeSinceLastCall;
  }
}
