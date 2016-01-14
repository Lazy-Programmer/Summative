Grid tileMap;
GIFBox gifBox;
GIFAnimator gifPlayer;
boolean deletingSlides = false;
boolean addingAction = false;
String actionText;
Timer timer;

//preview
PImage prevIMG;

//buttons
Button loadButton;
Button editTab;
Button loadTab;
Button GIFTab;
Button addText;
Button rotateButton;
Button spriteSpeed;
Button deleteSlide;
Button output;

//Controls
ListBox sizeList;
ListBox typeList;
ListBox demensionsList;
Textfield tileLoadText;
Textfield savePath;
Textfield trueTileLoadText;
Textfield addActionText;
Scroller leftRightScroller;
Scroller topDownScroller;

//functionallity variables
boolean displaying = false;
ArrayList <Tile> tileLocations = new ArrayList<Tile>(1);
String state = "edit";
float mapZoom = 1.0;
float currOrientation;
float currDemensions = -1;
