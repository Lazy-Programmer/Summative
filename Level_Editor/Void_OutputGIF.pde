void OutputGIF(){
    JSONArray values = new JSONArray();
    
    for(int i = 0; i < gifPlayer.slides.size(); i++){
      JSONObject tileObject = new JSONObject();
      
      tileObject.setInt("speed", gifPlayer.fps);
      tileObject.setString("slide", gifPlayer.filenames.get(i));
      
      values.setJSONObject(i, tileObject);
    }
    
    saveJSONArray(values, "output.anim");
    println("Gif Saved to file output.anim");
}
