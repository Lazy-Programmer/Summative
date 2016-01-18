PVector mapCoordinatesToCircle(PVector center, float radius, PVector point){//used to keep the accuracy of the player consistant, rather than based on how far the mouse is
  float angle;
  angle = atan2(point.y - center.y, point.x - center.x);//finds the angle between the points
  return new PVector(center.x + radius * cos(angle), center.y + radius * sin(angle));//gets the value by drawing a line with a distance of radius along the angle
}
