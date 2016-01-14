void MainMenu() {
  timer.time();
  // menuTheme.play();
  image(title, width/2-title.width/2, height/5-title.height/2);
  play.display();
  if (isStarted == true) {
    introSequence();
  }
  timer.call();
}
