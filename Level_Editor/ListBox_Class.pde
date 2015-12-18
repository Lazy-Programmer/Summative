class ListBox{
  int x, y;
  int w, h;
  int r, g, b;
  int lr, lg, lb;
  int currIndex;
  String label;
  String status;
  boolean hover;
  ArrayList <String> content;
  
  ListBox(String tlabel, int xx, int yy, int ww, int hh){
    label = tlabel;
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    
    r = g = b = 0;
    lr = lg = lb = 0;
    
    currIndex = 0;
    content = new ArrayList<String>();
    status = "up";
    hover = false;
  }
  
  void addContent(String cont){
    content.add(cont);
  }
  
  void removeContent(int index){
    content.remove(index);
  }
  
  void colour(int rr, int gg, int bb){
    r = rr;
    g = gg;
    b = bb;
    
    lr = rr - 50;
    lg = gg - 50;
    lb = bb - 50;
  }
  
  int clicked(){
    int value = -1;
    for(int i = 0; i < content.size(); i++){
      if(!(mouseX < x - w/2|| mouseX > x + w/2 || mouseY < y - h/2 + i*h + h || mouseY > y + h/2 + i*h + h)){
        if(mousePressed){
          value = i;
        }
      }
    }
    return value;
  }
  
  void drawMain(){
    //rectangle
      fill(r, g, b);
      rectMode(CENTER);
      rect(x, y, w, h);
      
      //text
      fill(255, 255, 255);
      textAlign(CENTER, CENTER);
      textSize(h - 4);
      text(label + " :" + content.get(currIndex), x, y);
  }
  
  void display(){
    //hovering and clicks
    if(!(mouseX < x - w/2 || mouseX > x + w/2 || mouseY < y - h/2 || mouseY > y + h/2)){
      if(!hover){
        r += 40;
        g += 40;
        b += 40;
        hover = true;
      }
      
      if(mousePressed){
        mousePressed = false;
        if(status == "up")
          status = "down";
        else if(status == "down")
          status = "up";
      }
    }else{
      if(hover){
        r -= 40;
        g -= 40;
        b -= 40;
        hover = false;
      }
    }
    if(status == "up"){
      drawMain();
    }else if(status == "down"){
      drawMain();
      for(int i = 0; i < content.size() && i < 5; i++){
        //rectangle
      fill(lr, lg, lb);
      rectMode(CENTER);
      rect(x, y + (i+1)*h, w, h);
      
      //text
      fill(255, 255, 255);
      textAlign(CENTER, CENTER);
      textSize(h - 4);
      text(content.get(i), x, y + (i+1)*h);
      }
    }
  }
}
