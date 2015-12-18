Grid tileMap;

//preview
PImage prevIMG;

//buttons
Button loadButton;
Button editTab;
Button loadTab;

//Controls
ListBox sizeList;
ListBox typeList;
Textfield tileLoadText;
Textfield savePath;
Textfield trueTileLoadText;
Scroller leftRightScroller;
Scroller topDownScroller;

//functionallity variables
boolean displaying = false;
ArrayList <Tile> tileLocations = new ArrayList<Tile>(1);
String state = "edit";
float mapZoom = 1.0;
