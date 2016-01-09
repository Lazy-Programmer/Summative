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
  for (int i = bullets.size() - 1; i > 0; i--) {
    bullets.get(i).display();
    if ( bullets.get(i).moveBullet() == true) {
      bullets.remove(i);
    }
  }
  myPlayer.display();
  myPlayer.calculateVelocity();
  myPlayer.moveAdvanced(entities);
  if (myPlayer.isShooting == true) {
    myPlayer.shoot();
  }
  fist.delay();
  pistol.delay();
  shotgun.delay();
  timer.call();
  popMatrix();
}
