void LoadMap(String filepath){
  JSONArray values = loadJSONArray(sketchPath(filepath));
  
  for(int i = 0; i < values.size(); i++){//load walls
    JSONObject entity = values.getJSONObject(i);
    int type = entity.getInt("type");
    walls.add(new Wall(new PVector(entity.getInt("x") + (entity.getInt("size")/2), entity.getInt("y") + (entity.getInt("size")/2)), new PVector(entity.getInt("size"), entity.getInt("size")), 0, entity.getString("filename")));
    walls.get(walls.size()-1).orientation = entity.getFloat("orientation");
    if(type == 1){
      walls.get(walls.size() - 1).tangible = false;
    }
  }
}
