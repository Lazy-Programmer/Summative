abstract class Enemy extends Living {
  int alertState = 0;// used for tracking where it is in its AI 
  PVector target;// where to travel to
  boolean isAlert = false;//once it has seen the player don't stop the chase
  ArrayList<Integer> path = new ArrayList<Integer>();// the list of nodes to travel to
  int delay = 100;// used to prevent the enemy from pathfinding on each frame

  Enemy(PVector tposition, PVector tsize, float tspeed, float torientation, int thealth, int tteam) {
    super(tposition, tsize, new PVector(0, 0), tspeed, torientation, thealth, tteam, -1);
  }

  boolean see(PVector subject) {//basic sight
    boolean isVisionNotBlocked = true;
    for ( int i = 0; i < walls.size(); i++) {
      if (walls.get(i).tangible == true && walls.get(i).imageIndex == 0) {// ignor anything that is not a solid wall that does nothing
        PVector wallCornerTopLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);//get the corners of the wall
        PVector wallCornerTopRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
        PVector wallCornerBottomLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
        PVector wallCornerBottomRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
        if (determineIntersect(new PVector(position.x, position.y), subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(new PVector(position.x, position.y), subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( new PVector(position.x, position.y), subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(new PVector(position.x, position.y), subject, wallCornerTopLeft, wallCornerTopRight) == true) {//draw a line between the enemy and player, if the line does not intersect any of the lines drawn between the wall's corners then you can see the player
          isVisionNotBlocked = false;
        }
      }
    }
    return isVisionNotBlocked;
  }

  boolean collisionSee(PVector subject) {//advanced sight
    boolean isVisionNotBlocked = true;
    PVector topLeft = new PVector(position.x - size.x/2, position.y - size.y/2);//get the corners of the enemy
    PVector topRight = new PVector(position.x + size.x/2, position.y - size.y/2);
    PVector bottomLeft = new PVector(position.x - size.x/2, position.y + size.y/2);
    PVector bottomRight = new PVector(position.x + size.x/2, position.y + size.y/2);
    for ( int i = 0; i < walls.size(); i++) {
      if (walls.get(i).tangible == true) {
        PVector wallCornerTopLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);//get the corners of the walls
        PVector wallCornerTopRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2);
        PVector wallCornerBottomLeft = new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
        PVector wallCornerBottomRight = new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2);
        if (determineIntersect(topLeft, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(topLeft, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( topLeft, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(topLeft, subject, wallCornerTopLeft, wallCornerTopRight) == true) {// can you draw a line from all of the enemies corners to your target without intersecting any of the lines drawn between the corners of the walls, if so return true
          isVisionNotBlocked = false;
        } else if (determineIntersect(topRight, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(topRight, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( topRight, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(topRight, subject, wallCornerTopLeft, wallCornerTopRight) == true) {
          isVisionNotBlocked = false;
        } else if (determineIntersect(bottomLeft, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(bottomLeft, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( bottomLeft, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(bottomLeft, subject, wallCornerTopLeft, wallCornerTopRight) == true) {
          isVisionNotBlocked = false;
        } else if (determineIntersect(bottomRight, subject, wallCornerTopLeft, wallCornerBottomLeft) == true ||/**/ determineIntersect(bottomRight, subject, wallCornerTopRight, wallCornerBottomRight) == true || /**/ determineIntersect( bottomRight, subject, wallCornerBottomLeft, wallCornerBottomRight) == true /**/ || determineIntersect(bottomRight, subject, wallCornerTopLeft, wallCornerTopRight) == true) {
          isVisionNotBlocked = false;
        }
      }
    }
    return isVisionNotBlocked;
  }

  void pathFind() {// this is called rather than Astar to check if the cooldown has expired, in other words in only path finds when more than 100 ms has passed to increase performance, as pathfinding for 20+ enemies at the same time is demanding
    if (delay > 0) {//if the cooldown is not done
      delay -= timer.timeSinceLastCall;// subtract the time passed
    }
    if (delay <= 0) {// if the cooldown is done
      path = Astar(PVectorToNode(position), PVectorToNode(myPlayer.position), navPoints);//pathfind and reset the cooldown
      delay = 100;
    }
  }

  void moveToTarget() {// move directly towards your target
    float angle = atan2( ( target.y - position.y ), ( target.x - position.x ) ) * 180 / PI;// find the angle
    velocity.x = speed * cos( angle * PI / 180 );//determine your velocity in this direction based on the angle
    velocity.y = speed * sin( angle * PI / 180 );
  }// I just realized I convert the angle to degrees from radians, and then back to radians

  abstract void enemyAI();//all enemies must think

  abstract void attack();// all enemies must attack
}
