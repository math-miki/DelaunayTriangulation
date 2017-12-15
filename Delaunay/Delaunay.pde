import java.awt.datatransfer.DataFlavor;

ArrayList points;
PImage img;
color[] pix;
DelaunayTriangulation delaunay;

void setup() {
  //size(1500,1200);
  size(1500,1500);
  points = new ArrayList();
  for(int i=0; i<2000; i++) {
    points.add(new Point(random(width+100),random(height+100)));
  }

    points.add(new Point(0,height));
    points.add(new Point(width,height));
    points.add(new Point(width,0));
    points.add(new Point(0,0));
  println(points);
  delaunay = new DelaunayTriangulation(points);
  noLoop();
  img = loadImage("a.jpg");
  pix = img.pixels;
}

void draw() {

translate(-50,-50);
  println("draw");
  background(255);
  delaunay.dis(pix);
  println("drawed");
}

void mouseClicked() {

}

void keyPressed() {

  // Pのキーが入力された時に保存
  if(key == 'p' || key == 'P') {
    // デスクトップのパスを取得
    String path  = System.getProperty("user.home") + "/Desktop/screenshot" + "a" + ".jpg";

    // 保存
    save(path);

    // 番号を加算

    // ログ用途
    println("screen saved.");
  }
}
