ArrayList points;

DelaunayTriangulation delaunay;
Boolean b1 = true;
void setup() {
  //size(1500,1200);
  size(700,700);
  points = new ArrayList();

  for(int i=0; i<500; i++) {
    points.add(new Point(random(700),random(700)));
  }

    points.add(new Point(0,height));
    points.add(new Point(width,height));
    points.add(new Point(width,0));
    points.add(new Point(0,0));
  println(points);
  delaunay = new DelaunayTriangulation(points, b1);
  noLoop();
}

void draw() {
// translate(400,500);
  print(b1);
  println("draw");
  background(255);
  delaunay.dis();
  println("drawed");
}

void mouseClicked() {
  b1 = !b1;
  delaunay = new DelaunayTriangulation(points, b1);
  draw();
}
