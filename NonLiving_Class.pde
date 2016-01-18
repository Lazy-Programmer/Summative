abstract class NonLiving extends Entity {//remnants of a time long forgotten
  NonLiving(PVector tposition, PVector tsize, PVector tvelocity, float torientation /* GIF STUFF*/) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/, 1000);
    team = -1;
  }
  /*void doNothing(){
   }*/
}
