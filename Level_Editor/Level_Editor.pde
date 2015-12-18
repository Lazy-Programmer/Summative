import controlP5.*;
ControlP5 mainControl;

void setup(){
  size(700, 600);
  
  init();
}

void draw(){
  background(127);
  
  tileMap.display();
  
  //draw underlay
  displayUnderlay();
  
  noStroke();
  if(state == "edit"){
    editTab.backColour(24, 23, 100);
    editTab.hovering = false;
  }else if(state == "load"){
    loadTab.backColour(24, 23, 100);
    loadTab.hovering = false;
  }
  editTab.update();
  editTab.display();
  loadTab.update();
  loadTab.display();
  
  if(loadTab.clicked()){
    mousePressed = false;
    state = "load";
    editTab.backColour(23, 54, 175);
  }else if(editTab.clicked()){
    mousePressed = false;
    state = "edit";
    loadTab.backColour(23, 54, 175);
  }
  stroke(0);
  
  if(state == "edit"){
    trueTileLoadText.setVisible(false);
    tileLoadText.setVisible(true);
    savePath.setVisible(true);
    loadButton.buttonText = "Save Map";
    sizeList.display();
    typeList.display();
    
    //use the save button
    if(loadButton.clicked()){
      mousePressed = false;
      SaveMap();
    }
    
    //use lists
    if(sizeList.clicked() != -1 && sizeList.status == "down"){
      tileMap.rows = tileMap.cols = int(sizeList.content.get(sizeList.clicked()));
      sizeList.currIndex = int(sizeList.clicked());
      tileMap.XMove = tileMap.XOffset%tileMap.rows;
      tileMap.YMove = tileMap.YOffset%tileMap.cols;
      sizeList.status = "up";
    }
    
    if(typeList.clicked() != -1 && typeList.status == "down"){
      typeList.currIndex = int(typeList.clicked());
      typeList.status = "up";
    }
  }else if(state == "load"){
    trueTileLoadText.setVisible(true);
    tileLoadText.setVisible(false);
    savePath.setVisible(false);
    loadButton.buttonText = "Load Map";
    
    if(loadButton.clicked()){
      mousePressed = false;
      LoadMap();
    }
  }
  
  //loadButton
  loadButton.update();
  loadButton.display();
  
  //scrollers
  leftRightScroller.display();
  topDownScroller.display();
  
  if(leftRightScroller.right.clicked()){
    tileMap.XOffset -= 5;
  }else if(leftRightScroller.left.clicked()){
    tileMap.XOffset += 5;
  }
  
  if(topDownScroller.right.clicked()){
    tileMap.YOffset -= 5;
  }else if(topDownScroller.left.clicked()){
    tileMap.YOffset += 5;
  }
  
  DisplayPreview();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0){
    mapZoom += 0.01;
  }else if(e < 0){
    mapZoom -= 0.01;
    if(mapZoom <= 0.2){
      mapZoom = 0.2;
    }
  }
}

void init(){
  mainControl = new ControlP5(this);
  
  //tile map
 tileMap = new Grid(20, 80, height - 100, height - 100); 
 
 //buttons
 loadButton = new Button(int(width*0.87), int(height*0.95), 140, 20);
 loadButton.buttonText = "Save Map";
 loadButton.backColour(23, 54, 175);
 loadButton.roundness = 0;
 
 editTab = new Button(int(width*0.81), int(height*0.04), int(width*0.13), int(height*0.08));
 editTab.roundness = 0;
 editTab.buttonText = "Edit";
 editTab.backColour(23, 54, 175);
 
 loadTab = new Button(int(width*0.935), int(height*0.04), int(width*0.13), int(height*0.08));
 loadTab.roundness = 0;
 loadTab.buttonText = "Load";
 loadTab.backColour(23, 54, 175);
 
 //text field(s)
 PFont font = createFont("arial",20);
 
 tileLoadText = mainControl.addTextfield("tile loader")
     .setPosition(width*0.77,height*0.6)
     .setSize(140,30)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
 
 trueTileLoadText = mainControl.addTextfield("map loader")
     .setPosition(width*0.77,height*0.6)
     .setSize(140,30)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
     
  savePath = mainControl.addTextfield("save path")
     .setPosition(width*0.77,height*0.85)
     .setSize(140,30)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
     
 //list boxes
  sizeList = new ListBox("Tile Size", int(width*0.87), int(height*0.4), 150, 20);
  sizeList.colour(23, 54, 175);
  sizeList.addContent("72");
  sizeList.addContent("64");
  sizeList.addContent("32");
  sizeList.addContent("24");
  sizeList.addContent("16");
  
  typeList = new ListBox("Tile Type", int(width*0.87), int(height*0.25), 150, 20);
  typeList.colour(23, 54, 175);
  typeList.addContent("Object");
  typeList.addContent("Scene");
  
  //scrollers
  leftRightScroller = new Scroller(int(width * 0.386), height - 10, height - 100, 20);
  leftRightScroller.colour(23, 54, 175);
  topDownScroller = new Scroller(10, int(height*0.567), 20, int(height - 80));
  topDownScroller.changeDem('y');
  topDownScroller.colour(23, 54, 175);
}
