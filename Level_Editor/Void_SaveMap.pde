void SaveMap(){
  if(savePath.getText().length() > 0){
    JSONArray values = new JSONArray();
    
    for(int i = 0; i < tileLocations.size(); i++){
      JSONObject tileObject = new JSONObject();
      
      tileObject.setInt("x", int(tileLocations.get(i).location.x));
      tileObject.setInt("y", int(tileLocations.get(i).location.y));
      tileObject.setInt("size", int(tileLocations.get(i).size));
      tileObject.setInt("type", tileLocations.get(i).type);
      tileObject.setFloat("orientation", tileLocations.get(i).orientation);
      tileObject.setString("filename", tileLocations.get(i).filename);
      
      values.setJSONObject(i, tileObject);
    }
    
    saveJSONArray(values, sketchPath(savePath.getText()));
    
    println("Map Saved to file " + savePath.getText());
  }
}
