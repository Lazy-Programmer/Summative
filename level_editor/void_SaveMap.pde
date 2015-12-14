void SaveMap(){
  JSONArray values = new JSONArray();
  
  for(int i = 0; i < tileLocations.size(); i++){
    JSONObject tileObject = new JSONObject();
    
    tileObject.setInt("x", int(tileLocations.get(i).location.x));
    tileObject.setInt("y", int(tileLocations.get(i).location.y));
    tileObject.setInt("size", int(tileLocations.get(i).size));
    tileObject.setString("type", tileLocations.get(i).type);
    tileObject.setString("filename", tileLocations.get(i).filename);
    
    values.setJSONObject(i, tileObject);
  }
  
  saveJSONArray(values, sketchPath(savePath.getText()));
  println("Map Saved to file " + savePath.getText());
}