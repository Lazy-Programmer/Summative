class Bullet extends NonLiving {
  int damage;
  int team;
  int range;
  PVector origin = new PVector(0,0);

  Bullet(PVector tposition, PVector tsize, PVector tvelocity, float torientation, /* GIF STUFF*/ int tdamage, int tteam, int trange) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/);
    damage = tdamage;
    origin.x = tposition.x;
    origin.y = tposition.y;
    team = tteam;
    range = trange;
  }

  boolean bulletCollision(ArrayList<? extends Entity> entities) {//advanced collision for bullets as they are more likely to go through objects
    for (int i = 0; i < entities.size(); i++) {
      if (( position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.y >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y <= entities.get(i).position.y + entities.get(i).size.y/2 ) || /* advanced x collision begins*/( ( /* left to right */(position.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2 && position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2) || /* right to left */ (position.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 && position.x - size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2) ) && /* begin y calculations, make sure it does pass through the y values as well */( /* start with inside the y range to outside the y range */(position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2 && /* see if it went out*/(position.y - size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y + entities.get(i).size.y/2 || position.y + size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y - entities.get(i).size.y/2)) || /* followed by out of range than in range */ ( /* testing wheather it will be in range, was done first as it was copied and adjusted from in range to out range */position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2  + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2 && /* check if it starts out of range */(position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2 || position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2)) || /* finishing off with detecting whether it goes from in range to in range */( position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2 && position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2) )) /*){*//* by range in this line I mean between values, in other words, in range for y is " pos.y >= wall.y && pos.y <= wall.y + wall.size.y" and out of range is outside thoses values*/ || /* advanced y collision begins, just copied the advanced x collision and changed "x"s to "y"s, at least thats what I hope I will do and work*/ ( ( /* up to down */(position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2 && position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2) || /* down to up */ (position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2 && position.y - size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2) ) && /* begin x calculations, make sure it does pass through the x values as well */( /* start with inside the x range to outside the x range */(position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && /* see if it went out*/(position.x - size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x + entities.get(i).size.x/2 || position.x + size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x - entities.get(i).size.x/2)) || /* followed by out of range than in range */ ( /* testing wheather it will be in range, was done first as it was copied and adjusted from in range to out range */position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2  + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2 && /* check if it starts out of range */(position.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 || position.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2)) || /* finishing off with detecting whether it goes from in range to in range */( position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2) )) ) {/* by range in this line I mean between values, in other words, in range for x is " pos.x >= wall.x && pos.x <= wall.x + wall.size.x" and out of range is outside thoses values*/
        if (entities.get(i) instanceof Living) {
          entities.get(i).health -= damage;
        }
        return true;
      }
    }
    return false;
  }

  boolean moveBullet() {//moves the entity based on its directional velocity and time since last call
    position.x += velocity.x * timer.timeSinceLastCall;
    position.y += velocity.y * timer.timeSinceLastCall;
    if (dist(origin.x, origin.y, position.x, position.y) > range) {
      return true;
    }
    return false;
  }
}
