import java.util.Map;   //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.Set;//<>// //<>//
import java.util.Iterator;

HashMap<Node, ArrayList<Node>> graph;
int nodeSize;

void setup() {  // setup() runs once

  size(700, 500);
  graph = createAdjazencyList(loadGraph());
  nodeSize = graph.entrySet().size();
  printGraph();
  setGraphNodesCoordinates();

  //TODO: pi array (länge von keys des graphen und die keys geben die nodes an), color array, visualisierung
}

void draw() {  // draw() loops forever, until stopped
  background(255);
  drawGraphEdges();
  drawGraphNodes();
}

Table loadGraph() {
  Table table = loadTable("graph.csv", "csv");
  return table;
}

HashMap<Node, ArrayList<Node>> createAdjazencyList(Table table) {

  HashMap<Node, ArrayList<Node>> graph = new HashMap<Node, ArrayList<Node>>();
  int columnsLength = table.getColumnCount();


  for (TableRow row : table.rows()) {
    Node parent = new Node(row.getInt(0));
    ArrayList<Node> neighbourList = new ArrayList<Node>();

    for (int i = 1; i < columnsLength; i++) {
      int value = row.getInt(i);
      if (value != 0) {
        neighbourList.add(new Node(value));
      }
    }
    graph.put(parent, neighbourList);
  }
  return graph;
}

void printGraph() {
  for (Map.Entry me : graph.entrySet()) {
    Node parent = (Node) me.getKey();

    ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
    println();
    print("Parent " + parent.getValue() + "->");
    for (Node node : neighbours) {
      print(" Kid " + node.getValue());
    }
  }
}

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

  for (Map.Entry me : graph.entrySet()) {
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
  }//end for
  setCoordinatesForNeighbours();
  //checkCoordinatesForNeighbours();
}
void drawNode(Node node) {
  fill(node.getColor());
  ellipse(node.getX(), node.getY(), 55, 55);
  textSize(20);
  fill(0, 102, 153);
  text(node.value, node.getX() -6, node.getY()+6);
}

boolean isHalf(int counter) {
  return counter > nodeSize/2;
}
boolean isEvenNodeSize() {
  return nodeSize%2 == 0;
}

boolean isEqual(Node parent, Node node) {
  return (parent.getX() == node.getX()) && (parent.getY() == node.getY());
}

void setCoordinatesForNeighbours() {
  for (Map.Entry me : graph.entrySet()) {
    ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
    for (Node node : neighbours) {
      Node parent = getParent(node.getValue());
      node.setXY(parent.getX(), parent.getY());
    }
  }
}

void checkCoordinatesForNeighbours() {
  for (Map.Entry me : graph.entrySet()) {
    Node parent = (Node) me.getKey();
    println("parent" + parent.getValue() + " hat " + parent.getX());
    ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
    for (Node node : neighbours) {
      println("kind " + node.getValue() + " hat " + node.getX());
    }
  }
}

void drawGraphEdges() {
  for (Map.Entry me : graph.entrySet()) {
    Node parent = (Node) me.getKey();
    ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
    for (Node node : neighbours) {
      //zeichne kurve
       fill(0);
      if (!isEqual(parent, node)) {
        if (parent.getX() == node.getX()) {
          //dann stehen die untereinander
          if (node.getX() - parent.getX() < 0) {
            //vhild oben
           
             ellipse(node.getX(), node.getY() + 28, 10, 15);
          } else {
            // child unten
            
            ellipse(node.getX(), node.getY() - -30, 10, 15);
          }
        } else if (parent.getY() == node.getY()) {
          //dann stehen die nebeneinander
          if (node.getY() - parent.getY() < 0) {
            //vhild rechts
            ellipse(node.getX() + 31, node.getY(), 10, 15);
          } else {
            // child links
            ellipse(node.getX() - -31, node.getY(), 10, 15);
          }
        } else {
          //quer
          if (node.getY() - parent.getY() < 0) {
            //vhild rechts
            ellipse(node.getX() + 61, node.getY() + 17, 10, 15);
          } else {
            // child links
            ellipse(node.getX() - 22, node.getY() - 21, 10, 15);
          }
        }
      }

      line(parent.getX(), parent.getY(), node.getX(), node.getY());
      //println("parent " +  parent.getX() + " " + parent.getY());
      println("child" +  node.getX() + " " + node.getY());
    }
  }
}

void drawGraphNodes() {
  for (Map.Entry me : graph.entrySet()) {
    Node parent = (Node) me.getKey();
    drawNode( parent);
  }
}

Node getParent(int atKey) {
  Set<Node> keys = graph.keySet();
  Iterator<Node> iterator = keys.iterator();
  while (iterator.hasNext()) {
    Node x = iterator.next();
    if (x.getValue() == atKey) {
      return x;
    }
  }
  return null;
}