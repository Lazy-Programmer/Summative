void Game() {
  pushMatrix();
  view.update(myPlayer.position);
  view.mouseScroll();
  timer.time();
  translate(-view.position.x, -view.position.y);
  for (int i = 0; i < navPoints.size(); i++) {
    navPoints.get(i).display();
  }
  fill(255);
  ArrayList<Entity> entities = new ArrayList<Entity>();
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).display();
    entities.add(walls.get(i));
  }
  entities.add(dummy);
  entities.add(myPlayer);
  entities.add(dumber);
  for (int i = bullets.size() - 1; i > 0; i--) {
    bullets.get(i).display();
    if ( bullets.get(i).moveBullet(entities) == true) {
      bullets.remove(i);
    }
  }
  dummy.display();
  dummy.enemyAI();
  dummy.move();
  dumber.display();
  dumber.enemyAI();
  dumber.move();
  myPlayer.display();
  myPlayer.calculateVelocity();
  myPlayer.moveAdvanced(entities);
  if (myPlayer.isShooting == true) {
    myPlayer.shoot();
    myPlayer.speed = myPlayer.attackingSpeed;
  }else{
    myPlayer.speed = myPlayer.attackingSpeed*2;
  }
  if(myPlayer.animation.size() > 0){
    if(myPlayer.velocity.y == 0 && myPlayer.velocity.x == 0 && myPlayer.isShooting == false){
      myPlayer.animation.get(0).stall = 1;
      myPlayer.animation.get(0).stalling = true;
    }else if(myPlayer.isShooting == false && (myPlayer.isMovingRight == true || myPlayer.isMovingLeft == true|| myPlayer.isMovingUp == true || myPlayer.isMovingDown == true)){
      myPlayer.animation.get(0).stall = -1;
      myPlayer.animation.get(0).stalling = false;
    }else if(myPlayer.isShooting && (myPlayer.isMovingRight == true || myPlayer.isMovingLeft == true|| myPlayer.isMovingUp == true || myPlayer.isMovingDown == true)){
      if(myPlayer.prevAnimation == -1){
        myPlayer.playAnimation(2, 1000);
      }
    }else if(myPlayer.isShooting && myPlayer.isMovingRight == false || myPlayer.isMovingLeft == false|| myPlayer.isMovingUp == false || myPlayer.isMovingDown == false){
      if(myPlayer.prevAnimation == -1){
        myPlayer.playAnimation(1, 500, 2);
      }
    }
  }
  fist.delay();
  pistol.delay();
  shotgun.delay();
  timer.call();
  popMatrix();
  fill(#f14321);
  if(myPlayer.health > 0){
    float hpw = 150*width/1280;
    float plHP = myPlayer.health;
    rectMode(CORNER);
    rect(94/1280.0*width,677/800.0*height,plHP/100*hpw,46/80.0*healthBar.height,0,23,23,0);
    rectMode(CENTER);
  }
  textSize(healthBar.height/3);
  image(healthBar, width*0.125 - healthBar.width/2, height - height*0.125 - healthBar.height/2);
  fill(255);
  if(myPlayer.health < 0){
   myPlayer.health = 0; 
  }
  text(myPlayer.health, width*0.125 - healthBar.width/3 ,height - height*0.125);
}
