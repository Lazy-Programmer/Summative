void SaveMap(){
  if(savePath.getText().length() > 0){
    JSONArray values = new JSONArray();
    
    for(int i = 0; i < tileLocations.size(); i++){
      JSONObject tileObject = new JSONObject();
      
      tileObject.setInt("x", int(tileLocations.get(i).location.x));
      tileObject.setInt("y", int(tileLocations.get(i).location.y));
      tileObject.setInt("size", int(tileLocations.get(i).size));
      tileObject.setInt("type", tileLocations.get(i).type);
      tileObject.setString("filename", tileLocations.get(i).filename);
      
      values.setJSONObject(i, tileObject);
    }
    
    saveJSONArray(values, sketchPath(savePath.getText()));
    
    //create one image
    /*int largeW = 0;
    int largeH = 0;
    for(int i = 0; i < tileLocations.size(); i++){
      if(tileLocations.get(i).location.x > largeW){
        largeW = int(tileLocations.get(i).location.x + tileLocations.get(i).size);
      }
      if(tileLocations.get(i).location.y > largeH){
        largeH = int(tileLocations.get(i).location.y + tileLocations.get(i).size);
      }
    }
    
    PImage combineImage = createImage(largeW, largeH, RGB);
    PImage map = loadImage("tile.png");
    combineImage = map.get();
    combineImage.save("output.png");*/
    println("Map Saved to file " + savePath.getText());
  }
}
