abstract class Weapon extends NonLiving {
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

  Weapon(PVector tposition, PVector tsize, PVector tvelocity, float torientation, /* GIF STUFF*/ int tinaccuracy, int tfirerate,int tdamage,int trange) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/);
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
        deviation = new PVector(round(random(-inaccuracy, inaccuracy)), round(random(-inaccuracy, inaccuracy)));
      } else {//artifact from c++ conversion, not needed
        deviation = new PVector(0, 0);
      }
      PVector bulletVelocity;
      bulletVelocity = new PVector(cos(atan2( target.y + deviation.y - position.y, target.x + deviation.x - position.x)), sin(atan2( target.y + deviation.y - position.y, target.x + deviation.x - position.x)));
      bullets.add(new Bullet(position, new PVector(1,1), bulletVelocity, orientation, damage, team, range));
      cooldown = firerate;
    }
    if(clipSize == 0){//reload the gun if it is empty
      reload = reloadTime;
    }
    if (cooldown > 0) {// wait between shots
      cooldown -= timer.timeSinceLastCall;
    }

    if (reload > 0) {// reload the gun
      reload -= timer.timeSinceLastCall;
    }
  }
}
