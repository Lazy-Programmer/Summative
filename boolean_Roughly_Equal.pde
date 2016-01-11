boolean roughlyEqual(float num1 ,float num2 ,float limit ){
  if(abs(num1 - num2) <= limit){
    return true;
  }
  return false;
}

boolean roughlyEqual(PVector point1, PVector point2, float limit ){
  if(dist(point1.x,point1.y, point2.x, point2.y) <= limit){
    return true;
  }
  return false;
}
