abstract class Weapon extends NonLiving {//you cant declare a weapon but you can have a class that inherits it
  int inaccuracy;
  int firerate;
  int damage;
  int range;
  PVector bulletSize;
  int clipSize;// -1 infinite
  int reloadTime;
  float speed;
  ////////////
  int ammoInClip;// -1 infinite
  ////////////
  int cooldown;// used to time the firerate
  int reload;//used to time the reload

  Weapon(PVector tposition, PVector tsize, PVector tvelocity, float torientation, /* GIF STUFF*/ int tinaccuracy, int tfirerate, int tdamage, int trange, float tspeed, PVector tBsize) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/);
    inaccuracy = tinaccuracy;
    firerate = tfirerate;
    damage = tdamage;
    range = trange;
    speed = tspeed;
    bulletSize = tBsize;
  }
  
  void delay(){
    if (cooldown > 0) {// wait between shots
      cooldown -= timer.timeSinceLastCall;
    }
  }

  boolean fire(PVector origin, PVector target, int team) {
    if (cooldown < 1) {//if the gun is not reloading or waiting to fire, fire
      cooldown = firerate;
      target = mapCoordinatesToCircle(position, 300, target);// map the target to a circle to keep the accuracy constant rather than dependant on distance to target
      PVector deviation;
      if (inaccuracy != 0) {
        deviation = new PVector(round(random(-inaccuracy, inaccuracy)), round(random(-inaccuracy, inaccuracy)));// create a bit of inaccuracy based on the inaccuracy variable
      } else {
        deviation = new PVector(0, 0);
      }
      PVector bulletVelocity;
      bulletVelocity = new PVector(cos(atan2( target.y + deviation.y - origin.y, target.x + deviation.x - origin.x))*speed, sin(atan2( target.y + deviation.y - origin.y, target.x + deviation.x - origin.x))*speed);//create the velocity based on the speed variable and the target
      bullets.add(new Bullet(origin, bulletSize, bulletVelocity, orientation, damage, team, range));//add the new bullet to the array of bullets
      return true;
    }
    if (clipSize == 0) {//reload the gun if it is empty
      reload = reloadTime;
    }
    if (reload > 0) {// reload the gun
      reload -= timer.timeSinceLastCall;
    }
    return false;
  }
}
