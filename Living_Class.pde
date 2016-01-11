abstract class Living extends Entity {//simply extends the Entity class, giving it health and a team
  int ammo;
  float speed;
  int currAnimation;
  boolean charging;
  ArrayList <GIFAnimator> animation;
  
  Living(PVector tposition, PVector tsize, PVector tvelocity, float tspeed, float torientation, /* GIF STUFF*/int thealth, int tteam, int tammo) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/, thealth);
    team = tteam;
    ammo = tammo;
    speed = tspeed;
    currAnimation = 0;
    charging = false;
    animation = new ArrayList<GIFAnimator>();
  }
  
  void addAnimation(String filepath){
    if(animation.size() > 0){
      loadGif(animation.get(0), filepath);
    }
  }
}
