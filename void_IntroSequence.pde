void introSequence() {
  textSize(height/24);
  if (introSequenceTimer[0] < 255) {
    fill(255, 255, 255, introSequenceTimer[0]);
    rect(width/2, height/2, width, height);
    introSequenceTimer[0] += timer.timeSinceLastCall * 0.075;
  } else if (introSequenceTimer[1] < 255) {
    fill(255);
    rect(width/2, height/2, width, height);
    fill(0, 0, 0, introSequenceTimer[1]);
    introSequenceTimer[1] += timer.timeSinceLastCall * 0.075;
    text("My head hurts...", width/2, height/2);
  } else if (introSequenceTimer[2] > 1){
    fill(255);
    rect(width/2, height/2, width, height);
    fill(0, 0, 0, introSequenceTimer[2]);
    introSequenceTimer[2] -= timer.timeSinceLastCall * 0.075;
    text("My head hurts...", width/2, height/2);
  }else{
    
  }
}
