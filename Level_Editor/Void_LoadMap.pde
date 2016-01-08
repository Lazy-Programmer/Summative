void LoadMap(){
  File file = new File(sketchPath(trueTileLoadText.getText()));
  int [] possibleSizes = {72, 64, 32, 24, 16};
  
  if(file.exists()){
    JSONArray values = loadJSONArray(sketchPath(trueTileLoadText.getText()));

    for (int i = 0; i < values.size(); i++) {
      JSONObject object = values.getJSONObject(i); 
      
      /*for(int j = 0; j < possibleSizes.length; j++){
        if(object.getInt("size") == possibleSizes[j]){
          tileMap.rows = tileMap.cols = int(sizeList.content.get(j));
          sizeList.currIndex = int(j);
          tileMap.XMove = tileMap.XOffset%tileMap.rows;
          tileMap.YMove = tileMap.YOffset%tileMap.cols;
          sizeList.status = "up";
        }
      }*/
      
      tileLocations.add(new Tile(new PVector(object.getInt("x"), object.getInt("y")), object.getString("filename"), object.getInt("size"), object.getInt("type"), object.getFloat("orientation")));
    }
    println("Map Loaded from file " + trueTileLoadText.getText());
  }else{
    println("No file exists called " + trueTileLoadText.getText());
  }
}
