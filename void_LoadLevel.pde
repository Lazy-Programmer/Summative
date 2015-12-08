void LoadLevel(String filepath){
  JSONArray values = loadJSONArray(sketchPath("../" + filepath));
  
  for(int i = 0; i < values.size(); i++){//load walls
    JSONObject entity = values.getJSONObject(i);
    int type = entity.getInt("type");
    println(str(type == 0));
    if(type == 0){
      println("yes");
      walls.add(new Wall(new PVector(entity.getInt("x"), entity.getInt("y")) , new PVector(entity.getInt("w"), entity.getInt("h")) ,5, mainView));
    }
  }
}
