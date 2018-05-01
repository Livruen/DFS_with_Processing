import java.util.Map;   //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.Set;//<>//
import java.util.Iterator;

class DFS {
  Graph graph;

  void startDFS(Graph graph, int startNode) {
    this.graph = graph;
    Node s = graph.getParent(startNode);
    DFS_VISIT(s);
  }

  void DFS_VISIT(Node u) {
    u.setColor(u.GRAY_C);
    
    ArrayList<Node> neighbours = graph.getGraphADJ().get(u);
    for (Node v : neighbours) {
      if (v.getColor() == v.WHITE_C) {
        v.setPi(u.getPi());
        delay(100);
        DFS_VISIT(v);
      }

      graph.drawGraphEdges();
      graph.drawGraphNodes();
    }
    u.setColor(u.BLACK_C);

    graph.drawGraphEdges();
    graph.drawGraphNodes();
    gosleep();

  }


void gosleep() {
   int stoptime=millis()+1;
    while(stoptime>millis()){
    stoptime++;
  }
}
}
