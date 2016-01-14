class Tile{
  PVector location;
  String filename;
  String action;
  int type;
  int size;
  float orientation;
  float demensions;
  
  Tile(PVector tlocation, String tfilename, int tsize, int ttype, float torientation, float tdem){
    location = tlocation;
    filename = tfilename;
    size = tsize; 
    type = ttype;
    orientation = torientation;
    demensions = tdem;
    action = "  ";
  }
  
  Tile(PVector tlocation, String tfilename, int tsize, int ttype, float torientation, float tdem, String taction){
    location = tlocation;
    filename = tfilename;
    size = tsize; 
    type = ttype;
    orientation = torientation;
    demensions = tdem;
    action = taction;
  }
}
