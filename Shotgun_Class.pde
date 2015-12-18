class Shotgun extends Weapon {

  Shotgun() {
    super(myPlayer.position, new PVector(3, 3), new PVector(0, 0), myPlayer.orientation, 50, 500, 10, 750, 0.2, new PVector(3, 3));
  }

  void fire(PVector origin, PVector target, int team) {
    if (cooldown < 1) {// && reload <= 0) {//if the gun is not reloading or waiting to fire, fire
      for (int i = 0; i < 10; i++) {
        cooldown = firerate;
        target = mapCoordinatesToCircle(position, 300, target);//new PVector(target.x + (-25+5*i) , target.y+(-25+5*i) ));// map the target to a circle to keep the accuracy constant rather than dependant on distance to target
        /*for (int i = 0; i < 10; i++) {
         randomSeed(i);
         PVector deviation;
         PVector spread;
         spread = new PVector( 0,0);
         deviation = new PVector(random(-inaccuracy, inaccuracy), random(-inaccuracy, inaccuracy));
         PVector bulletVelocity;
         bulletVelocity = new PVector(cos(atan2( target.y + deviation.y - origin.y + spread.x, target.x + deviation.x - origin.x + spread.y))*speed, sin(atan2( target.y + deviation.y - origin.y + spread.x, target.x + deviation.x - origin.x + spread.y))*speed);
         bullets.add(new Bullet(origin, bulletSize, bulletVelocity, orientation, damage, team, range));
         }*/
        PVector deviation;
        deviation = new PVector(0, 0);
        PVector bulletVelocity;
        bulletVelocity = new PVector((cos(atan2( target.y + deviation.y - origin.y, target.x + deviation.x - origin.x) + 0.0872664626*(i-5)))*speed, (sin(atan2( target.y + deviation.y - origin.y, target.x + deviation.x - origin.x)+ 0.0872664626*(i-5) ))*speed);
       // bulletVelocity.rotate(0.0872664626*(i-5));
        //println(bulletVelocity);
        bullets.add(new Bullet(origin, bulletSize, bulletVelocity, orientation, damage, team, range));
      }
    }
    if (clipSize == 0) {//reload the gun if it is empty
      reload = reloadTime;
    }
    if (reload > 0) {// reload the gun
      reload -= timer.timeSinceLastCall;
    }
  }
}
