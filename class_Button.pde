class Button {
  int xPos;
  int yPos;
  int buttonWidth;
  int buttonHeight;
  int radius = 0;
  String label;

  Button(int txPos, int tyPos, int tbuttonWidth, int tbuttonHeight, int tradius) {//overloading functions for different effects
    xPos = txPos;
    yPos = tyPos;
    buttonWidth = tbuttonWidth;
    buttonHeight = tbuttonHeight;
    radius = tradius;
    label = " ";
  }

  Button(int txPos, int tyPos, int tbuttonWidth, int tbuttonHeight, int tradius, String tlabel) {
    xPos = txPos;
    yPos = tyPos;
    buttonWidth = tbuttonWidth;
    buttonHeight = tbuttonHeight;
    radius = tradius;
    label = tlabel;
  }

  Button(int txPos, int tyPos, int tbuttonWidth, int tbuttonHeight) {
    xPos = txPos;
    yPos = tyPos;
    buttonWidth = tbuttonWidth;
    buttonHeight = tbuttonHeight;
    label = " ";
  }

  Button(int txPos, int tyPos, int tbuttonWidth, int tbuttonHeight, String tlabel) {
    xPos = txPos;
    yPos = tyPos;
    buttonWidth = tbuttonWidth;
    buttonHeight = tbuttonHeight;
    label = tlabel;
  }

  void display() {
    rect(xPos, yPos, buttonWidth, buttonHeight, radius);
    fill(#000000);
    textSize(buttonHeight-buttonHeight/2);
    text(label, xPos, yPos, buttonWidth, buttonHeight);
  }

  boolean clicked() {
    if (mouseX > xPos && mouseX < xPos + buttonWidth && mouseY > yPos && mouseY < yPos + buttonHeight) {
      return true;
    } else {
      return false;
    }
  }
}

class ImageButton extends Button {
  PImage picture;
  
  ImageButton(int txPos, int tyPos, int tbuttonWidth, int tbuttonHeight, PImage tpicture, String tlabel) {
    super(txPos, tyPos, tbuttonWidth, tbuttonHeight);
    picture = tpicture;
    picture.resize(tbuttonWidth, tbuttonHeight);
    label = tlabel;
  }

  void display() {
    if (mouseX > xPos && mouseX < xPos + buttonWidth && mouseY > yPos && mouseY < yPos + buttonHeight) {
      tint(#999999);
    }else{
    // noTint(); 
    }
    image(picture, xPos, yPos);
    fill(#FFFFFF);
    textAlign(CENTER,CENTER);
    textSize(buttonHeight/3);
    text(label,xPos + buttonWidth/2,yPos+buttonHeight/2, buttonWidth, buttonHeight);
    noTint();
  }
}
