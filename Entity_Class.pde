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
    translate(position.x,position.y);
    rotate(radians(orientation));
    rect(0,0, size.x, size.y);
    rotate(-radians(orientation));
    translate(-position.x,-position.y);
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
     if(!(position.x + velocity.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2 || position.x + velocity.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 || position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2 || position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2)){
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
