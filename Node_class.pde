class Node {//just a utility class to hold data
  int ID;
  PVector position;
  boolean isPassable;
  ArrayList<Integer> neighboursID = new ArrayList<Integer>();
  float Gval;
  float Fval;
  int list;
  int parentNode;
  boolean isPathed = false;

  Node() {
    Fval = 0;
    list = 0;
    Gval = 0;
  }

  void display() {
    if (isPassable == true) {//used for AI debug
      fill(255, 0, 0);
    } else {
      fill(0, 255, 0);
    }
    noStroke();
    rect(position.x, position.y, 3, 3);
  }

  Node(PVector tposition) {
    Fval = 0;
    list = 0;
    Gval = 0;
    position = tposition;
    isPassable = true;
  }

  Node(PVector tposition, int tID ) {
    position = tposition;
    ID = tID;
    isPassable = true;
    Fval = 0;
    list = 0;
    Gval = 0;
  }

  Node(PVector tposition, int tID, boolean passibility) {
    position = tposition;
    ID = tID;
    isPassable = passibility;
    Fval = 0;
    list = 0;
    Gval = 0;
  }

  /*void refresh() {
    boolean newValue = true;
    for (int i = 0; i < walls.size(); i++) {
      if (walls.get(i).tangible == true && position.x + 30 >= walls.get(i).position.x  - walls.get(i).size.x/2 && position.x - 30 <= walls.get(i).position.x + walls.get(i).size.x/2 && position.y + 30 >= walls.get(i).position.y - walls.get(i).size.y/2 && position.y - 30 <= walls.get(i).position.y + walls.get(i).size.y/2) {
        newValue = false;
      }
    }
    isPassable = newValue;
  }*/
}
