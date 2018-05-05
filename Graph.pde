import java.util.Map;    //<>// //<>//
import java.util.Set; //<>// //<>//
import java.util.Iterator;

class Graph {

  private HashMap<Node, ArrayList<Node>> graphADJ;
  private int nodeSize; // amound of nodes in graph
  private final int NODE_DISTANCE = 100;

  Graph(Table table) {
    graphADJ = new HashMap<Node, ArrayList<Node>>();
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
  boolean isOneUnderAnother(Node parent, Node node) {
    return parent.getX() == node.getX();
  }
  boolean isOneNextToAnother(Node parent, Node node) {
    return parent.getY() == node.getY();
  }
  boolean isOneDiagonalToAnother(Node parent, Node node) {
    return parent.getX() == node.getX();
  }
  boolean isHorizontalNeighbour(Node parent, Node node) {
    return isOneUnderAnother(parent, node) & (abs(parent.getY() - node.getY()) == NODE_DISTANCE);
  }
  boolean isVerticalNeighbour(Node parent, Node node) {
    return isOneNextToAnother(parent, node) & (abs(parent.getX() - node.getX()) == NODE_DISTANCE);
  }
  boolean isDiagonalNeighbour(Node parent, Node node) {
    return (abs(parent.getX() - node.getX()) == NODE_DISTANCE) & (abs(parent.getY() - node.getY()) == NODE_DISTANCE);
  }
  boolean isValid(Node node){
    return node!=null;
  }
  
  /*+++++++++++++++++++++++++++++++++++++++ GET SET */
  
  /** Sets to frame coordinates from every node from the graph */
  void setGraphNodesCoordinates() {
    int startNodeX = 100;
    int startNodeY = 100;
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
        y+=NODE_DISTANCE;
      } else {
        if (counter <= ceil(nodeSize/2.0)) {
          parent.setXY(x, y);
          drawNode( parent);
          x+=NODE_DISTANCE;
        } else {
          parent.setXY(x, y);
          drawNode( parent);
          x+=NODE_DISTANCE;
        }
      }
      if (counter == ceil(nodeSize/2.0)) {
        x = startNodeX;
        y+=NODE_DISTANCE;
      }
    }
  }
  
  // Returns the node with the sepcific key value
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
 
  // Returns adjacenzy list
  HashMap<Node, ArrayList<Node>> getGraphADJ() {
    return graphADJ;
  }
  
  // Returns all nodes from graph
  Set<Node> getKeyNodes() {
    return  graphADJ.keySet();
  }

  // Returns a specific node from the parent list (all nodes)
  Node getNodeFromParentList(ArrayList<Node> parents, int value) {
    for (Node node : parents) {
      if (node.getValue() == value) {
        return node;
      }
    }
    return null;
  }

  /*++++++++++++++++++++++++++++++++++++++++ DRAWING */
  void drawNode(Node node) {
    stroke(0);
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
        if (isHorizontalNeighbour(parent, node) | isVerticalNeighbour(parent, node) | isDiagonalNeighbour(parent, node)) { //stehen untereinander
          drawArrow(parent.getX(), parent.getY(), 30, node.getX(), node.getY(), 30, 2.0 );
        } else { 
          drawArrow2(parent.getX(), parent.getY(), 30, node.getX(), node.getY(), 30, 2.0 );
        }
      }
    }
  }

/* COPY PASTE CODE ! https://forum.processing.org/one/topic/drawing-an-arrow-from-the-edge-of-a-circle-to-another-circle-s-edge.html*/
  public void drawArrow(float cx0, float cy0, float rad0, float cx1, float cy1, float rad1, float thickness) {
    // These will be the points on the circles circumference
    float px0, py0, px1, py1;
    // the angle of the line joining centre of circle c0 to c1
    float angle = atan2(cy1-cy0, cx1-cx0);
    px0 = cx0 + rad0 * cos(angle);
    py0 = cy0 + rad0 * sin(angle);
    px1 = cx1 + rad1 * cos(angle + PI);
    py1 = cy1 + rad1 * sin(angle + PI);
    // Calculate the arrow length and head size
    float arrowLength = sqrt((px1-px0)*(px1-px0) +(py1-py0)*(py1-py0));
    float arrowSize = 2.5 * 2.0;
    // Setup arrow colours and thickness
    strokeWeight(2.0);
    stroke(0);
    fill(0, 0, 0);
    // Set the drawing matrix as if the arrow starts
    // at the origin and is along the x-axis
    pushMatrix();
    translate(px0, py0);
    rotate(angle);
    // Draw the arrow shafte
    line(0, 0, arrowLength, 0);
    //  draw the arrowhead
    beginShape(TRIANGLES);
    vertex(arrowLength, 0); // point
    vertex(arrowLength - arrowSize, -arrowSize);
    vertex(arrowLength - arrowSize, arrowSize);
    endShape();
    popMatrix();
  }

/* COPY PASTE CODE ! https://forum.processing.org/one/topic/drawing-an-arrow-from-the-edge-of-a-circle-to-another-circle-s-edge.html*/
  public void drawArrow2(float cx0, float cy0, float rad0, float cx1, float cy1, float rad1, float thickness) {
    // These will be the points on the circles circumference
    float px0, py0, px1, py1;
    // the angle of the line joining centre of circle c0 to c1
    float angle = atan2(cy1-cy0, cx1-cx0);
    px0 = cx0 + rad0 * cos(angle) ;
    py0 = cy0 + rad0 * sin(angle) ;
    px1 = cx1 + rad1 * cos(angle + PI) ;
    py1 = cy1 + rad1 * sin(angle + PI) ;
    // Calculate the arrow length and head size
    float arrowLength = sqrt((px1-px0)*(px1-px0) +(py1-py0)*(py1-py0));
    float arrowSize = 2.5 * 2.0;
    // Setup arrow colours and thickness

    // Set the drawing matrix as if the arrow starts
    // at the origin and is along the x-axis
    pushMatrix();
    stroke(cx0, cx1, 155);
    noFill();
    beginShape();
    curveVertex(620, 71);
    curveVertex(px0, py0);
    curveVertex(px1, py1);
    curveVertex(214, 356);
    endShape();

    strokeWeight(1.0);
    stroke(cx0, cx1, 1);
    fill(cx0, cx1, 155);
    translate(px0, py0);
    rotate(angle);

    beginShape(TRIANGLES);
    vertex(arrowLength, 0); // point
    vertex(arrowLength - arrowSize, -arrowSize);
    vertex(arrowLength - arrowSize, arrowSize);
    endShape();
    popMatrix();
  }
  /**************************************************** OTHERS */
  // Creates the adjazency list from the csv file
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
    return this.graphADJ;
  }
} //END CLASS
