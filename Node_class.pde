class Node {
  int ID;
  PVector position;
  boolean isPassable;
  boolean isOccupied;
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
    if (isPathed == true) {
      fill(255, 0, 0);
    } else {
      fill(0, 255, 0);
    }
    noStroke();
    rect(position.x,position.y,3,3);
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
}
