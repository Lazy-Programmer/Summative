class Living extends Entity{//simply extends the Entity class, giving it health and a team
  int health;
  int team;
  int ammo;
  /*weapon*/
  
  Living(PVector tposition, PVector tsize, PVector tvelocity, int tspeed, float torientation, /* GIF STUFF*/){
    super(tposition, tsize, tvelocity, tspeed, torientation/*GIF STUFF*/);
    health = thealth;
    team = tteam;
  }
  
}
