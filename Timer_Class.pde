class Timer {//idealy every function would have one, but...
  private int time = 0;
  private int lastCall = 0;
  int timeSinceLastCall = 0;

  void time() {//sets the time to now
    time = millis();
  }

  void call() {// gets the time elapsed
    timeSinceLastCall = time - lastCall;
    lastCall = time;
  }
}
