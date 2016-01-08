void generateNavpoints(PVector areaPos, PVector areaSize, int granularity){// ported from C++ code, could be generated by the level editor, but I already had this code lying around so why not
  for(float x = areaPos.x; x <= areaSize.x; x += granularity){
    for(float y = areaPos.y; y <= areaSize.y; y += granularity){
      navPoints.add(new Node(new PVector(x, y)));
    }
  }  
  for(int i = 0; i < walls.size(); i++){
    for(int j = 0; j < navPoints.size(); j++){
      if(navPoints.get(j).position.x + 10 >= navPoints.get(i).position.x && navPoints.get(j).position.x - 10 <= walls.get(i).position.x + walls.get(i).size.x && navPoints.get(j).position.y + 10 >= walls.get(i).position.y && navPoints.get(j).position.y - 10 <= walls.get(i).position.y + walls.get(i).size.y){
        navPoints.get(j).isPassable = false;
      }
    }
  }
  for(int i = 0; i < navPoints.size(); i++){
    navPoints.get(i).ID = i;
  }
  
  for(int i = 0; i < navPoints.size(); i++){
    for( int j = 0; j < navPoints.size(); j++){
      if(( /*start with adding the adjacent ones on the x axis*/ ( (navPoints.get(i).position.x - granularity == navPoints.get(j).position.x || navPoints.get(i).position.x + granularity == navPoints.get(j).position.x) && navPoints.get(i).position.y == navPoints.get(j).position.y ) || /* then the adjacent ones on the y axis */ ( (navPoints.get(i).position.y - granularity == navPoints.get(j).position.y || navPoints.get(i).position.y + granularity == navPoints.get(j).position.y) && navPoints.get(i).position.x == navPoints.get(j).position.x ) || /* add the point diagonal neigbours */ ( ((navPoints.get(i).position.x + granularity == navPoints.get(j).position.x) || (navPoints.get(i).position.x - granularity == navPoints.get(j).position.x)) && ( navPoints.get(i).position.y - granularity == navPoints.get(j).position.y || navPoints.get(i).position.y + granularity == navPoints.get(j).position.y) ) ) && (navPoints.get(i).isPassable == true && navPoints.get(j).isPassable == true)){
        navPoints.get(i).neighboursID.add(navPoints.get(j).ID);
      }
    }
  }
}