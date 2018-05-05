import java.util.ArrayDeque; //<>//

// Global variables
private Graph graph;               // Graph class
private Node u;                    // Current node
private ArrayDeque<Node> queue;    // queue for DFS
private ArrayDeque<Node> removed;  // list with nodes which are not considered in DFS
private Node[] pi;                 // Neighbours list

private ArrayDeque<Integer> inputNumbers = new ArrayDeque<Integer>();  // user sets the start node                  
private PFont font;
private int input = 0;  // users input for start node
private boolean start = false; // if there is no input from the user for the start node then start = false else true

void setup() { 
  size(900, 800);  // window size
  background(255); // backgroud color
  frameRate(1);    // frame rate for DFS, change here to make it faster

  queue = new ArrayDeque<Node>();
  removed = new ArrayDeque<Node>();
  
  graph = new Graph(loadGraph()); // Parse csv to graph
  graph.drawGraphEdges();
  graph.drawGraphNodes();
  
  // The font for start node text
  font = createFont("Arial", 22);
  textFont(font);
}

void draw() { // endless loop
  background(255);
  graph.drawGraphEdges();
  graph.drawGraphNodes();

  if (!start) {  // if there is no input from the user for the start node then start = false else true
    if (input==0) {  // if there is no input from the user for the start node 
      text("Start node: press start node number on the keyboard", 4, 29);
    } else {
      int decimal = 1;
      input = 0;
      for (int i : inputNumbers) {
        print(i);
        input = (i * decimal) + input;
        decimal*=10;
      }
      text("Start node: " + input, 4, 29);
    }
  } else {
    if (! (queue.size() == 0)) { // if there are some nodes to search for DFS
    
      // get the neighbours from current node u
      ArrayList<Node> neighbours = graph.getGraphADJ().get(u); 
      
      if (neighbours.isEmpty() & u.isGray()) { // if u is Gray or has no neighbours
        // then it will be black, taken away from the queue list and added to removed list
        u.setColor(u.BLACK_C);
        removed.addFirst(u);
        queue.removeFirst();
        u = queue.getFirst();
      } else {
        u.setColor(u.GRAY_C);
        int neighbourSize = neighbours.size();
        int coloredNeighbours = 0;
        
        for (Node v : neighbours) {
          if (v.isWhite()) { // take the white neighbour v from u
            pi[v.getValue()-1] = u; // update the neighbour list
            v.setColor(u.GRAY_C);   // make him gray
            // v is now the current node
            queue.addFirst(v);      
            u=v;
            break;
          } else if (!v.isWhite()) {
            coloredNeighbours++;
          }
          if (neighbourSize == coloredNeighbours) {
            // if all neighbours of u are colored then make him black
            u.setColor(u.BLACK_C);
            removed.addFirst(u);
            queue.removeFirst();
            if (!queue.isEmpty()) { // if there are still nodes in the queue take the next one
              u = queue.getFirst();
            }
          }
          graph.drawGraphEdges();
          graph.drawGraphNodes();
          printPI(pi);
        }    
      }
    }
  }
}


void keyPressed() { // listening to keyboard
  int keyNum = Character.getNumericValue(key);
  if (keyNum<=9 && keyNum>0) {
    input = keyNum;
    inputNumbers.addFirst(input); // save all the input numbers from user
  } else if (key == BACKSPACE) {
    inputNumbers.removeFirst();
  } else if (key == ENTER) {
    Node startNode = graph.getParent(input);
    if (graph.isValid(startNode)) { 
      start = true;
      queue.addFirst(startNode);
      u = startNode; 
      pi = new Node[graph.getKeyNodes().size()];
    }
  }
} 

Table loadGraph() {
  Table table = loadTable("data/graph.csv", "csv");
  return table;
}

  void printPI(Node[] pi) {
    println("------ PI ------");
    for (int i = 0; i < pi.length; i++) {
      if (pi[i] == null) {
        println("Node" + (i+1) + " PI = / ");
      } else {
        println("Node" + (i+1) + " PI = " + pi[i].getValue());
      }
    }
  }
