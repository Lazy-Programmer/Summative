void LoadMap(String filepath) {
  JSONArray values = loadJSONArray(sketchPath(filepath));

  for (int i = 0; i < values.size(); i++) {//load walls
    JSONObject entity = values.getJSONObject(i);
    String action = entity.getString("action") + "   ";
    boolean isAlreadyLoaded = false;
    int imageID = -1;
    for (int j = 0; j < imagesLoaded.size(); j++) {//check all the loaded filenames
      if (imagesLoaded.get(j).equals(entity.getString("filename"))) {// if the filename from the object matches that of one in the list
        isAlreadyLoaded = true;//it is already loaded
        imageID = j;//give it its image ID
      }
    }
    if (isAlreadyLoaded == false) {//if it is not already loaded
      imageHolder.add(loadImage(entity.getString("filename")));//loadthe image
      imageID = imagesLoaded.size();//give the image id
      imagesLoaded.add(entity.getString("filename"));//add the name of the file to the loaded list
    }
    if(action.charAt(0) == 'c' && action.charAt(1) == 'a' && action.charAt(2) == 't' && action.charAt(3) == ' '){
      cats.add(new Cat_Enemy(new PVector(entity.getInt("x"), entity.getInt("y")),25));
      /*if(myPlayer.dashCoolDown == -1){
        myPlayer.dashCoolDown = 0;
      }*/
    }else if(action.charAt(0) == 'b' && action.charAt(1) == 'i' && action.charAt(2) == 'r' && action.charAt(3) == 'b'){
      birbs.add(new Birb_Enemy(new PVector(entity.getInt("x"), entity.getInt("y")),0));
    }else if (entity.getFloat("demension") < 0) {
      int type = entity.getInt("type");
      walls.add(new Wall(new PVector(entity.getInt("x") + (entity.getInt("size")/2), entity.getInt("y") + (entity.getInt("size")/2)), new PVector(entity.getInt("size"), entity.getInt("size")), entity.getFloat("orientation"), imageID, entity.getString("action")));
      if (type > 0) {
        walls.get(walls.size() - 1).tangible = false;
      }
    } else {
      int type = entity.getInt("type");
      if (entity.getFloat("orientation") == 90 || entity.getFloat("orientation") == 270) {
        walls.add(new Wall(new PVector(entity.getInt("x") + (loadImage(sketchPath(entity.getString("filename"))).height*entity.getFloat("demension")/2), entity.getInt("y") + (loadImage(sketchPath(entity.getString("filename"))).width*entity.getFloat("demension")/2)), new PVector(loadImage(sketchPath(entity.getString("filename"))).width*entity.getFloat("demension"), loadImage(sketchPath(entity.getString("filename"))).height*entity.getFloat("demension")), entity.getFloat("orientation"), imageID, entity.getString("action")));
      } else {
        walls.add(new Wall(new PVector(entity.getInt("x") + (loadImage(sketchPath(entity.getString("filename"))).width*entity.getFloat("demension")/2), entity.getInt("y") + (loadImage(sketchPath(entity.getString("filename"))).height*entity.getFloat("demension")/2)), new PVector(loadImage(sketchPath(entity.getString("filename"))).width*entity.getFloat("demension"), loadImage(sketchPath(entity.getString("filename"))).height*entity.getFloat("demension")), entity.getFloat("orientation"), imageID, entity.getString("action")));
      }
      if (type > 0) {
        walls.get(walls.size() - 1).tangible = false;
      }
    }
  }
  //organize(); will mess up the layering
  reduce();
}

void organize() {//was going to be used in conjunction with an algorithm to combine tiles to increase performance, but changing the way images were loaded/stored gave us all the performance we needed
  boolean loop = false;
  do {
    loop = false;
    for (int i = 1; i < walls.size(); i++) {//for all the walls
      if (walls.get(i).size.x == 32 && walls.get(i).size.y == 32 && walls.get(i-1).size.x == 32 && walls.get(i-1).size.y == 32) {
        if (walls.get(i).position.y < walls.get(i-1).position.y) {//if the wall in question has a lower y value than that before it, swap them
          Collections.swap(walls, i, i-1);
          loop = true;//and loop again
        } else if (walls.get(i).position.x < walls.get(i-1).position.x && walls.get(i).position.y == walls.get(i-1).position.y) {//otherwise if the walls has a lower x value than that of the one before it swap them
          Collections.swap(walls, i, i-1);
          loop = true;//and loop again
        }
      } else {
      }
    }
  } while (loop == true);//keep loooping untill nothing is changed
}

void reduce() {
  organize();
  /*boolean again = false;
   do {
   again = false;
   ArrayList<Wall> reducedwalls = new ArrayList<Wall>();
   for (int i = walls.size() -1; i >= 0; i--) {
   for (int j = walls.size() - 1; j >= 0; j--) {
   if (walls.get(j) != walls.get(i) && walls.get(i).mark == false && walls.get(j).mark == false && walls.get(i).imageIndex != 0) {
   if (walls.get(i).intersects(walls.get(j)) && walls.get(i).tangible == walls.get(j).tangible && walls.get(i).imageIndex == walls.get(j).imageIndex && walls.get(i).orientation == walls.get(j).orientation && (walls.get(i).size.x == walls.get(j).size.x || walls.get(i).size.y == walls.get(j).size.y)) {
   reducedwalls.add( walls.get(i).combine(walls.get(j)) );
   reducedwalls.get(reducedwalls.size()-1).tangible = walls.get(i).tangible;
   walls.get(i).mark = true;
   walls.get(j).mark = true;
   again = true;
   }
   }
   }
   }
   for (int i = walls.size() -1; i >= 0; i --) {
   if (walls.get(i).mark == true) {
   walls.remove(i);
   }
   }
   walls.addAll(0, reducedwalls);
   } while (again);
   for (int i = 0; i < walls.size(); i++) {
   print(walls.get(i).position);
   }*/
  boolean again = false;
  do {
    again = false;
    ArrayList<Wall> combined = new ArrayList<Wall>();
    for (int i = 0; i < walls.size()-1; i++) {
      /*PVector size = new PVector(walls.get(i).size.x, walls.get(i).size.y);
       PVector position = new PVector(walls.get(i).position.x, walls.get(i).position.y);
       */int j = 1;
      if ( walls.get(i).intersects(walls.get(i+j)) && walls.get(i).tangible == walls.get(i+j).tangible && walls.get(i).imageIndex == walls.get(i + j).imageIndex && walls.get(i).orientation == walls.get(i + j).orientation && walls.get(i).size.y == walls.get(i+j).size.y && walls.get(i).action.equals(walls.get(i+j).action) && walls.get(i+1).mark == false && walls.get(i).mark == false && walls.get(i).imageIndex != 0) {
        /*size.x += walls.get(i+j).size.x;
         walls.get(i).size = size;
         position.x +=  walls.get(i+j).size.x/2;
         walls.get(i).position = position;
         walls.get(i+j).mark = true;
         print(position);
         println(size);
         j++;*/
        combined.add(walls.get(i).combine(walls.get(i+1)));
        combined.get(combined.size()-1).tangible = walls.get(i).tangible;
        combined.get(combined.size()-1).group = true;
        walls.get(i).mark = true;
        walls.get(i+1).mark = true;
        again = true;
      } else {
        //combined.add(new Wall(position, size, walls.get(i).orientation, walls.get(i).imageIndex, walls.get(i).action));
        //i += j;
      }
    }
    for (int i = walls.size() -1; i >= 0; i --) {
      if (walls.get(i).mark == true) {
        walls.remove(i);
      }
    }
    walls.addAll(0, combined);
  } while (again == true);
}
