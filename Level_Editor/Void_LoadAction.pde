void LoadAction(String filename){
  File file = new File(sketchPath(filename));
  if(file.exists()){
    String tempText[] = loadStrings(sketchPath(filename));
    if(tempText.length > 0){
      actionText = tempText[0];
      println("Action File Loaded " + filename);
      if(tempText.length > 1){
        for(int i = 1; i < tempText.length; i++){
          actionText = actionText + tempText[i];
        }
      }
    }
  }
}
