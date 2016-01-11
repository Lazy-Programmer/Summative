class Text{
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
  
  Text(String ttext, PVector topLeftPosition, int tsize, int twidth){
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
    
    techFont = createFont("..\\Data\\Furore.otf", size);
    textFont(techFont);
    //textSize(size);
  }
  
  void display(){
    int backSpace = 0;
    if(!paused){
      intervalCounter += timer.timeSinceLastCall;
      if(intervalCounter >= 30){
        intervalCounter = 0;
        
        if(textChars < text.length()){
          textChars += 1;
          if (textWidth(text.substring(0,textChars)) >= w){
            for(int i = 0; text.charAt(textChars - i) != ' ' && i < text.length(); i++){
              backSpace += 1;
            }
            lineLength += w;
            breakPoints.append(textChars - backSpace);
            text = text.substring(0, textChars - backSpace) + "\n" + text.substring(textChars - backSpace, text.length());
            if(lineLength >= w*3 - 1){
              paused = true;
              text = text.substring(0, textChars - backSpace) + text.substring(textChars - backSpace, text.length());
              text = text.substring(0, textChars - backSpace) + text.substring(textChars - backSpace, text.length());
            }
            textChars = textChars - backSpace;
          }
        }
      }
    }
    
    if(keyPressed){
      if(key == 'r' && paused){
        keyPressed = false;
        paused = false;
        startChar = breakPoints.get((lineLength/w) - 3);
        text = text.substring(0, textChars - backSpace) + text.substring(textChars - backSpace, text.length());
      }
    }
      if(lineLength >= w*3  && startChar > 0 && paused){
        text( " " + text.substring(startChar,textChars),position.x + view.position.x, position.y + view.position.y + textOffsetY - size);
      }else if(lineLength >= w*3 && startChar > 0){
        text( " " + text.substring(startChar,textChars),position.x + view.position.x, position.y + view.position.y + textOffsetY - size);
      }else if(lineLength >= w*3 - 1 && paused){
        text( " " + text.substring(startChar,textChars),position.x + view.position.x, position.y + view.position.y + textOffsetY);
      }else {
        text( " " + text.substring(startChar,textChars),position.x + view.position.x, position.y + view.position.y + textOffsetY);
      }
  }
}
