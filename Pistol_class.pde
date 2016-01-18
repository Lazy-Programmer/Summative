class Pistol extends Weapon {

  Pistol() {//basically a constructor class
    super(myPlayer.position, new PVector(3,3), new PVector(0, 0), myPlayer.orientation, 25, 500, 10, 1000, 3, new PVector(3,3));
  }
}
