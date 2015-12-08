void Game() {
  timer.time();
  myPlayer.display();
  myPlayer.calculateVelocity();
  ArrayList<Entity> entities = new ArrayList<Entity>();
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).display();
    entities.add(walls.get(i));
  }
  myPlayer.moveAdvanced(entities);
  timer.call();
}
