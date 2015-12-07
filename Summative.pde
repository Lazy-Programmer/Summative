Timer timer;
ArrayList<Bullet> bullets;
Player myPlayer;
int gameState = 1;
ArrayList<Wall> walls = new ArrayList<Wall>();

void setup() {
  size(640, 480);
  rectMode(CENTER);
  myPlayer = new Player(new PVector(width/2, height/2), new PVector(32, 32), new PVector(0, 0), 0.35, 0, 100, 0, 45 );
  timer = new Timer();
  walls.add(new Wall(new PVector(50,50) , new PVector(50,50) ,5));
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
  if (keyCode == UP) {
    myPlayer.isMovingUp = true;
  }
  if (keyCode == DOWN) {
    myPlayer.isMovingDown = true;
  }
  if (keyCode == LEFT) {
    myPlayer.isMovingLeft = true;
  }
  if (keyCode == RIGHT) {
    myPlayer.isMovingRight = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    myPlayer.isMovingUp = false;
  }
  if (keyCode == DOWN) {
    myPlayer.isMovingDown = false;
  }
  if (keyCode == LEFT) {
    myPlayer.isMovingLeft = false;
  }
  if (keyCode == RIGHT) {
    myPlayer.isMovingRight = false;
  }
}
