class Node { 
  private int value;
  private int nodeColor;
  private int x;
  private int y;
  
  Node (int value) {  
    this.value=value;
    this.nodeColor = 255;
  } 
  
  int getValue(){
    return this.value;
  }  
  
  void setColor (int newColor){
    this.nodeColor = newColor;
  }
  
  int getColor(){
    return nodeColor;
  }
  
  void setXY(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  int getX(){
    return this.x;
  }
  
  int getY(){
    return this.y;
  }
  
  //String colorToString(){
  //  switch(this.nodeColor) {
  //    case 255:
  //    return "white";
  //    case 155:
  //    return "gray";
  //    case 0: 
  //    return "black";
  //  }
  //  return null;
  //}
} 