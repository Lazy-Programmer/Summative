abstract class NonLiving extends Entity {//Solomon, I not quite sure we need a nonLiving class, an entity would do just fine, however for organization purposes it works
  NonLiving(PVector tposition, PVector tsize, PVector tvelocity, float torientation /* GIF STUFF*/) {
    super(tposition, tsize, tvelocity, torientation/*GIF STUFF*/, 1000);
  }
  /*void doNothing(){
   }*/
}
