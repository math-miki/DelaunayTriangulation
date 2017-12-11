ArrayList points;

DelaunayTriangulation delaunay;
void setup() {
  size(500,500);
  points = new ArrayList();
  for(int i=0; i<10; i++) {
    points.add(new Point(random(500),random(500)));
  }
  println(points);
  delaunay = new DelaunayTriangulation(points);
}

void draw() {
  background(255);
  delaunay.dis();
}