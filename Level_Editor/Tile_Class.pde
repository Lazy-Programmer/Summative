class Tile{
  PVector location;
  String filename;
  int type;
  int size;
  float orientation;
  
  Tile(PVector tlocation, String tfilename, int tsize, int ttype, float torientation){
    location = tlocation;
    filename = tfilename;
    size = tsize; 
    type = ttype;
    orientation = torientation;
  }
}
