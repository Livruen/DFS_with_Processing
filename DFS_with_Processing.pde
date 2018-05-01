//<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.ArrayDeque;

Graph graph;
DFS dfs;
Node u;
ArrayDeque<Node> queue;
ArrayDeque<Node> removed;
ArrayList<Node> pi;
ArrayDeque<Integer> number = new ArrayDeque<Integer>();                      
PFont font;
int input = 0;
boolean start = false;

void setup() {  // setup() runs once
  size(700, 500);
  background(255);
  frameRate(1);

  graph = new Graph(loadGraph());
  dfs = new DFS();

  graph.drawGraphEdges();
  graph.drawGraphNodes();
  queue = new ArrayDeque<Node>();
  removed = new ArrayDeque<Node>();

  //Entering start node
  font = createFont("Arial", 22);
  textFont(font);

}

void draw() {
  background(255);
  graph.drawGraphEdges();
  graph.drawGraphNodes();
   if(!start){
    if (input==0) {
       text("Start node: " , 4, 29);
    } else {
      int decimal = 1;
      input = 0;
      for (int i : number) {
        print(i);
        input = (i * decimal) + input;
        decimal*=10;
      }
      text("Start node: " + input, 4, 29);
    }
  } else {
    if (! (queue.size() == 0)) {
      ArrayList<Node> neighbours = graph.getGraphADJ().get(u);
      if (neighbours.isEmpty() & (u.getColor() == u.GRAY_C)) {
        u.setColor(u.BLACK_C);
        removed.addFirst(u);
        queue.removeFirst();
        u = queue.getFirst();
      } else {
        u.setColor(u.GRAY_C);
        int neighbourSize = neighbours.size();
        int grayNeighbour = 0;
        for (Node v : neighbours) {
          if (v.getColor() == v.WHITE_C) {
            v.setPi(u.getValue());
            v.setColor(u.GRAY_C);
            queue.addFirst(v);
            u=v;
            break;
          } else if ((v.getColor() == v.GRAY_C) | (v.getColor() == v.BLACK_C)) {
            grayNeighbour++;
          }
          if (neighbourSize == grayNeighbour) {
            u.setColor(u.BLACK_C);
            removed.addFirst(u);
            queue.removeFirst();
            if (!queue.isEmpty()) {
              u = queue.getFirst();
            }
          }
          graph.drawGraphEdges();
          graph.drawGraphNodes();
        }
      }
    }
    println("---- PI -----");
    for (Node node : graph.getKeyNodes()) {
      println(node.getValue() + " -> " + node.getPi() );
    }
  }
}

void keyPressed() {
  int keyNum = Character.getNumericValue(key);
  if (keyNum<=9 && keyNum>0) {
    input = keyNum;
    number.addFirst(input);
  } else if (key == BACKSPACE) {
    number.removeFirst();
  } else if(key == ENTER){
    start = true;
    Node startNode = graph.getParent(input);
    queue.addFirst(startNode);
    u = startNode; 
  }
} 

Table loadGraph() {
  Table table = loadTable("data/graph.csv", "csv");
  return table;
}
