import java.util.Map;   //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.Set;//<>// //<>// //<>//
import java.util.Iterator;

class Graph {
  
  private  HashMap<Node, ArrayList<Node>> graphADJ = new HashMap<Node, ArrayList<Node>>();
  private int nodeSize;
  
   Graph(Table table) {
    graphADJ = createAdjazencyList(table);
    nodeSize = graphADJ.entrySet().size();
    setGraphNodesCoordinates();
  }
  
  /***************************************** QUESTIONS */
 boolean isHalf(int counter) {
    return counter > nodeSize/2;
  }
  boolean isEvenNodeSize() {
    return nodeSize%2 == 0;
  }

  boolean isEqual(Node parent, Node node) {
    return (parent.getX() == node.getX()) && (parent.getY() == node.getY());
  }
  
  /*+++++++++++++++++++++++++++++++++++++++ GET SET */
  
  void setGraphNodesCoordinates() {

    int startNodeX = 100;
    int startNodeY = 60;
    int x = startNodeX;
    int y = startNodeY;
    int counter = 0;
    boolean firstNode = false;
    
    if (!isEvenNodeSize()) {
      firstNode = true;
    }

    for (Map.Entry me : graphADJ.entrySet()) {
      Node parent = (Node) me.getKey();
      counter++;
      if (firstNode) {
        parent.setXY(startNodeX, startNodeY);
        drawNode(parent);
        firstNode = false;
        y+=100;
      } else {
        if (counter <= ceil(nodeSize/2.0)) {
          parent.setXY(x, y);
          drawNode( parent);
          x+=100;
        } else {
          parent.setXY(x, y);
          drawNode( parent);
          x+=100;
        }
      }
      if (counter == ceil(nodeSize/2.0)) {
        x = startNodeX;
        y+=100;
      }
    }
    
   // setCoordinatesForNeighbours();
    //checkCoordinatesForNeighbours();
  }
  
    void setCoordinatesForNeighbours() {
    for (Map.Entry me : graphADJ.entrySet()) {
      ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
      for (Node node : neighbours) {
        Node parent = getParent(node.getValue());
        node.setXY(parent.getX(), parent.getY());
      }
    }
  }
  
    Node getParent(int atKey) {
    Set<Node> keys = graphADJ.keySet();
    Iterator<Node> iterator = keys.iterator();
    while (iterator.hasNext()) {
      Node x = iterator.next();
      if (x.getValue() == atKey) {
        return x;
      }
    }
    return null;
  }
  
   HashMap<Node, ArrayList<Node>> getGraphADJ(){
     return graphADJ;
  }
  
   Set<Node> getKeyNodes(){
     return  graphADJ.keySet();
   }
   
   Node getNodeFromParentList(ArrayList<Node> parents, int value){
     for(Node node : parents){
       if(node.getValue() == value){
         return node;
       }
     }
   return null;
   }
  
  /*++++++++++++++++++++++++++++++++++++++++ DRAWING */
  
  
  void drawNode(Node node) {
    fill(node.getColor());
    ellipse(node.getX(), node.getY(), 55, 55);
    textSize(20);
    fill(0, 102, 153);
    text(node.value, node.getX() -6, node.getY()+6);
  }

void drawGraphNodes() {
  for (Map.Entry me : graphADJ.entrySet()) {
    Node parent = (Node) me.getKey();
    drawNode( parent);
  }
}


  void drawGraphEdges() {
    for (Map.Entry me : this.graphADJ.entrySet()) {
      Node parent = (Node) me.getKey();
      ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
      for (Node node : neighbours) {
        //zeichne kurve
        fill(36,180,221);
        if (!isEqual(parent, node)) {
          if (parent.getX() == node.getX()) {
            //dann stehen die untereinander
            if (node.getY() - parent.getY() > 0) {
              //vhild oben
              ellipse(node.getX(), node.getY() - 28, 10, 10);
            } else {
              // child unten

              ellipse(node.getX(), node.getY()  +30, 10, 10);
            }
          } else if (parent.getY() == node.getY()) {
            //dann stehen die nebeneinander
            if (node.getX() - parent.getX() > 0) {
              //child rechts
              ellipse(node.getX() - 31, node.getY(), 10, 10);
            } else {
              // child links
              ellipse(node.getX() + 31, node.getY(), 10, 10);
            }
          } else {
            //quer
            if (node.getX() - parent.getX() > 0) {
              //child rechts
              if (node.getY() - parent.getY() < 0) {
                //child rechts oben
                ellipse(node.getX() - 22, node.getY() + 22, 10, 10);
              } else {
                //child reechts unten
                ellipse(node.getX() - 22, node.getY() - 22, 10, 10);
              }
            } else {
              // child links
              if (node.getY() - parent.getY() > 0) {
                //child links unten
                ellipse(node.getX() + 22, node.getY()  - 22, 10, 10);
              } else {
                //child links oben
                ellipse(node.getX() + 22, node.getY() + 22, 10, 10);
              }
            }
          }
        }
        line(parent.getX(), parent.getY(), node.getX(), node.getY());
      }
    }
  }

/**************************************************** OTHERS */

void checkCoordinatesForNeighbours() {
    for (Map.Entry me : graphADJ.entrySet()) {
      Node parent = (Node) me.getKey();
      println("parent" + parent.getValue() + " hat " + parent.getX());
      ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
      for (Node node : neighbours) {
        println("kind " + node.getValue() + " hat " + node.getX());
      }
    }
  }
  
  HashMap<Node, ArrayList<Node>> createAdjazencyList(Table table) {
    int columnsLength = table.getColumnCount();
    
    ArrayList<Node> parents = new ArrayList<Node>();
    for (TableRow row : table.rows()) {
      Node node = new Node(row.getInt(0)); 
      parents.add(node);
    }
    
    int counter=0;
    for (TableRow row : table.rows()) {
      ArrayList<Node> neighbourList = new ArrayList<Node>();
      for (int i = 1; i < columnsLength; i++) {
        int value = row.getInt(i);
        if (value != 0) {
          neighbourList.add(getNodeFromParentList(parents, value));
        }
      }
      graphADJ.put(parents.get(counter), neighbourList);
      counter++;
    }
    printGraph();
    return this.graphADJ;
  }

  void printGraph() {
    for (Map.Entry me : graphADJ.entrySet()) {
      Node parent = (Node) me.getKey();
      ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
      println();
      print("Parent " + parent.getValue() + "->");
      for (Node node : neighbours) {
        print(" Child " + node.getValue());
      }
    }
  }
  
  
} //END CLASS