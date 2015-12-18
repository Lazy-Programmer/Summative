class Tile{
  PVector location;
  String filename;
  int type;
  int size;
  
  Tile(PVector tlocation, String tfilename, int tsize, int ttype){
    location = tlocation;
    filename = tfilename;
    size = tsize; 
    type = ttype;
  }
}
