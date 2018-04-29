class Node { 
  int value;
  int nodeColor;
  Node (int value) {  
    this.value=value;
    this.nodeColor = 0;
  } 
  
  int getValue(){
    return this.value;
  }  
  
  String colorToString(){
    switch(this.nodeColor) {
      case 0:
      return "white";
      case 1:
      return "gray";
      case 2: 
      return "black";
    }
    return null;
  }
} 