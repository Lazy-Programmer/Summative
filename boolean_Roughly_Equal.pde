boolean roughlyEqual(float num1 ,float num2 ,float limit ){//two numbers you want to compare and how closely they have to be to evaluate to be true
  if(abs(num1 - num2) <= limit){
    return true;
  }
  return false;
}

boolean roughlyEqual(PVector point1, PVector point2, float limit ){//two points you want to compare and how closely they have to be to evaluate to be true
  if(dist(point1.x,point1.y, point2.x, point2.y) <= limit){
    return true;
  }
  return false;
}
