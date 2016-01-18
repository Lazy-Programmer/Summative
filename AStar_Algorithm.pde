boolean comp(Node subjectONE, Node subjectTWO) {
  return subjectONE.Fval <= subjectTWO.Fval;//if a is < b return true
}

ArrayList<Node> order(ArrayList<Node> nodes) {//used to order nodes from lowest FVal to Highest
  boolean isDone = true;
  do {
    isDone = true;
    for (int i = 0; i < nodes.size() - 1; i++) {
      if (comp(nodes.get(i), nodes.get(i + 1)) == false ) {
        Node tempONE = nodes.get(i);
        nodes.set(i, nodes.get(i + 1));//swaps the nodes, didn't have the collections imported at the time
        nodes.remove(i+1);
        nodes.add(i + 1, tempONE);
        isDone = false;
      }
    }
  } while (isDone == false);//keep looping untill you go through a loop where nothing is changed
  return nodes;
}

ArrayList<Integer> Astar(int startNode, int targetNode, ArrayList<Node> nodes) {
  int loopCount = 0;
  if (nodes.get(startNode).isPassable == true && nodes.get(targetNode).isPassable == true ) {
    ArrayList<Node> localNodes = new ArrayList<Node>();
    for (int i = 0; i < nodes.size(); i++) {
      localNodes.add(new Node(nodes.get(i).position, nodes.get(i).ID, nodes.get(i).isPassable));
      for (int j = 0; j < nodes.get(i).neighboursID.size(); j++) {
        localNodes.get(i).neighboursID.add(nodes.get(i).neighboursID.get(j));
      }
    }
    ArrayList<Node> open = new ArrayList<Node>();// create the open list
    ArrayList<Node> closed = new ArrayList<Node>();// create the closed list
    Node current;//the node being evaluated
    localNodes.get(startNode).list = 1;//set the start node list to open
    open.add(localNodes.get(startNode));//adds the start node to the open que
    current = open.get(0);// adds the first node to the current node, so it can be evaluated
    open.remove(0);//removes first node from the open list
    localNodes.get(startNode).list = 0;//set the start node list to closed
    do {// does this at least once so the list can be populated
      ArrayList<Integer> neighboursID = current.neighboursID;// gets the IDs of the current node's neighbours
      for ( int i = 0; i < neighboursID.size(); i++) {// iterates though the neighbours
        if (localNodes.get(neighboursID.get(i)).list == 0) {//checks if the node is on either the open or closed list
          localNodes.get(neighboursID.get(i)).parentNode = current.ID;//sets the parent node of the neighbours
          localNodes.get(neighboursID.get(i)).list = 1;//sets the value to indicate this node has already been seen
          if (current.position.x == localNodes.get(neighboursID.get(i)).position.x || current.position.y == localNodes.get(neighboursID.get(i)).position.y) {//evaluates wheather the node is on the horizontal or vertical axis
            localNodes.get(neighboursID.get(i)).Fval = (current.Fval + 10 + dist(current.position.x, current.position.y, localNodes.get(targetNode).position.x, localNodes.get(targetNode).position.y));//gives horizontal/vertical nodes their F value
            localNodes.get(neighboursID.get(i)).Gval = current.Fval + 10;
          } else {// for diagonal nodes
            localNodes.get(neighboursID.get(i)).Fval = (current.Fval + 14 + sqrt( pow(current.position.x - localNodes.get(targetNode).position.x, 2) +  pow(current.position.y - localNodes.get(targetNode).position.y, 2) ));//gives diagonal nodes their F value
            localNodes.get(neighboursID.get(i)).Gval = current.Fval + 14;
          }
          open.add(localNodes.get(neighboursID.get(i)));// adds the neighbours to the open list
        } else if (localNodes.get(neighboursID.get(i)).list == 1 ) {//checks if the node is on the open list
          if ( ( current.position.x == localNodes.get(neighboursID.get(i)).position.x || current.position.y == localNodes.get(neighboursID.get(i)).position.y ) && localNodes.get(neighboursID.get(i)).Gval > current.Fval + 10) {//evaluates wheather the node is on the horizontal or vertical axis and wheather this is a shorter path
            localNodes.get(neighboursID.get(i)).parentNode = current.ID;//gives the node a new parent as this path is shorter
            localNodes.get(neighboursID.get(i)).Fval = (current.Fval + 10 + sqrt( pow(current.position.x - localNodes.get(targetNode).position.x, 2) +  pow(current.position.y - localNodes.get(targetNode).position.y, 2) ));//recalculates Fval
            localNodes.get(neighboursID.get(i)).Gval = current.Fval + 10; //recalculates gval
          } else if (localNodes.get(neighboursID.get(i)).Gval > current.Fval + 14) {//  evaluates wheather this is a shorter path for diagonal nodes
            localNodes.get(neighboursID.get(i)).parentNode = current.ID;//gives the node a new parent as this path is shorter
            localNodes.get(neighboursID.get(i)).Fval = (current.Fval + 14 + sqrt( pow(current.position.x - localNodes.get(targetNode).position.x, 2) +  pow(current.position.y - localNodes.get(targetNode).position.y, 2) ));//recalculates Fval
            localNodes.get(neighboursID.get(i)).Gval = current.Fval + 14; //recalculates gval
          }
        }
      }
      order(open);//sorts the list
      closed.add(current);// add the current node to the closed list
      if (open.size() > 0) {
        current = open.get(0);//sets the current node to the node with the lowest Fval
        open.remove(0);//removes the current node from the open list
      }
      loopCount++;
      if (loopCount >= 1000) {
        ArrayList<Integer> ERROR = new ArrayList<Integer>();
        return ERROR;
      }
    } while (current.ID != targetNode);
    ArrayList<Integer> path = new ArrayList<Integer>();
    do {
      path.add(current.parentNode);
      current = localNodes.get(current.parentNode);
    } while (current.ID != startNode);
    return path;
  }
  ArrayList<Integer> ERROR = new ArrayList<Integer>();
  return ERROR;
}
