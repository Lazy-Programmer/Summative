void dead() {
  fill(255, 10);
  rect(width/2, height/2, width, height);
  fill(0,20);
  textSize(36);
  text("You died", width/2,height/4);
  retry.display();
  returntoMenu.display();
}
