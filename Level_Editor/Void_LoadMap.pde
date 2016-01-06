void LoadMap(){
  File file = new File(sketchPath(trueTileLoadText.getText()));
  
  if(file.exists()){
    JSONArray values = loadJSONArray(sketchPath(trueTileLoadText.getText()));

    for (int i = 0; i < values.size(); i++) {
      
      JSONObject object = values.getJSONObject(i); 
      tileLocations.add(new Tile(new PVector(object.getInt("x"), object.getInt("y")), object.getString("filename"), object.getInt("size"), object.getInt("type"), object.getFloat("orientation")));
    }
    println("Map Loaded from file " + trueTileLoadText.getText());
  }else{
    println("No file exists called " + trueTileLoadText.getText());
  }
}
