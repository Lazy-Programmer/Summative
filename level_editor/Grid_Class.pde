class Grid{//The class for the grid will also be placed here
  int x, y;
  int w, h;
  int rows, cols;
  float XOffset, XMove;
  float YOffset, YMove;
  float coordX, coordY;
  
  Grid(int xx, int yy, int ww, int hh){
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    rows = cols = 72;
    
    XOffset = 0.0;
    XMove = XOffset;
    YOffset = 0.0;
    YMove = YOffset;
    
    coordX = coordY = 0;
  }
  
  void display(){
    //offsets
    if(XOffset > 0){
      XOffset = 0;
    }
    if(YOffset > 0){
      YOffset = 0;
    }
    
    XMove = XOffset%(rows*mapZoom);
    YMove = YOffset%(cols*mapZoom);
    
    //colomns
    for(int i = 0; i < (rows*mapZoom) * (w/(rows*mapZoom) + (rows*mapZoom)); i += (rows*mapZoom)){
      if(x + i + XMove <= x + w){
        line(x + i + XMove, y, x + i + XMove, y + h);
        fill(23, 54, 175);
        if(x + i + XMove < x + w){
          textAlign(CORNER, CORNER);
          textSize((rows*mapZoom)/3);
          text(str(int((i/(rows*mapZoom)) + 1 + int(abs(XOffset / (rows*mapZoom))))), x + i + XMove + 10, y );
        }
      }
    }
    
    //rows
    for(int i = 0; i < (cols*mapZoom) * (h/(cols*mapZoom) + (cols*mapZoom)) + 1; i += (cols*mapZoom)){
      if(y + i + YMove >= y){
        line(x, y + i + YMove, x + w, y + i + YMove);
        fill(23, 54, 175);
        if(y + i + YMove < y + h){
          textAlign(CORNER, CORNER);
          textSize((cols*mapZoom)/3);
          text(str(int(i/(cols*mapZoom) + 1 + int(abs(YOffset / (cols*mapZoom))))), x ,y + i + YMove + 20 );
        }
      }
    }
    
    //load tile map preview
    for(int i = 0; i < tileLocations.size(); i++){
      PImage tempIMG = loadImage(tileLocations.get(i).filename);
      if(((tileLocations.get(i).location.x - x)*mapZoom + XOffset)+ x + tileLocations.get(i).size > 0 && ((tileLocations.get(i).location.x - x)*mapZoom + XOffset)+ x + tileLocations.get(i).size < width && ((tileLocations.get(i).location.y - y)*mapZoom + YOffset) + y + tileLocations.get(i).size > 0 && ((tileLocations.get(i).location.y - y)*mapZoom + YOffset) + y + tileLocations.get(i).size < height){
        image(tempIMG,((tileLocations.get(i).location.x - x)*mapZoom + XOffset)+ x, ((tileLocations.get(i).location.y - y)*mapZoom + YOffset) + y, tileLocations.get(i).size *mapZoom, tileLocations.get(i).size *mapZoom);
      }
    }
    
    //highlight
    if(displaying){
      if(!(mouseX < x || mouseX > x + w || mouseY < y || mouseY > y + h)){
        fill(0, 255, 0);
        rectMode(CORNER);
        tint(255, 200);
        image(prevIMG, x + (rows*mapZoom) * int((mouseX - x - XMove)/(rows*mapZoom)) + XMove, y + (cols*mapZoom) * int(((mouseY - y - YMove)/(cols*mapZoom))) + YMove, rows*mapZoom, cols*mapZoom);
        rectMode(CENTER);
      }
      
      //check for clicks
      if(mousePressed && !(mouseX < x || mouseX > x + w || mouseY < y || mouseY > y + h)){
        if(mouseButton == LEFT){
          mousePressed = false;
          boolean isIn = false;
          
          //delete tiles
          for(int i = 0; i < tileLocations.size(); i++){
            if(((rows*mapZoom) * int((mouseX - x - XOffset)/(rows*mapZoom)))/mapZoom + x < tileLocations.get(i).location.x + 10 && ((rows*mapZoom) * int((mouseX - x - XOffset)/(rows*mapZoom)))/mapZoom + x > tileLocations.get(i).location.x - 10
            && ((cols*mapZoom) * int((mouseY - y - YOffset)/(cols*mapZoom)))/mapZoom + y < tileLocations.get(i).location.y + 10 && ((cols*mapZoom) * int((mouseY - y - YOffset)/(cols*mapZoom)))/mapZoom + y > tileLocations.get(i).location.y - 10){
              if(typeList.content.get(typeList.currIndex) == tileLocations.get(i).type){
                tileLocations.remove(i);
                isIn = true;
              }
            }
          }
        
          if(!isIn){
            noTint();
            tileLocations.add(new Tile(new PVector(((rows*mapZoom) * int((mouseX - x - XOffset)/(rows*mapZoom)))/mapZoom + x, 
                                                   ((cols*mapZoom) * int((mouseY - y - YOffset)/(cols*mapZoom)))/mapZoom + y), tileLoadText.getText(), rows, typeList.content.get(typeList.currIndex)));
          }
        }
      }
    }
  }
}