////////////////////////////////////////////////////////////////////////
//                         UPDATE 2.0                                 //
//        Kaleb Mannion, Solomon Davidson, Cindy Huang                //
////////////////////////////////////////////////////////////////////////


import ddf.minim.*;
import java.util.Collections;//used for the swap function

Timer timer;
Player myPlayer;
//Birb_Enemy dummy;
//Cat_Enemy dumber;
//Fist fist;
Pistol pistol;
//Shotgun shotgun;
int gameState = -1;
boolean displayingText = false;
PImage textBox;
Text textBoxText;
ArrayList<Cat_Enemy> cats = new ArrayList<Cat_Enemy>();
ArrayList<Birb_Enemy> birbs = new ArrayList<Birb_Enemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<PImage> imageHolder = new ArrayList<PImage>();
ArrayList<String> imageHolderFilename = new ArrayList<String>();
ArrayList<Node> navPoints = new ArrayList<Node>();
ArrayList<String> imagesLoaded = new ArrayList<String>();//keep the names of the images already loaded
View view;
PImage title;
PImage menuButton;
PImage healthBar;
PImage ammoBar;
PImage featherBullet;
ImageButton play;
ImageButton retry;
ImageButton returntoMenu;
PFont furore;
Minim minim;
AudioPlayer menuTheme;
AudioPlayer gameTheme;
AudioPlayer playerGunFire;
AudioPlayer textClick;
int[] introSequenceTimer = {0, 0, 255, 0, 255, 255};
int logotimer;
boolean isStarted = false;
PImage logo;

void setup() {
  //size(1280, 800, P2D);
  fullScreen(P2D);
  smooth(2);
  background(0);
  logo = loadImage("data/Images/Logo/Logo.png");
  image(logo, width/2 - logo.width/2, height/2-logo.height/2);
  minim = new Minim(this);
  menuTheme = minim.loadFile("data/Music/Update2Theme.mp3");
  menuTheme.play();
  menuTheme.loop();
  menuTheme.setLoopPoints(0, menuTheme.length());
  gameTheme = minim.loadFile("data/Music/levelThemeMusicUpdate2.mp3");
  gameTheme.setLoopPoints(0, gameTheme.length());
  playerGunFire = minim.loadFile("data/Music/SFX/pistolShot.mp3");
  textClick = minim.loadFile("data/Music/SFX/click.mp3");
  rectMode(CENTER);
  myPlayer = new Player(new PVector(width*0.1, height*0.25), new PVector(32, 44), new PVector(0, 0), 0.35, 0, 100, 0, 45 );
  // dummy = new Birb_Enemy(new PVector(75, 50), 0);
  //dumber = new Cat_Enemy(new PVector(50, 50), 45);
  textBox = loadImage(sketchPath("data/Images/UI/textBox.png"));
  //fist = new Fist();
  pistol = new Pistol();
  //shotgun = new Shotgun();
  timer = new Timer();
  view = new View(new PVector(width/2, height/2), new PVector(width, height));
  title = loadImage("data/Images/UI/update2.png");
  title.resize(title.width*width/750, title.height*width/750);
  menuButton = loadImage("data/Images/UI/menuButton.png");
  healthBar = loadImage("data/Images/UI/HP_bar.png");
  healthBar.resize(healthBar.width*width/1280, healthBar.height*height/800);
  ammoBar = loadImage("data/Images/UI/Ammo_bar.png");
  ammoBar.resize(ammoBar.width*width/1280, healthBar.height*height/800);
  featherBullet = loadImage("data/Images/Monsters/Birb Monster/Feather-Ammo/feather2.png");
  play = new ImageButton(width/2 - menuButton.width*width/1000/2, height/2 - menuButton.height*width/1000/2, menuButton.width*width/1000, menuButton.height*width/1000, menuButton, "Play");
  furore = createFont("data/Images/Fonts/Furore.otf", 128);
  textFont(furore);
  retry = new ImageButton(play.xPos, play.yPos, play.buttonWidth, play.buttonHeight, menuButton, "Retry");
  returntoMenu = new ImageButton(play.xPos, play.yPos + height/20 + play.buttonHeight, play.buttonWidth, play.buttonHeight, menuButton, "Main Menu");
  imagesLoaded.add("data/Images/Tiles/Black.png");//add the black wall so it can occupy the index of 0
  imageHolder.add(loadImage("data/Images/Tiles/Black.png"));//add the black wall so it can occupy the index of 0
  LoadMap("data/Level/FirstRoom_Map");
  LoadMap("data/Level/Room2_Map");
  LoadMap("data/Level/Room3_Map");
  LoadMap("data/Level/Room4_Map");
  //dummy.addAnimation("data/Animations/BirbWalking.anim");
  //dumber.addAnimation("data/Animations/catWalking.anim");
  //dumber.addAnimation("data/Animations/catAttack.anim");
  noStroke();
  PVector areaPos = new PVector(0, 0);
  PVector areaSize = new PVector(0, 0);
  for (int i = 0; i < walls.size(); i++) {
    if (walls.get(i).position.x < areaPos.x) {
      areaPos.x = walls.get(i).position.x;
    }
    if (walls.get(i).position.y < areaPos.y) {
      areaPos.y = walls.get(i).position.y;
    }
  }
  for (int i = 0; i < walls.size(); i ++) {
    if (walls.get(i).position.x > areaSize.x) {
      areaSize.x = walls.get(i).position.x;
    }
    if (walls.get(i).position.y > areaSize.y) {
      areaSize.y = walls.get(i).position.y;
    }
  }
  areaSize = new PVector(areaSize.x - areaPos.x, areaSize.y - areaPos.x);
  generateNavpoints(areaPos, areaSize, 25);
  logotimer = millis();
}

void draw() {
  switch(gameState) {
  case -1:
    background(0);
    image(logo, width/2-logo.width/2, height/2-logo.height/2);
    if (millis() - logotimer >= 5000) {
      gameState = 0;
    }
    break;
  case 0:
    background(0);
    MainMenu();
    break;
  case 1:
    background(0);
    gameTheme.play();
    //gameTheme.loop();
    if (gameTheme.position() >= gameTheme.length()) {
      gameTheme.rewind();
      gameTheme.play();
    }
    Game();
    break;
  case 2:
    dead();
    break;
  }
}

void keyPressed() {
  if (key == 'w'|| key == 'W') {
    myPlayer.isMovingUp = true;
  }
  if (key == 's'|| key == 'S') {
    myPlayer.isMovingDown = true;
  }
  if (key == 'a'|| key == 'A') {
    myPlayer.isMovingLeft = true;
  }
  if (key == 'd'|| key == 'D') {
    myPlayer.isMovingRight = true;
  }
  /*if (key == 'f'|| key == 'F') {
   if (!myPlayer.dashing) {
   keyPressed = false;
   myPlayer.dashing = true;
   }
   }*/  //never finished
  if ((key == 'e' || key == 'E') && myPlayer.prevAnimation == -1) {
    keyPressed = false;
    //myPlayer.playAnimation(1, 300, 1);
    //textBoxText = new Text("hello this is a long sentence that should break the bounderies of the text box. Continuing to write more stuff so that it will run off of the bottom of the black screen. iduhfiaudfhiud haiusdh aiudh aiud hasidu haisud hasidu hasiudah sidua hi.", new PVector(width*0.25,height*0.76), 24, int(width*0.52));
    //if(displayingText){
    // displayingText = false;
    //}else{
    // displayingText = true;
    //}
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    myPlayer.isMovingUp = false;
  }
  if (key == 's'|| key == 'S') {
    myPlayer.isMovingDown = false;
  }
  if (key == 'a'|| key == 'A') {
    myPlayer.isMovingLeft = false;
  }
  if (key == 'd'|| key == 'D') {
    myPlayer.isMovingRight = false;
  }
}

void mousePressed() {
  switch(gameState) {
  case 0:
    if (play.clicked() == true && mouseButton == LEFT && isStarted == false) {
      //gameState = 1;
      isStarted = true;
      timer.time();
      timer.call();
    }
    break;
  case 1:
    if (mouseButton == LEFT) {
      myPlayer.isShooting = true;
    }
    break;
  case 2:
    if (retry.clicked() == true && mouseButton == LEFT) {
      gameState = 1;
      isStarted = true;
      timer.time();
      timer.call();
      myPlayer = new Player(new PVector(width*0.1, height*0.25), new PVector(32, 44), new PVector(0, 0), 0.35, 0, 100, 0, 45 );
      walls.clear();
      navPoints.clear();
      birbs.clear();
      cats.clear();
      LoadMap("data/Level/FirstRoom_Map");
      LoadMap("data/Level/Room2_Map");
      LoadMap("data/Level/Room3_Map");
      LoadMap("data/Level/Room4_Map");
    } else if (returntoMenu.clicked() == true && mouseButton == LEFT) {
      gameState = 0;
      introSequenceTimer[0] = 0;
      introSequenceTimer[1] = 0;
      introSequenceTimer[2] = 255;
      introSequenceTimer[3] = 0;
      introSequenceTimer[4] = 255;
      introSequenceTimer[5] = 255;
      isStarted = false;
      timer.time();
      timer.call();
      myPlayer = new Player(new PVector(width*0.1, height*0.25), new PVector(32, 44), new PVector(0, 0), 0.35, 0, 100, 0, 45 );
      walls.clear();
      navPoints.clear();
      birbs.clear();
      cats.clear();
      LoadMap("data/Level/FirstRoom_Map");
      LoadMap("data/Level/Room2_Map");
      LoadMap("data/Level/Room3_Map");
      LoadMap("data/Level/Room4_Map");
    }
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
