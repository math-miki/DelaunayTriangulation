ArrayList points;

DelaunayTriangulation delaunay;
void setup() {
  size(500,500);
  points = new ArrayList();
  points.add(new Point(0,0));
  points.add(new Point(0,height));
  points.add(new Point(width,0));
  points.add(new Point(width,height));
  for(int i=0; i<15; i++) {
    points.add(new Point(random(500),random(500)));
  }
  println(points);
  delaunay = new DelaunayTriangulation(points);
}

void draw() {
  background(255);
  delaunay.dis();
}
