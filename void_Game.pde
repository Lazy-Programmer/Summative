void Game() {
  timer.time();
  myPlayer.display();
  myPlayer.calculateVelocity();
  myPlayer.move();
  ArrayList<Entity> entities = new ArrayList<Entity>();
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).display();
    entities.add(walls.get(i));
  }
  timer.call();
}
