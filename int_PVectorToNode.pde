int PVectorToNode(PVector subject) {//takes a coordinate and returns the closest node
  int closestID = 1;//set the closest node to 1
  for (int i = 0; i < navPoints.size(); i++) {
    if ( dist(subject.x,subject.y,navPoints.get(i).position.x, navPoints.get(i).position.y) < dist(subject.x,subject.y, navPoints.get(closestID).position.x, navPoints.get(closestID).position.y) && navPoints.get(i).isPassable == true) {//is the current node closer than the current leader?
      closestID = navPoints.get(i).ID;//then set the current node to be the leader
    }
  }
  return closestID;//return the leader
}
