void introSequence() {// the white flash and text at the start, just a bunch of timers and text
  textSize(height/24);
  if (introSequenceTimer[0] < 255) {
    menuTheme.setGain(-introSequenceTimer[0]/4);
    fill(255, 255, 255, introSequenceTimer[0]);
    rect(width/2, height/2, width, height);
    introSequenceTimer[0] += timer.timeSinceLastCall * 0.075;
  } else if (introSequenceTimer[1] < 255) {
    menuTheme.pause();
    menuTheme.rewind();
    fill(255);
    rect(width/2, height/2, width, height);
    fill(0, 0, 0, introSequenceTimer[1]);
    introSequenceTimer[1] += timer.timeSinceLastCall * 0.075;
    text("My head hurts...", width/2, height/2);
  } else if (introSequenceTimer[2] > 1) {
    fill(255);
    rect(width/2, height/2, width, height);
    fill(0, 0, 0, introSequenceTimer[2]);
    introSequenceTimer[2] -= timer.timeSinceLastCall * 0.075;
    text("My head hurts...", width/2, height/2);
  } else if (introSequenceTimer[3] < 255) {
    fill(255);
    rect(width/2, height/2, width, height);
    fill(0, 0, 0, introSequenceTimer[3]);
    introSequenceTimer[3] += timer.timeSinceLastCall * 0.075;
    text("Where am I?", width/2, height/2);
  } else if (introSequenceTimer[4] > 1) {
    fill(255);
    rect(width/2, height/2, width, height);
    fill(0, 0, 0, introSequenceTimer[4]);
    introSequenceTimer[4] -= timer.timeSinceLastCall * 0.075;
    text("Where am I?", width/2, height/2);
  } else {
    fill(255);
    rect(width/2, height/2, width, height);
    gameState = 1;//at the end of the cutscene start the game
    introSequenceTimer[0] = 0;
    introSequenceTimer[1] = 0;
    introSequenceTimer[2] = 255;
    introSequenceTimer[3] = 0;
    introSequenceTimer[4] = 255;
  }
}
