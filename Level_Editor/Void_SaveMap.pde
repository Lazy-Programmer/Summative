void SaveMap(){
  if(savePath.getText().length() > 0){
    JSONArray values = new JSONArray();
    
    float tempMapZoom = mapZoom;
    mapZoom = 1.0;
    tileMap.display();
    
    for(int i = 0; i < tileLocations.size(); i++){
      JSONObject tileObject = new JSONObject();
      
      tileObject.setInt("x", int(tileLocations.get(i).location.x));
      tileObject.setInt("y", int(tileLocations.get(i).location.y));
      tileObject.setInt("size", int(tileLocations.get(i).size));
      tileObject.setInt("type", tileLocations.get(i).type);
      tileObject.setFloat("orientation", tileLocations.get(i).orientation);
      tileObject.setFloat("demension", tileLocations.get(i).demensions);
      tileObject.setString("filename", tileLocations.get(i).filename);
      tileObject.setString("action", tileLocations.get(i).action);
      
      values.setJSONObject(i, tileObject);
    }
    
    mapZoom = tempMapZoom;
    tileMap.display();
    
    saveJSONArray(values, sketchPath(savePath.getText()));
    
    println("Map Saved to file " + savePath.getText());
  }
}
