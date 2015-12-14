class Tile{
  PVector location;
  String filename;
  String type;
  int size;
  
  Tile(PVector tlocation, String tfilename, int tsize, String ttype){
    location = tlocation;
    filename = tfilename;
    size = tsize; 
    type = ttype;
  }
}