abstract class Living extends Entity {//simply extends the Entity class, giving it health and a team
  int ammo;
  float speed;
  int currAnimation;
  int prevAnimation;
  float animationTime;
  boolean charging;
  ArrayList <GIFAnimator> animation;

  Living(PVector tposition, PVector tsize, PVector tvelocity, float tspeed, float torientation, /* GIF STUFF*/int thealth, int tteam, int tammo) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/, thealth);
    team = tteam;
    ammo = tammo;
    speed = tspeed;
    animationTime = -1.0;
    currAnimation = 0;
    prevAnimation = -1;
    charging = false;
    animation = new ArrayList<GIFAnimator>();
  }

  void addAnimation(String filepath){
    animation.add(new GIFAnimator(position.x, position.y, size.x, size.y));
    if(animation.size() > 0){
      loadGif(animation.get(animation.size() - 1), filepath);
    }
    currAnimation = 0;
  }
  
  void playAnimation(int index, float timeMills){
    if(index < animation.size()){
      animation.get(index).index = 0;
      prevAnimation = currAnimation;
      currAnimation = index;
      animationTime = timeMills;
    }
  }
  
  void playAnimation(int index, float timeMills, int stall){
    if(index < animation.size()){
      animation.get(index).index = animation.get(index).slides.size() - 1;
      prevAnimation = currAnimation;
      currAnimation = index;
      animationTime = timeMills;
      if(stall < animation.get(index).slides.size()){
        animation.get(index).stall = stall;
      }
    }
  }
  
}
