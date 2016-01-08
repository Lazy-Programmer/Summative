void DisplayPreview(){
  File file = new File(sketchPath(tileLoadText.getText()));
  if(displaying){
    pushMatrix();
    translate(width*0.8, height*0.7 + (tileMap.w/tileMap.cols));
        rotate(radians(currOrientation));
        float tempX = 0, tempY = 0;
        if(currOrientation == 180){
          tempX = -tileMap.rows;
          tempY = -tileMap.cols;
        }else if(currOrientation == 90){
          tempY = -tileMap.cols;
        }else if(currOrientation == 270){
          tempX = -tileMap.rows;
        }
        translate(tempX, tempY);
        if(!(file.exists() && file.isFile() && tileLoadText.getText().length() > 0)){
          displaying = false;
        }else{
          image(prevIMG, 0, 0, tileMap.cols, tileMap.rows);
        }
    popMatrix();
  }else if(displaying == false && file.exists() && file.isFile() && tileLoadText.getText().length() > 0 && tileLoadText.getText().charAt(0) != '/'){
      prevIMG = loadImage(tileLoadText.getText());
      displaying = true;
  }
} 
