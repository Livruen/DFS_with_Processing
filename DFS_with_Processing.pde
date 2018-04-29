 //<>// //<>// //<>// //<>//
Graph graph;
DFS dfs;

void setup() {  // setup() runs once
  size(700, 500);
  background(255);
 frameRate(2);
  graph = new Graph(loadGraph());
  graph.drawGraphEdges();
  graph.drawGraphNodes();
  dfs = new DFS();
  int s = 1;
  sleep();
  //dfs.startDFS(graph, s);
}


Table loadGraph() {
  Table table = loadTable("data/graph.csv", "csv");
  return table;
}

 void sleep() {
    int stoptime = 0;
    while (stoptime>1000)
    {stoptime++;}
  }