class Weapon extends NonLiving {
  int inaccuracy;
  int firerate;
  int damage;
  int range;
  int clipSize;
  int reloadTime;
  ////////////
  int ammoInClip;
  ////////////
  int cooldown;// used to time the firerate
  int reload;//used to time the reload

  Weapon(PVector tposition, PVector tsize, PVector tvelocity, int tspeed, float torientation, /* GIF STUFF*/ int tinaccuracy, int tfirerate,int tdamage,int trange) {
    super(tposition, tsize, tvelocity, tspeed, torientation/*GIF STUFF*/);
    inaccuracy = tinaccuracy;
    firerate = tfirerate;
    damage = tdamage;
    range = trange;
  }

  void fire(PVector target, int team) {
    if (cooldown <= 0 && reload <= 0) {//if the gun is not reloading or waiting to fire, fire
      target = mapCoordinatesToCircle(position, 300, target);// map the target to a circle to keep the accuracy constant rather than dependant on distance to target
      PVector deviation;
      if (inaccuracy != 0) {
        deviation = new PVector(round(random(-inaccuracy, inaccuracy)));
      } else {//artifact from c++ conversion, not needed
        deviation = new PVector(0, 0);
      }
      PVector bulletVelocity;
      bulletVelocity = new PVector(cos(atan2( target.y + deviation.y - origin.y, target.x + deviation.x - origin.x)), sin(atan2( target.y + deviation.y - origin.y, target.x + deviation.x - origin.x)));
      //bullet append
      delay = firerate;
    }
    if(clipSize == 0){//reload the gun if it is empty
      reload = reloadTime;
    }
    if (cooldown > 0) {// wait between shots
      cooldown -= /*time since last call*/;
    }

    if (reload > 0) {// reload the gun
      reload -= /*time since last call*/;
    }
  }
}
