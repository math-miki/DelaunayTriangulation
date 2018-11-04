import processing.video.*;
Capture camera;

DelaunayTriangulation delaunay;
ArrayList points;

void setup() {
  size(960, 640);
  points = new ArrayList();
  for(int i=0; i<700; i++) {
    points.add(new Point(random(width),random(height)));
  }
  points.add(new Point(0,height));
  points.add(new Point(width,height));
  points.add(new Point(width,0));
  points.add(new Point(0,0));

  delaunay = new DelaunayTriangulation(points, width, height);

  camera = new Capture(this, width, height, 12);
  camera.start();
}

void draw() {
  background(0);
  camera.loadPixels(); //カメラ画像のpixel情報を読み込み
  delaunay.dis(pixels);
}

//カメラの映像が更新されるたびに、最新の映像を読み込む
void captureEvent(Capture camera) {
  camera.read();
}
