Timer timer;
ArrayList<Bullet> bullets;
Player myPlayer;
int gameState = 1;
ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<PImage> imageHolder = new ArrayList<PImage>();
ArrayList<String> imageHolderFilename = new ArrayList<String>();
View view;

void setup() {
  size(640, 480);
  rectMode(CENTER);
  myPlayer = new Player(new PVector(width*0.75, height/2), new PVector(32, 32), new PVector(0, 0), 0.35, 0, 100, 0, 45 );
  bullets = new ArrayList<Bullet>();
  timer = new Timer();
  view = new View(new PVector(width/2, height/2), new PVector(width, height));
  //walls.add(new Wall(new PVector(width/4, height/4), new PVector(50, 50), 0, "asd"));
  //LoadMap("floor");
  //myPlayer.animation.add(new GIFAnimator(myPlayer.position.x, myPlayer.position.y, myPlayer.size.x, myPlayer.size.y));
  //myPlayer.addAnimation("animation.anim");
  noStroke();
}

void draw() {
  background(0);
  switch(gameState) {
  case 0:
    //MAIN MENU
    break;
  case 1:
    Game();
    break;
  }
}

void keyPressed() {
  if (key == 'w') {
    myPlayer.isMovingUp = true;
  }
  if (key == 's') {
    myPlayer.isMovingDown = true;
  }
  if (key == 'a') {
    myPlayer.isMovingLeft = true;
  }
  if (key == 'd') {
    myPlayer.isMovingRight = true;
  }
  if(key == 'f'){
    if(!myPlayer.dashing){
      keyPressed = false;
      myPlayer.dashing = true;
    }
  }
}

void keyReleased() {
  if (key == 'w') {
    myPlayer.isMovingUp = false;
  }
  if (key == 's') {
    myPlayer.isMovingDown = false;
  }
  if (key == 'a') {
    myPlayer.isMovingLeft = false;
  }
  if (key == 'd') {
    myPlayer.isMovingRight = false;
  }
}
