void ViewCones() {
  for (int i = 0; i < walls.size(); i++) {//for every wall
    ArrayList<PVector> edges = new ArrayList<PVector>();//create a list of coordinates
    if (walls.get(i).tangible == true && walls.get(i).imageIndex == 0) {//if the wall is solid and is a black wall
      PVector[] corners = {new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2), new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y - walls.get(i).size.y/2), new PVector(walls.get(i).position.x + walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2), new PVector(walls.get(i).position.x - walls.get(i).size.x/2, walls.get(i).position.y + walls.get(i).size.y/2) };//add the walls corners to the list
      boolean[] vis = {true, true, true, true};//keep track of wheather the player can see the corner or not
      for (int p2 = 0; p2 < 4; p2++) {
        for (int q1 = 0; q1 < 4; q1++) {
          for (int q2 = 0; q2 < 4; q2++) {
            if (determineIntersect(myPlayer.position, corners[p2], corners[q1], corners[q2]) == true && corners[p2] != corners[q1] && corners[p2] != corners[q2]) {//if you can NOT draw a line from the player to the corner without intersection the lines made between the other corners
              vis[p2] = false;//the player cannot see the corner
            }
          }
        }
      }
      for (int j = 0; j < 4; j++) {//for every corner
        if (vis[j] == true) { //if the player can see it
          //rect(corners[j].x, corners[j].y, 3, 3);debug rect
          fill(0, 0, 0);
          edges.add(corners[j]);//add it to the visible corner list
        }
      }
      if (edges.size() == 2) {//if only 2 corners are visible
        beginShape();
        PVector newPoint = PVector.sub(myPlayer.position, edges.get(0));//get the point that is really far away from the playerposition and the corner but on the same line
        newPoint.normalize();
        newPoint.mult(-10000);
        newPoint.add(myPlayer.position);
        vertex(newPoint.x,newPoint.y);//add that point to the shadow shape
        vertex(edges.get(0).x,edges.get(0).y);//add the corners
        vertex(edges.get(1).x,edges.get(1).y);
        newPoint = new PVector(myPlayer.position.x - edges.get(1).x, myPlayer.position.y - edges.get(1).y);//do the same with the last point
        newPoint.normalize();
        newPoint.mult(-10000);
        newPoint.add(myPlayer.position);
        vertex(newPoint.x,newPoint.y);
        endShape();
      }
      if(edges.size() == 3){// if 3 corners are visible
        int closest = 0;//find the closest point, or what it really it, the middle one
        for(int j = 0; j < 3; j++){
          if(dist(myPlayer.position.x,myPlayer.position.y, edges.get(j).x, edges.get(j).y) < dist(myPlayer.position.x,myPlayer.position.y, edges.get(closest).x, edges.get(closest).y)){//the middle one is always(as far as I can tell) the closest one, so once you find it
            closest = j;
          }
        }
        Collections.swap(edges,closest, 2);// you can put it where you want
        beginShape();
        PVector newPoint = PVector.sub(myPlayer.position, edges.get(0));//get the point that is really far away from the playerposition and the corner but on the same line
        newPoint.normalize();
        newPoint.mult(-10000);
        newPoint.add(myPlayer.position);
        vertex(newPoint.x,newPoint.y);//add that point to the shadow shape
        vertex(edges.get(0).x,edges.get(0).y);//add the corner
        vertex(edges.get(2).x,edges.get(2).y);//add the MIDDLE corner
        vertex(edges.get(1).x,edges.get(1).y);//add the last corner
        newPoint = new PVector(myPlayer.position.x - edges.get(1).x, myPlayer.position.y - edges.get(1).y);
        newPoint.normalize();
        newPoint.mult(-10000);
        newPoint.add(myPlayer.position);
        vertex(newPoint.x,newPoint.y);//do the same you did with the first point for the last point
        endShape();
      }
    }
  }
}
