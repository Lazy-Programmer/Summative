void MainMenu() {
  timer.time();//start the timer
  if (menuTheme.isPlaying() == false) {
    menuTheme.play();
    menuTheme.loop();
    menuTheme.setLoopPoints(0, menuTheme.length());
  }
  image(title, width/2-title.width/2, height/5-title.height/2);//title sign
  play.display();//button
  if (isStarted == true) {
    introSequence();//display the introsequence
  }
  textSize(16);
  text("WASD to move, Left mouse to fire, ESC to quit, Interact with objects by moving towards them and pressing 'R'", width/2, height - height/8);
  timer.call();
}
