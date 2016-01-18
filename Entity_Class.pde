abstract class Entity {
  int health;
  PVector position;
  PVector size;
  PVector velocity;
  float orientation;
  boolean tangible;
  String action;
  int team;
  boolean mobile;

  Entity(PVector tposition, PVector tsize, PVector tvelocity, float torientation /* GIF STUFF*/, int thealth) {
    position = tposition;
    size = tsize;
    velocity = tvelocity;
    orientation = torientation;
    health = thealth;
    tangible = true; //the only real exceptions are floors
    action = "  ";
  }

  void display() {
    translate(position.x, position.y);// translate to the enemy position
    rotate(radians(orientation));//rotate by the enemies rotation
    rect(0, 0, size.x, size.y);//draw a rectangle at the origin
    rotate(-radians(orientation));// unrotate
    translate(-position.x, -position.y);// untranslate
  }

  PVector collideEntity(ArrayList<? extends Entity> entities) {//default collision code, does no predictive analysis, returns the direction the entity should move to be push out of the other entity
    for ( int i = 0; i < entities.size(); i ++) {
      if (position.x + size.x/2 >= entities.get(i).position.x - entities.get(i).size.x && position.x - size.x/2 <= entities.get(i).position.x + entities.get(i).size.x/2 && position.y + size.y/2 >= entities.get(i).position.y - entities.get(i).size.y/2 && position.y - size.y/2 <= entities.get(i).position.y + entities.get(i).size.y/2) {// if the rectangle that the enemy is intersects another rectangle, you're collding
        float angle = atan2(  entities.get(i).position.y - position.y, entities.get(i).position.x - position.x )  * 180 / PI;// find the angle between the enemy and what it collided with
        return  new PVector(cos( angle * PI / 180 ), sin( angle * PI / 180 ) );//return the direction the enemy should move in to stop colliding
      }
    }
    return new PVector(0, 0);// if not colliding return 0,0
  }

  int collisionAdvanced(ArrayList<? extends Entity> entities) {//advanced collision, only returns whether or not there is a collision
    /*for (int i = 0; i < entities.size(); i++) {
     if ( (!(position.x + velocity.x + size.x/2 <= entities.get(i).position.x - entities.get(i).size.x/2 || position.x + velocity.x - size.x/2 >= entities.get(i).position.x + entities.get(i).size.x/2 || position.y + size.y/2 <= entities.get(i).position.y - entities.get(i).size.y/2 || position.y - size.y/2 >= entities.get(i).position.y + entities.get(i).size.y/2)) && entities.get(i).tangible == true && entities.get(i) != this) {
     return i;
     }
     }*/    //old Code, didn't consider rotation
    PVector PTL = new PVector(position.x-size.x/2, position.y-size.y/2);//corners of the entity
    PVector PTR = new PVector(position.x+size.x/2, position.y-size.y/2);
    PVector PBL = new PVector(position.x-size.x/2, position.y+size.y/2);
    PVector PBR = new PVector(position.x+size.x/2, position.y+size.y/2);
    PTL = new PVector( (PTL.x - position.x)*cos(radians(orientation)) - (PTL.y - position.y)*sin(radians(orientation)) + position.x, (PTL.x-position.x)*sin(radians(orientation)) + (PTL.y - position.y)*cos(radians(orientation)) + position.y );//translate the corners around their center based on the entity's rotation
    PTR = new PVector( (PTR.x - position.x)*cos(radians(orientation)) - (PTR.y - position.y)*sin(radians(orientation)) + position.x, (PTR.x-position.x)*sin(radians(orientation)) + (PTR.y - position.y)*cos(radians(orientation)) + position.y );
    PBL = new PVector( (PBL.x - position.x)*cos(radians(orientation)) - (PBL.y - position.y)*sin(radians(orientation)) + position.x, (PBL.x-position.x)*sin(radians(orientation)) + (PBL.y - position.y)*cos(radians(orientation)) + position.y );
    PBR = new PVector( (PBR.x - position.x)*cos(radians(orientation)) - (PBR.y - position.y)*sin(radians(orientation)) + position.x, (PBR.x-position.x)*sin(radians(orientation)) + (PBR.y - position.y)*cos(radians(orientation)) + position.y );
    PVector[] Ppoints = {PTL, PTR, PBL, PBR};//fill an array with the corners
    /*rect(PTL.x, PTL.y, 3, 3);//display the corners
     rect(PTR.x, PTR.y, 3, 3);
     rect(PBL.x, PBL.y, 3, 3);
     rect(PBR.x, PBR.y, 3, 3);*/
    for (int i  = 0; i < entities.size(); i++) {//check all the entities
      if (entities.get(i).tangible == true && entities.get(i) != this) {// ignore anything that isnt solid and ignore yourself
        PVector origin = entities.get(i).position;//point from which the entity in question will have it corners rotated around
        float theta = entities.get(i).orientation;//the orientation of the entity
        PVector TL = new PVector(entities.get(i).position.x - entities.get(i).size.x/2, entities.get(i).position.y - entities.get(i).size.y/2);// get the corners of the entity
        PVector TR = new PVector(entities.get(i).position.x + entities.get(i).size.x/2, entities.get(i).position.y - entities.get(i).size.y/2);
        PVector BL = new PVector(entities.get(i).position.x - entities.get(i).size.x/2, entities.get(i).position.y + entities.get(i).size.y/2);
        PVector BR = new PVector(entities.get(i).position.x + entities.get(i).size.x/2, entities.get(i).position.y + entities.get(i).size.y/2);
        TL = new PVector( (TL.x - origin.x)*cos(radians(theta)) - (TL.y - origin.y)*sin(radians(theta)) + origin.x, (TL.x-origin.x)*sin(radians(theta)) + (TL.y - origin.y)*cos(radians(theta)) + origin.y );//translate thoses corners around the origin
        TR = new PVector( (TR.x - origin.x)*cos(radians(theta)) - (TR.y - origin.y)*sin(radians(theta)) + origin.x, (TR.x-origin.x)*sin(radians(theta)) + (TR.y - origin.y)*cos(radians(theta)) + origin.y );
        BL = new PVector( (BL.x - origin.x)*cos(radians(theta)) - (BL.y - origin.y)*sin(radians(theta)) + origin.x, (BL.x-origin.x)*sin(radians(theta)) + (BL.y - origin.y)*cos(radians(theta)) + origin.y );
        BR = new PVector( (BR.x - origin.x)*cos(radians(theta)) - (BR.y - origin.y)*sin(radians(theta)) + origin.x, (BR.x-origin.x)*sin(radians(theta)) + (BR.y - origin.y)*cos(radians(theta)) + origin.y );
        /*
        rect(TL.x, TL.y, 3, 3);//display the points
         rect(TR.x, TR.y, 3, 3);
         rect(BL.x, BL.y, 3, 3);
         rect(BR.x, BR.y, 3, 3);
         */
        PVector[] points = {TL, TR, BL, BR};// put the points in a vector
        for (int p1 = 0; p1 < 4; p1++) {
          for (int p2 = 0; p2 < 4; p2++) {
            for (int p3 = 0; p3 < 4; p3++) {
              for (int p4 = 0; p4 < 4; p4++) {
                if ( Ppoints[p1] != Ppoints[p2] && points[p3] != points[p4] && determineIntersect(Ppoints[p1], Ppoints[p2], points[p3], points[p4]) == true) {//providing none of the points are the same, do the lines drawn between the corners of the entity intersect thoses ofthe other entity
                  return i;
                }
              }
            }
          }
        }
      }
    }
    return -1;// if it does not intersect anything, return -1
  }

  void move() {//moves the entity based on its directional velocity and time since last call
    position.x += velocity.x * timer.timeSinceLastCall;
    position.y += velocity.y * timer.timeSinceLastCall;
  }
}
