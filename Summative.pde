Timer timer;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
Player myPlayer;
Fist fist;
Pistol pistol;
Shotgun shotgun;
int gameState = 1;
ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<PImage> imageHolder = new ArrayList<PImage>();
ArrayList<String> imageHolderFilename = new ArrayList<String>();
ArrayList<Node> navPoints = new ArrayList<Node>();
View view;

void setup() {
  size(1280, 800);
  rectMode(CENTER);
  myPlayer = new Player(new PVector(width*0.75, height/2), new PVector(64, 64), new PVector(0, 0), 0.35, 0, 100, 0, 45 );
  fist = new Fist();
  pistol = new Pistol();
  shotgun = new Shotgun();
  timer = new Timer();
  view = new View(new PVector(width/2, height/2), new PVector(width, height));
  //walls.add(new Wall(new PVector(width/4, height/4), new PVector(50, 50), 0, "asd"));
  //LoadMap("testMap");
  //myPlayer.addAnimation("output.anim");
  //myPlayer.addAnimation("catAttack.anim");
  noStroke();
  generateNavpoints(new PVector(0, 0), new PVector(1000, 1000), 25);
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
  if (key == 'f') {
    if (!myPlayer.dashing) {
      keyPressed = false;
      myPlayer.dashing = true;
    }
  }
  if(key == 'e' && myPlayer.prevAnimation == -1){
    keyPressed = false;
    myPlayer.playAnimation(1,300,1);
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

void mousePressed() {
  switch(gameState) {
  case 0:
    break;
  case 1:
    if (mouseButton == LEFT) {
      myPlayer.isShooting = true;
    }
    break;
  }
}

void mouseReleased() {
  switch(gameState) {
  case 0:
    break;
  case 1:
    if (mouseButton == LEFT) {
      myPlayer.isShooting = false;
    }
    break;
  }
}
