class Bullet extends NonLiving{
  int damage;
  int team;
  int range;
  
  
  Bullet(PVector tposition, PVector tsize, PVector tvelocity, int tspeed, float torientation, /* GIF STUFF*/ int tdamage, int tteam, int trange) {
    super(tposition, tsize, tvelocity, tspeed, torientation/*GIF STUFF*/);
    damage = tdamage;
    team = tteam;
    range = trange;
  }
  
  boolean collideEntity(){//advanced collision for bullets as they have a high chance of ignoring objects as they move to fast
      
  }
  
}
