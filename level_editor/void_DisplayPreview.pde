void DisplayPreview(){
  File file = new File(sketchPath(tileLoadText.getText()));
  if(displaying){
    image(prevIMG, width*0.8, height*0.7 + (tileMap.w/tileMap.cols), tileMap.cols, tileMap.rows);
    if(!(file.exists() && tileLoadText.getText().length() > 0)){
      displaying = false;
    }
  }else if(displaying == false && file.exists() && tileLoadText.getText().length() > 0 && tileLoadText.getText().charAt(0) != '/'){
    prevIMG = loadImage(tileLoadText.getText());
    displaying = true;
  }
} 