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
  
  //timer
  timer.time();
  
  //reset Zoom
  if(mousePressed && mouseButton == CENTER){
      mapZoom = 1.0;
  }
  noStroke();
  if(state == "edit"){
    editTab.backColour(24, 23, 100);
    editTab.hovering = false;
  }else if(state == "load"){
    loadTab.backColour(24, 23, 100);
    loadTab.hovering = false;
  }else if(state == "GIF"){
    GIFTab.backColour(24, 23, 100);
    GIFTab.hovering = false;
  }
  editTab.update();
  editTab.display();
  loadTab.update();
  loadTab.display();
  GIFTab.update();
  GIFTab.display();
  
  if(loadTab.clicked()){
    mousePressed = false;
    state = "load";
    editTab.backColour(23, 54, 175);
    GIFTab.backColour(23, 54, 175);
  }else if(editTab.clicked()){
    mousePressed = false;
    state = "edit";
    loadTab.backColour(23, 54, 175);
    GIFTab.backColour(23, 54, 175);
  }else if(GIFTab.clicked()){
    mousePressed = false;
    state = "GIF";
    editTab.backColour(23, 54, 175);
    loadTab.backColour(23, 54, 175);
  }
  stroke(0);
  
  if(state == "edit"){
    addText.update();
    addText.display();
    if(!addingAction){
      trueTileLoadText.setVisible(false);
      tileLoadText.setVisible(true);
      savePath.setVisible(true);
      loadButton.buttonText = "Save Map";
      sizeList.display();
      typeList.display();
      demensionsList.display();
      rotateButton.update();
      rotateButton.display();
      
      //use the save button
      if(loadButton.clicked()){
        mousePressed = false;
        SaveMap();
      }
      
      //use rotate button
      if(rotateButton.clicked()){
        mousePressed = false;
        currOrientation += 90;
        if(currOrientation >= 360){
          currOrientation = 0;
        }
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
      
      if(demensionsList.clicked() != -1 && demensionsList.status == "down"){
        demensionsList.currIndex = int(demensionsList.clicked());
        demensionsList.status = "up";
        if(demensionsList.currIndex == 0){
          currDemensions = -1;
        }else if(demensionsList.currIndex == 1){
          currDemensions = 0.5;
        }else{
          currDemensions = (float)int(demensionsList.content.get(demensionsList.currIndex));
        }
      }
    }else{
      if(loadButton.clicked()){
        mousePressed = false;
        LoadAction(addActionText.getText());
      }
    }
    
    if(addText.clicked()){
      mousePressed = false;
      if(addingAction){
        addingAction = false;
        addText.x = int(width*0.955);
        addText.y = int(height*0.27);
        addText.buttonText = "Action";
        loadButton.buttonText = "Save Map"; 
        addActionText.setVisible(false);
      }else{
        addingAction = true;
        addText.x = int(width*0.87);
        addText.y = int(height*0.10);
        addText.buttonText = "back";
        loadButton.buttonText = "Use Action File";
        addActionText.setVisible(true);
      }
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
  }else if(state == "GIF"){
    trueTileLoadText.setVisible(false);
    tileLoadText.setVisible(false);
    savePath.setVisible(true);
    loadButton.buttonText = "Load GIF";
    
    //display the gif stuff
    gifBox.display();
    gifPlayer.display();
    stroke(0); 
    spriteSpeed.update();
    spriteSpeed.display();
    deleteSlide.update();
    deleteSlide.display();
    output.update();
    output.display();
    
    if(loadButton.clicked()){
      mousePressed = false;
      File file = new File(sketchPath(savePath.getText()));
      if(file.exists() && savePath.getText().charAt(0) != '/' && savePath.getText().length() > 0){
        gifBox.addSlide(savePath.getText());
        gifPlayer.addSlide(savePath.getText());
      }
    }
    
    if(spriteSpeed.clicked()){
     mousePressed = false;
     gifPlayer.fps += 4;
     if(gifPlayer.fps > 56 && gifPlayer.fps < 61){
       gifPlayer.fps = 59;
     }
     if(gifPlayer.fps > 60){
       gifPlayer.fps = 10;
     }
    }
    
    if(deleteSlide.clicked()){
      mousePressed = false;
      if(deletingSlides){
        deletingSlides = false;
      }else{
        deletingSlides = true;
      }
    }
    
    if(output.clicked()){
      mousePressed = false;
      OutputGIF();
    }
  }
  
  //Things in common for all states
  if(deletingSlides){
    for(int i = 0; i < gifBox.slides.size(); i++){
       gifBox.slides.get(i).backColour(28, 196, 26);
       gifBox.slides.get(i).textColour(0, 0, 0);
       
       if(gifBox.slides.get(i).clicked()){
         gifBox.slides.remove(i);
         gifPlayer.index = 0;
         gifPlayer.remove(i);
         deletingSlides = false;
       }
    }
  }else{
    for(int j = 0; j < gifBox.slides.size(); j++){
      gifBox.slides.get(j).backColour(0, 0, 0);
      gifBox.slides.get(j).textColour(28, 196, 26);
    }
  }
  
  //loadButton
  loadButton.update();
  loadButton.display();
  
  //scrollers
  leftRightScroller.display();
  topDownScroller.display();
  
  if(leftRightScroller.right.clicked()){
    tileMap.XOffset -= timer.timeSinceLastCall*0.5;
  }else if(leftRightScroller.left.clicked()){
    tileMap.XOffset += timer.timeSinceLastCall*0.5;
  }
  
  if(topDownScroller.right.clicked()){
    tileMap.YOffset -= timer.timeSinceLastCall*0.5;
  }else if(topDownScroller.left.clicked()){
    tileMap.YOffset += timer.timeSinceLastCall*0.5;
  }
  
  DisplayPreview();
  timer.call();
}

//This is for the future. There is a bug where it will try to open a file with a case sensitive name and get an error.
boolean fileCheck(File file){
  boolean res = false;
  String [] children;
  File tempFile = new File(sketchPath("..\\" + file.getName()));
  children = tempFile.list();
  if(children != null){
    for(int i = 0; i < children.length; i++){
      if(file.getName() == children[i]){
        res = true;
      }
      println(file.getName() + "||" + children[i]);
    }
  }
  println("empty");
  return res;
}
//----------------------------------------------------------

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(!(mouseX < tileMap.x || mouseX > tileMap.x + tileMap.w || mouseY < tileMap.y || mouseY > tileMap.y + tileMap.h)){
    if(e > 0){
      mapZoom += 0.01;
    }else if(e < 0){
      mapZoom -= 0.01;
      if(mapZoom <= 0.2){
        mapZoom = 0.2;
      }
    }
  }
  
  //GIFBox
  if(!(mouseX < gifBox.x-gifBox.w/2 || mouseX > gifBox.x+gifBox.w/2 || mouseY < gifBox.y-gifBox.w/2 || mouseY > gifBox.y+gifBox.w/2) && state == "GIF"){
    if(e > 0){
      gifBox.yOffset += 2;
    }else if(e < 0){
      gifBox.yOffset -= 2;
      if(gifBox.yOffset < 0){
        gifBox.yOffset = 0;
      }
    } 
  }
}

void init(){
  mainControl = new ControlP5(this);
  
  //tile map
 tileMap = new Grid(20, 80, height - 100, height - 100); 
 
 //timer
  timer = new Timer();
 
 //GIF Box
 gifBox = new GIFBox(int(width*0.874), int(height*0.55), int(width*0.26), int(height*0.5));
 gifPlayer = new GIFAnimator(width*0.874, height*0.12, height*0.1, height*0.1);
 
 //buttons
 loadButton = new Button(int(width*0.87), int(height*0.95), 140, 20);
 loadButton.buttonText = "Save Map";
 loadButton.backColour(23, 54, 175);
 loadButton.roundness = 0;
 
 editTab = new Button(int(width*0.793), int(height*0.04), int(width*0.096), int(height*0.08));
 editTab.roundness = 0;
 editTab.buttonText = "Edit";
 editTab.backColour(23, 54, 175);
 
 loadTab = new Button(int(width - width*0.12), int(height*0.04), int(width*0.096), int(height*0.08));
 loadTab.roundness = 0;
 loadTab.buttonText = "Load";
 loadTab.backColour(23, 54, 175);
 
 GIFTab = new Button(int(width*0.97), int(height*0.04), int(width*0.096), int(height*0.08));
 GIFTab.roundness = 0;
 GIFTab.buttonText = "GIF";
 GIFTab.backColour(23, 54, 175);
 
 rotateButton = new Button(int(width*0.935), int(height*0.8), int(width*0.05), int(height*0.05));
 rotateButton.roundness = 0;
 rotateButton.buttonText = "r°";
 rotateButton.backColour(23, 54, 175);
 
 addText = new Button(int(width*0.955), int(height*0.27), 60, 20);
 addText.backColour(23, 54, 175);
 addText.roundness = 0;
 addText.buttonText = "Action";
 
 spriteSpeed = new Button(int(width*0.805), int(height*0.825), 80, 20);
 spriteSpeed.buttonText = "Speed";
 spriteSpeed.backColour(23, 54, 175);
 spriteSpeed.roundness = 0;
 
 deleteSlide = new Button(int(width*0.935), int(height*0.825), 80, 20);
 deleteSlide.buttonText = "Delete";
 deleteSlide.backColour(23, 54, 175);
 deleteSlide.roundness = 0;
 
  output = new Button(int(width*0.87), int(height*0.25), 150, 20);
  output.buttonText = "Output";
  output.backColour(23, 54, 175);
  output.roundness = 0;
 
 
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
     
  savePath = mainControl.addTextfield("file path")
     .setPosition(width*0.77,height*0.85)
     .setSize(140,30)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;

 addActionText = mainControl.addTextfield("Action file")
     .setPosition(width*0.77,height*0.2)
     .setSize(140,30)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
     
  addActionText.setVisible(false);
                  
 //list boxes
  sizeList = new ListBox("Tile Size", int(width*0.87), int(height*0.41), 150, 20);
  sizeList.colour(23, 54, 175);
  sizeList.addContent("72");
  sizeList.addContent("64");
  sizeList.addContent("32");
  sizeList.addContent("24");
  sizeList.addContent("16");
  
  typeList = new ListBox("Type", int(width*0.83), int(height*0.27), 110, 20);
  typeList.colour(23, 54, 175);
  typeList.addContent("Object");
  typeList.addContent("Scene L1");
  typeList.addContent("Scene L2");
  
  demensionsList = new ListBox("Demensions", int(width*0.87), int(height*0.10), 150, 20);
  demensionsList.colour(23, 54, 175);
  demensionsList.addContent("-");
  demensionsList.addContent("1/2");
  demensionsList.addContent("1");
  demensionsList.addContent("2");
  
  //scrollers
  leftRightScroller = new Scroller(int(width * 0.386), height - 10, height - 100, 20);
  leftRightScroller.colour(23, 54, 175);
  topDownScroller = new Scroller(10, int(height*0.567), 20, int(height - 80));
  topDownScroller.changeDem('y');
  topDownScroller.colour(23, 54, 175);
}
