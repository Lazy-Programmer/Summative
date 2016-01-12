Timer timer;
Player myPlayer;
Birb_Enemy dummy;
Cat_Enemy dumber;
Fist fist;
Pistol pistol;
Shotgun shotgun;
int gameState = 0;
boolean displayingText = false;
PImage textBox;
Text textBoxText;
PFont techFont; //subject to change
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<PImage> imageHolder = new ArrayList<PImage>();
ArrayList<String> imageHolderFilename = new ArrayList<String>();
ArrayList<Node> navPoints = new ArrayList<Node>();
View view;
PImage title;
PImage menuButton;
PImage healthBar;
ImageButton play;
PFont furore;

void setup() {
  size(1280, 800);
  rectMode(CENTER);
  myPlayer = new Player(new PVector(width*0.75, height/2), new PVector(32, 44), new PVector(0, 0), 0.35, 0, 100, 0, 45 );
  dummy = new Birb_Enemy(new PVector(75, 50), 0);
  dumber = new Cat_Enemy(new PVector(50, 50), 0);
  fist = new Fist();
  pistol = new Pistol();
  shotgun = new Shotgun();
  timer = new Timer();
  view = new View(new PVector(width/2, height/2), new PVector(width, height));
  title = loadImage("data/Images/UI/update2.png");
  title.resize(title.width*width/750, title.height*width/750);
  menuButton = loadImage("data/Images/UI/menuButton.png");
  healthBar = loadImage("data/Images/UI/HP_bar.png");
  healthBar.resize(healthBar.width*width/1280, healthBar.height*height/800);
  play = new ImageButton(width/2 - menuButton.width*width/1000/2, height/2 - menuButton.height*width/1000/2, menuButton.width*width/1000, menuButton.height*width/1000, menuButton, "Play");
  furore = createFont("data/Images/Fonts/Furore.otf", 128);
  textFont(furore);
  // walls.add(new Wall( new PVector(400,50), new PVector(300,50),0,"asd"));
  // walls.add(new Wall(new PVector(500, -15), new PVector(1015, 10), 0, "asd"));
  // walls.add(new Wall(new PVector(-15, 500), new PVector(10, 1015), 0, "asd"));
  // walls.add(new Wall(new PVector(500, 1015), new PVector(1015, 10), 0, "asd"));
  // walls.add(new Wall(new PVector(1015, 500), new PVector(10, 1015), 0, "asd"));
  // walls.add(new Wall(new PVector(500, 100 ), new PVector(800, 10), 0, "asd"));
  //LoadMap("floor");
  myPlayer.addAnimation("data/Animations/MainCharacterWalk.anim");
  myPlayer.addAnimation("data/Animations/MainCharacterShootingStanding.anim");
  myPlayer.addAnimation("data/Animations/MainCharacterShootingWalking.anim");
  dummy.addAnimation("data/Animations/BirbWalking.anim");
  noStroke();
  generateNavpoints(new PVector(0, 0), new PVector(1000, 1000), 25);
}

void draw() {
  background(0);
  switch(gameState) {
  case 0:
    MainMenu();
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
    //myPlayer.playAnimation(1, 300, 1);
    /*textBoxText = new Text("hello this is a long sentence that should break the bounderies of the text box. Continuing to write more stuff so that it will run off of the bottom of the black screen. iduhfiaudfhiud haiusdh aiudh aiud hasidu haisud hasidu hasiudah sidua hi.", new PVector(width*0.25,height*0.76), 24, int(width*0.52));
    if(displayingText){
      displayingText = false;
    }else{
      displayingText = true;
    }*/
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
    if (play.clicked() == true && mouseButton == LEFT) {
      gameState = 1;
    }
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
