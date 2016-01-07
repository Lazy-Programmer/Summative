int PVectorToNode(PVector subject) {
  int closestID = 1;
  for (int i = 0; i < navPoints.size(); i++) {
    if ( ( sqrt( pow( (navPoints.get(i).position.x - subject.x), 2) + pow((navPoints.get(i).position.y - subject.y), 2)) < sqrt( pow(navPoints.get(closestID).position.x - subject.x, 2) + pow((navPoints.get(closestID).position.y - subject.y), 2) ) ) && navPoints.get(i).isPassable == true) {
      closestID = navPoints.get(i).ID;
    }
  }
  return closestID;
}
