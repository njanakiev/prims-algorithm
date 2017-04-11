class EMST {
  // Input points
  ArrayList<PVector> points;
  // Number of input points
  int n;
  // Resulting edges
  ArrayList<Edge> edges;
  // Adjacency matrix
  float [][] graph;
  // Cost for each node 
  float distances[];
  // Store edges with shortest distances
  int p[];
  // Store if node has been visited
  boolean visited[];
  // Index of current node
  int current;
  // Index of total iterations
  int total;

  EMST(ArrayList<PVector> points) {
    this.points = points;
    n = points.size();
    graph = new float[n][n];
    edges = new ArrayList<Edge>();

    // Distances from node 
    distances = new float[n];
    p = new int[n];
    visited = new boolean[n];

    // Fill adjacency matrix
    for (int i = 0; i < n; i++) {
      graph[i][i] = -1;
      for (int j = (i + 1); j < n; j++) {
        float distance = points.get(i).dist(points.get(j));
        graph[i][j] = distance;
        graph[j][i] = distance;
      }
    }

    // Initialize 
    for (int i = 0; i < n; i++) {
      visited[i] = false;
      p[i] = -1;
      distances[i] = MAX_FLOAT;
    }

    current = 0;
    total = 0;
    distances[current] = 0;
    visited[current] = true;
  }

  boolean update() {
    if (total >= n) {
      return false;
    }
    for (int i = 0; i < n; i++) {
      if (graph[current][i] >= 0 && !visited[i]) {
        if (distances[i] > graph[current][i]) {
          distances[i] = graph[current][i];
          p[i] = current;
        }
      }
    }
    float minDistance = MAX_FLOAT;
    for (int i = 0; i < n; i++) {
      if (!visited[i] && distances[i] < minDistance) {
        minDistance = distances[i];
        current = i;
      }
    }

    // Add new edge to spanning tree
    PVector p0 = points.get(current);
    PVector p1 = points.get(p[current]);
    edges.add(new Edge(p0, p1));
    
    visited[current] = true;
    total++;

    return true;
  }

  void draw(float r) {
    strokeWeight(r*0.9);
    for (PVector p : points) {
      ellipse(p.x, p.y, r, r);
    }
    for (Edge e : edges) {
      line(e.p0.x, e.p0.y, e.p1.x, e.p1.y);
    }
  }
}

class Edge {
  PVector p0, p1;
  Edge(PVector p0, PVector p1) {
    this.p0 = p0;
    this.p1 = p1;
  }
}