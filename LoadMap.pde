void LoadMap(String filepath){
  JSONArray values = loadJSONArray(sketchPath(filepath));
  
  for(int i = 0; i < values.size(); i++){//load walls
    JSONObject entity = values.getJSONObject(i);
    if(entity.getFloat("demension") < 0){
      int type = entity.getInt("type");
      walls.add(new Wall(new PVector(entity.getInt("x") + (entity.getInt("size")/2), entity.getInt("y") + (entity.getInt("size")/2)), new PVector(entity.getInt("size"), entity.getInt("size")), entity.getFloat("orientation"), entity.getString("filename"), entity.getString("action")));
      if(type > 0){
        walls.get(walls.size() - 1).tangible = false;
      }
    }else{
      int type = entity.getInt("type");
      walls.add(new Wall(new PVector(entity.getInt("x") + (loadImage(sketchPath(entity.getString("filename"))).width*entity.getFloat("demension")/2), entity.getInt("y") + (loadImage(sketchPath(entity.getString("filename"))).height*entity.getFloat("demension")/2)), new PVector(loadImage(sketchPath(entity.getString("filename"))).width*entity.getFloat("demension"), loadImage(sketchPath(entity.getString("filename"))).height*entity.getFloat("demension")), entity.getFloat("orientation"), entity.getString("filename"), entity.getString("action")));
      if(type > 0){
        walls.get(walls.size() - 1).tangible = false;
      }
    }
  }
}
