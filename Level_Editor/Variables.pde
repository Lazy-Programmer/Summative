Grid tileMap;
GIFBox gifBox;
GIFAnimator gifPlayer;
boolean deletingSlides = false;
Timer timer;

//preview
PImage prevIMG;

//buttons
Button loadButton;
Button editTab;
Button loadTab;
Button GIFTab;
Button rotateButton;
Button spriteSpeed;
Button deleteSlide;
Button output;

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
float currOrientation;
