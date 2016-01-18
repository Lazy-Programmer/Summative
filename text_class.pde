class Text {
  PVector position;
  int size;
  int textChars;
  int startChar;
  int w;
  int lineLength;
  float textOffsetY;
  float intervalCounter;
  String text;
  boolean paused;
  IntList breakPoints;

  Text(String ttext, PVector topLeftPosition, int tsize, int twidth) {
    position = topLeftPosition;
    text = ttext;
    size = tsize;
    w = twidth;
    textChars = 0;
    startChar = 0;
    textOffsetY = 0;
    intervalCounter = 0;
    lineLength = 0;
    paused = false;
    breakPoints = new IntList();

    textSize(size);
  }

  void display() {
    int backSpace = 0;
    if(!paused){
      intervalCounter += timer.timeSinceLastCall;
      if(intervalCounter >= 30){
        intervalCounter = 0;
        
        if(textChars < text.length()){
          textChars += 1;
          textClick.rewind();
          textClick.setGain(-15);
          textClick.play();
          String tText = text.substring(0,textChars);
          //println(textWidth(tText) >= w);
          backSpace = textChars - 1;
          if (textWidth(tText) >= w){
            println(text.charAt(textChars - 1));
            if(text.charAt(textChars - 1) == ' '){
            }else{
              for(int i = textChars - 1; text.charAt(i) != ' ' && i > 0; i--){
                backSpace -= 1;
              }
            }
            lineLength += w;
            breakPoints.append(backSpace);
            text = text.substring(0, backSpace) + "\n " + text.substring(backSpace, text.length());
            if(lineLength >= w*3 - 1){
              paused = true;
              text = text.substring(0,backSpace) + "...[R]" + text.substring(backSpace, text.length());
              backSpace += 6;
            }
            textChars = backSpace;
          }
        }
      }
    }

    if (keyPressed) {
      if (key == 'r' && paused) {
        keyPressed = false;
        paused = false;
        startChar = breakPoints.get((lineLength/w) - 3);
        text = text.substring(0, textChars - 6) + text.substring(textChars, text.length());
      }else if(key == 'r'){
        keyPressed = false;
        displayingText = false;
        myPlayer.mobile = true;
      }
    }
    textAlign(CORNER, CORNER);
    fill(255, 255, 255);
    if (lineLength >= w*3  && startChar > 0 && paused) {
      text( " " + text.substring(startChar, textChars), position.x + view.position.x, position.y + view.position.y + textOffsetY - size);
    } else if (lineLength >= w*3 && startChar > 0) {
      text( " " + text.substring(startChar, textChars), position.x + view.position.x, position.y + view.position.y + textOffsetY - size);
    } else if (lineLength >= w*3 - 1 && paused) {
      text( " " + text.substring(startChar, textChars), position.x + view.position.x, position.y + view.position.y + textOffsetY);
    } else {
      text( " " + text.substring(startChar, textChars), position.x + view.position.x, position.y + view.position.y + textOffsetY);
    }
  }
}
