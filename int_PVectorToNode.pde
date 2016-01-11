int PVectorToNode(PVector subject) {
  int closestID = 1;
  for (int i = 0; i < navPoints.size(); i++) {
    if ( dist(subject.x,subject.y,navPoints.get(i).position.x, navPoints.get(i).position.y) < dist(subject.x,subject.y, navPoints.get(closestID).position.x, navPoints.get(closestID).position.y) && navPoints.get(i).isPassable == true) {
      closestID = navPoints.get(i).ID;
    }
  }
  return closestID;
}
