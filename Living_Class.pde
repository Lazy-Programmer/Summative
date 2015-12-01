abstract class Living extends Entity{//simply extends the Entity class, giving it health and a team
  int team;
  int ammo;
  int speed;
  /*weapon*/
  
  Living(PVector tposition, PVector tsize, PVector tvelocity, int tspeed, float torientation, /* GIF STUFF*/int thealth, int tteam, int tammo){
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/, thealth);
    team = tteam;
    ammo = tammo;
    speed = tspeed;
  }
  
}
