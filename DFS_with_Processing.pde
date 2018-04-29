import java.util.Map; 

void setup() {  // setup() runs once
  HashMap<Node, ArrayList<Node>> graph = createAdjazencyList(loadGraph());
  printGraph(graph);
  
  //TODO: pi array (länge von keys des graphen und die keys geben die nodes an), color array, visualisierung
}

void draw() {  // draw() loops forever, until stopped
}

Table loadGraph() {

  Table table = loadTable("graph.csv", "csv");
  return table; 
}

HashMap<Node, ArrayList<Node>> createAdjazencyList(Table table){
 
  HashMap<Node, ArrayList<Node>> graph = new HashMap<Node, ArrayList<Node>>();
  int columnsLength = table.getColumnCount();
  
  for (TableRow row : table.rows()) {
    Node parent = new Node(row.getInt(0));
    ArrayList<Node> neighbourList = new ArrayList<Node>();
    
    for(int i = 1; i < columnsLength; i++){
      int value = row.getInt(i);
      if(value != 0){
         neighbourList.add(new Node(value));
      }
    }
    graph.put(parent, neighbourList);
  }
  return graph;
}


void printGraph(HashMap<Node, ArrayList<Node>> graph) {
  for (Map.Entry me : graph.entrySet()) {
    Node keyNode = (Node) me.getKey();
  
    ArrayList<Node> neighbours = ( ArrayList<Node>) me.getValue();
    println();
    print("Parent " + keyNode.getValue() + "->");
    for (Node node : neighbours) {
      print(" Kid " + node.getValue());
    }
  }
}
