void Game() {
  pushMatrix();
  view.update(myPlayer.position);
  view.mouseScroll();
  timer.time();
  translate(-view.position.x, -view.position.y);//view.position.x, view.position.y);
  myPlayer.display();
  myPlayer.calculateVelocity();
  //myPlayer.weapons.get(0).delay();
//  myPlayer.fist.delay();
  ArrayList<Entity> entities = new ArrayList<Entity>();
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).display();
    entities.add(walls.get(i));
  }
  for(int i = bullets.size() - 1; i > 0; i--){
   bullets.get(i).display();
   if( bullets.get(i).moveBullet() == true){
     bullets.remove(i);
   }
  }
  myPlayer.moveAdvanced(entities);
  if(myPlayer.isShooting == true){
     myPlayer.shoot(); 
  }
  fist.delay();
  timer.call();
  popMatrix();
}
