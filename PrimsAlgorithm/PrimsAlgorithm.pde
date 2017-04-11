ArrayList<PVector> generateGrid(int n, float rOffset){
  ArrayList<PVector> points = new ArrayList<PVector>();
  float factor = 0.05; // border in percentage
  for(int i=0; i<n; i++){
    for(int j=0; j<n; j++){
      float u = (float) i / (float) (n - 1);
      float v = (float) j / (float) (n - 1);
      float x = map(u, 0, 1, factor*width,  (1 - factor)*width);
      float y = map(v, 0, 1, factor*height, (1 - factor)*height);
      
      PVector offset = PVector.random2D();
      offset.setMag(rOffset);
      
      points.add(new PVector(x + offset.x, y + offset.y));
    }
  }
  return points;
}

ArrayList<PVector> generateRandomPoints(int n){
  ArrayList<PVector> points = new ArrayList<PVector>();
  float factor = 0.05; // border in percentage
  for(int i=0; i<n; i++){
    float x = random(factor*width,  (1 - factor)*width);
    float y = random(factor*height, (1 - factor)*height);
    points.add(new PVector(x, y));
  }
  return points;
}

EMST tree;
boolean saveFrames = false;
int lastFrameCount = 20;

void setup(){
  ArrayList<PVector> points = generateRandomPoints(1000);
  //ArrayList<PVector> points = generateGrid(10, 10);
  tree = new EMST(points); //<>//
  
  size(600, 600);
  stroke(0);
  fill(0);
}

void draw(){
  background(255);
  tree.draw(2);
  
  if(!tree.update()){
    lastFrameCount--;
  }
  
  if(saveFrames && lastFrameCount > 0){
    saveFrame("frames/#####.png");
  }
}