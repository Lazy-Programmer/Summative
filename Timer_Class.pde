class Timer {
  private int time = 0;
  private int lastCall = 0;
  int timeSinceLastCall = 0;

  void time() {
    time = millis();
  }

  void call() {
    timeSinceLastCall = time - lastCall;
    lastCall = time;
  }
}
