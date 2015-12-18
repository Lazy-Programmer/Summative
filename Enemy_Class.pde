class Enemy extends Living {
  int alertState = 0;
  int Objective;

  Enemy(PVector tposition, PVector tsize, PVector tvelocity, float tspeed, float torientation, int thealth, int tteam, int tammo) {
    super(tposition, tsize, tvelocity, tspeed, torientation, thealth, tteam, tammo);
  }

  void calculateVelocity() {
  }

  void pathFind() {
  }
  
  int getNode(){
    return 1;
  }

  void enemyAI() {
    switch(alertState) {
    case 0:
      
      //code to walk around idly
      break;
    case 1:
      //code to investigate
      break;
      case 2:
      //code to search
      break;
      case 3:
      //code to attack the player
      break;
    }
  }
}
