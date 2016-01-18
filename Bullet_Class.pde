class Bullet extends NonLiving {
  int damage;
  int team;
  int range;
  PVector origin = new PVector(0, 0);

  Bullet(PVector tposition, PVector tsize, PVector tvelocity, float torientation, /* GIF STUFF*/ int tdamage, int tteam, int trange) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/);
    damage = tdamage;
    origin.x = tposition.x;
    origin.y = tposition.y;
    team = tteam;
    range = trange;
  }

  boolean bulletCollision(ArrayList<? extends Entity> entities) {//advanced collision for bullets as they are more likely to go through objects
    //for (int i = 0; i < entities.size(); i++) {
    //if(tangible == true && team != entities.get(i).team && ( ( position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.y >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y <= entities.get(i).position.y + entities.get(i).size.y/2 ) || /* advanced x collision begins*/    ( ( /* left to right */(position.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2 && position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2) || /* right to left */ (position.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 && position.x - size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2) ) && /* begin y calculations, make sure it does pass through the y values as well */( /* start with inside the y range to outside the y range */(position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2 && /* see if it went out*/(position.y - size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y + entities.get(i).size.y/2 || position.y + size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y - entities.get(i).size.y/2)) || /* followed by out of range than in range */ ( /* testing wheather it will be in range, was done first as it was copied and adjusted from in range to out range */position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2  + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2 && /* check if it starts out of range */(position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2 || position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2)) || /* finishing off with detecting whether it goes from in range to in range */( position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2 && position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2) )) /*){*//* by range in this line I mean between values, in other words, in range for y is " pos.y >= wall.y && pos.y <= wall.y + wall.size.y" and out of range is outside thoses values*/ || /* advanced y collision begins, just copied the advanced x collision and changed "x"s to "y"s, at least thats what I hope I will do and work*/ ( ( /* up to down */(position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2 && position.y + size.y/2 + velocity.y*timer.timeSinceLastCall >= entities.get(i).position.y - entities.get(i).size.y/2) || /* down to up */ (position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2 && position.y - size.y/2 + velocity.y*timer.timeSinceLastCall <= entities.get(i).position.y + entities.get(i).size.y/2) ) && /* begin x calculations, make sure it does pass through the x values as well */( /* start with inside the x range to outside the x range */(position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && /* see if it went out*/(position.x - size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x + entities.get(i).size.x/2 || position.x + size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x - entities.get(i).size.x/2)) || /* followed by out of range than in range */ ( /* testing wheather it will be in range, was done first as it was copied and adjusted from in range to out range */position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2  + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2 && /* check if it starts out of range */(position.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 || position.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2)) || /* finishing off with detecting whether it goes from in range to in range */( position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.x + size.x/2 + velocity.x*timer.timeSinceLastCall >= entities.get(i).position.x - entities.get(i).size.x/2 && position.x - size.x/2 + velocity.x*timer.timeSinceLastCall <= entities.get(i).position.x + entities.get(i).size.x/2) )) )) {/* by range in this line I mean between values, in other words, in range for x is " pos.x >= wall.x && pos.x <= wall.x + wall.size.x" and out of range is outside thoses values*/
    /*  if (entities.get(i) instanceof Living) {
     entities.get(i).health -= damage;
     }
     return true;
     }
     }*/
    PVector prevPos = new PVector(position.x - velocity.x*timer.timeSinceLastCall, position.y - velocity.y*timer.timeSinceLastCall);// determines where the bullet was last
    for (int i  = 0; i < entities.size(); i++) {// check all the things that exist the the 2d plane
      if (entities.get(i).tangible == true && entities.get(i).action.equals("ammo") == false && entities.get(i).action.equals("health") == false) {//if the entity has collision but is not a health pack or ammo pack continue otherwise ignore them
        PVector origin = entities.get(i).position;// the point which all the other points of that entity rotate around
        float theta = entities.get(i).orientation;// the angle in degrees of the rotation
        PVector TL = new PVector(entities.get(i).position.x - entities.get(i).size.x/2, entities.get(i).position.y - entities.get(i).size.y/2);//get the coordinates of the corners of the entity while not rotated
        PVector TR = new PVector(entities.get(i).position.x + entities.get(i).size.x/2, entities.get(i).position.y - entities.get(i).size.y/2);
        PVector BL = new PVector(entities.get(i).position.x - entities.get(i).size.x/2, entities.get(i).position.y + entities.get(i).size.y/2);
        PVector BR = new PVector(entities.get(i).position.x + entities.get(i).size.x/2, entities.get(i).position.y + entities.get(i).size.y/2);
        TL = new PVector( (TL.x - origin.x)*cos(radians(theta)) - (TL.y - origin.y)*sin(radians(theta)) + origin.x, (TL.x-origin.x)*sin(radians(theta)) + (TL.y - origin.y)*cos(radians(theta)) + origin.y );//rotate the corners of the entity reletive to it's center
        TR = new PVector( (TR.x - origin.x)*cos(radians(theta)) - (TR.y - origin.y)*sin(radians(theta)) + origin.x, (TR.x-origin.x)*sin(radians(theta)) + (TR.y - origin.y)*cos(radians(theta)) + origin.y );
        BL = new PVector( (BL.x - origin.x)*cos(radians(theta)) - (BL.y - origin.y)*sin(radians(theta)) + origin.x, (BL.x-origin.x)*sin(radians(theta)) + (BL.y - origin.y)*cos(radians(theta)) + origin.y );
        BR = new PVector( (BR.x - origin.x)*cos(radians(theta)) - (BR.y - origin.y)*sin(radians(theta)) + origin.x, (BR.x-origin.x)*sin(radians(theta)) + (BR.y - origin.y)*cos(radians(theta)) + origin.y );
        PVector[] points= {TL, TR, BL, BR};// fill an array with the points
        for (int p1 = 0; p1 < 4; p1++) {
          for (int p2 = 0; p2 < 4; p2++) {
            if ( points[p1] != points[p2] && determineIntersect(position, prevPos, points[p1], points[p2]) == true ) {// if when you draw a line between the bullets current position and its past position it intersects a line drawn between the rotated points of an entity, then you hit that entity
              if (entities.get(i) instanceof Living && team != entities.get(i).team) {//if the entity is part of the living subclass
                entities.get(i).health -= damage;//subtract the bullets damage value
                return true;//if you hit something return true
              } else if (entities.get(i) instanceof Wall) {
                return true;//if you hit something return true
              }
            }
          }
        }
      }
    }
    return false;// if you did not hit anything return false
  }

  boolean moveBullet(ArrayList<? extends Entity> entities) {//moves the entity based on its directional velocity and time since last call
    position.x += velocity.x * timer.timeSinceLastCall;// moves the bullet based on how long its been since this was called
    position.y += velocity.y * timer.timeSinceLastCall;
    if (dist(origin.x, origin.y, position.x, position.y) > range || bulletCollision(entities) == true) {//if the bullet has travelled its range or hit something
      return true;// return true so you can be deleted
    }
    return false;// otherwise keep existing
  }

  void display() {
    translate(position.x, position.y);// acts the exact same as a bullet but has a sprite following it
    rotate(radians(orientation-90));
    fill(0);
    rect(0, 0, 2, 2);
    rotate(-radians(orientation-90));
    translate(-position.x, -position.y);
  }
}

class feather extends Bullet {

  feather(PVector tposition, PVector tvelocity, float torientation) {
    super(tposition, new PVector(9, 29), tvelocity, torientation, int(random(3, 6)), 2, 1000);
  }


  void display() {
    translate(position.x, position.y);// acts the exact same as a bullet but has a sprite following it
    rotate(radians(orientation-90));
    imageMode(CENTER);
    image(featherBullet, 0, 0);
    imageMode(CORNER);
    rotate(-radians(orientation-90));
    translate(-position.x, -position.y);
  }
};
