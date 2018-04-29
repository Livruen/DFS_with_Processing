class Node { 
  private final int WHITE_C = 255;
  private final int GRAY_C = 155;
  private final int BLACK_C = 0;
  private int value;
  private int nodeColor;
  private int x;
  private int y;
  private int pi;
  
  Node (int value) {  
    this.value=value;
    this.nodeColor = WHITE_C;
    this.pi = 0;
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
  
  void setPi(int pi){
    this.pi = pi;
  }
  
   int getPi(){
    return pi;
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