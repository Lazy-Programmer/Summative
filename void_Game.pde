void Game() {//the main loop
  //println("1");
  pushMatrix();
  view.update(myPlayer.position);//move the view
  view.mouseScroll();
  timer.time();//start the timing
  translate(-view.position.x, -view.position.y);
  fill(255);
  ArrayList<Entity> entities = new ArrayList<Entity>();
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).display();//display the walls
    entities.add(walls.get(i));//add them to the entity list, for later
  }
  //entities.add(dummy);//add the enemeis to the list
  entities.add(myPlayer);//add the player to the list
  //entities.add(dumber);
  //println("2");
  if (cats.size() > 0) {
    for (int i = 0; i < cats.size(); i++) {
      entities.add(cats.get(i));
      cats.get(i).display();
      cats.get(i).enemyAI();
      cats.get(i).move();
      if (cats.get(i).health <= 0) {
        cats.remove(i);
      }
    }
  }

  for (int i = 0; i < birbs.size(); i++) {
    entities.add(birbs.get(i));
    birbs.get(i).display();
    birbs.get(i).enemyAI();
    birbs.get(i).move();
    if (birbs.get(i).health <= 0) {
      birbs.remove(i);
    }
  }

  for (int i = bullets.size() - 1; i > 0; i--) {
    bullets.get(i).display();//display the bullets
    if ( bullets.get(i).moveBullet(entities) == true) {//move the bullets, if they have expired or hit something, delete them
      bullets.remove(i);
    }
  }
  //println("3");
  /*dummy.display();//display the enemies
   dummy.enemyAI();//have the enemies think
   dummy.move();// move the enemies
   dumber.display();
   dumber.enemyAI();
   dumber.move();*/

  if (myPlayer.collidingWith(entities) != -1) {
    if (!displayingText) {
      if (keyPressed) {
        if (key == 'r') {
          if (entities.get(myPlayer.collidingWith(entities)).action.charAt(0) != ' ') {
            keyPressed = false;
            textBoxText = new Text(entities.get(myPlayer.collidingWith(entities)).action, new PVector(width*0.25, height*0.76), 24, int(width*0.52));
            displayingText = true;
            myPlayer.mobile = false;
          }
        }
      }
    }
  } 

  myPlayer.display();//display the player
  myPlayer.calculateVelocity();//calculate the player movement based on input
  myPlayer.moveAdvanced(entities);// move the player
  if (myPlayer.isShooting == true) {
    myPlayer.shoot();
    myPlayer.speed = myPlayer.attackingSpeed;
  } else {
    myPlayer.speed = myPlayer.attackingSpeed*2;
  }
  if (myPlayer.animation.size() > 0) {
    if (myPlayer.velocity.y == 0 && myPlayer.velocity.x == 0 && myPlayer.isShooting == false) {
      myPlayer.animation.get(0).stall = 1;
      myPlayer.animation.get(0).stalling = true;
    } else if (myPlayer.isShooting == false && (myPlayer.isMovingRight == true || myPlayer.isMovingLeft == true|| myPlayer.isMovingUp == true || myPlayer.isMovingDown == true)) {
      myPlayer.animation.get(0).stall = -1;
      myPlayer.animation.get(0).stalling = false;
    } else if (myPlayer.ammo > 0 && myPlayer.isShooting && (myPlayer.isMovingRight == true || myPlayer.isMovingLeft == true|| myPlayer.isMovingUp == true || myPlayer.isMovingDown == true)) {
      if (myPlayer.prevAnimation == -1) {
        myPlayer.playAnimation(2, 500);
        playerGunFire.rewind();
        playerGunFire.play();
      }
    } else if (myPlayer.ammo > 0 && myPlayer.isShooting && myPlayer.isMovingRight == false && myPlayer.isMovingLeft == false && myPlayer.isMovingUp == false && myPlayer.isMovingDown == false) {
      if (myPlayer.prevAnimation == -1) {
        myPlayer.animation.get(1).fps = 50;
        myPlayer.playAnimation(1, 500);
        playerGunFire.rewind();
        playerGunFire.play();
      }
    }
  }
  //println("4");
  //fist.delay();
  pistol.delay();//have the pistol wait between shots
  //shotgun.delay();
  ViewCones();//obstruct the things the player cannot see
  /*for (int i = 0; i < navPoints.size(); i++) {
   navPoints.get(i).display();//for debugging
   }*/
  popMatrix();
  fill(255);
  if (displayingText) {
    imageMode(CENTER);
    textBoxText.position.x = width*0.25 - view.position.x;
    textBoxText.position.y = height*0.76 - view.position.y; 
    image(textBox, width/2, height*0.8, width*0.8, height*0.4);
    textBoxText.display();
  }
  fill(#f14321);
  if (myPlayer.health > 0) {//display the health bar
    float hpw = 150*width/1280;
    float plHP = myPlayer.health;
    rectMode(CORNER);
    rect(94/1280.0*width, 677/800.0*height, plHP/100*hpw, 46/80.0*healthBar.height, 0, 23, 23, 0);// rectangle that fills the bar
    rectMode(CENTER);
  }
  textSize(healthBar.height/3);
  imageMode(CORNER);
  image(healthBar, width*0.125 - healthBar.width/2, height - height*0.125 - healthBar.height/2);
  fill(255);
  if (myPlayer.health <= 0) {
    myPlayer.health = 0;//kill the player
    gameTheme.rewind();
    gameTheme.pause();
    gameState = 2;
  }
  textAlign(CENTER);
  text(myPlayer.health, width*0.125 - healthBar.width/3, height - height*0.12);//health amount in numbers
  if (myPlayer.ammo > 0) {//ammo bar
    float aw = 160*width/1280;
    float plAM = myPlayer.ammo;
    rectMode(CORNER);
    fill(214, 171, 18);
    rect(1020/1280.0*width + (aw - plAM/myPlayer.ammoMax*aw), 677/800.0*height, plAM/myPlayer.ammoMax*aw, 46/80.0*ammoBar.height, 23, 0, 0, 23);//rectangle that fills the bar
    rectMode(CENTER);
  }
  //println("5");
  fill(255);
  image(ammoBar, width - (width*0.125 + ammoBar.width/2), height - height*0.125 - ammoBar.height/2);//ammo bar
  text(myPlayer.ammo, width - (width*0.125 + ammoBar.width/2) + ammoBar.width*0.8125, height - height*0.12);//ammo count
  if (introSequenceTimer[5] > 1) {//white flash
    fill(255, introSequenceTimer[5]);
    rect(width/2, height/2, width, height);
    introSequenceTimer[5] -= timer.timeSinceLastCall * 0.075;
  }
  timer.call();//get the time ellapsed
}
