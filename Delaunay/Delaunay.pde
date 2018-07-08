import java.awt.datatransfer.DataFlavor;

ArrayList points;
PImage img;
color[] pix;
int w;
int h;
DelaunayTriangulation delaunay;
public void settings() {
  size(1000,1000);
}

void setup() {
  //size(1500,1200);
  points = new ArrayList();
  img = loadImage("a.jpg");
  w = img.width;
  h = img.height;
  for(int i=0; i<500; i++) {
    points.add(new Point(random(width+100)/1,random(height+100)/1));
  }

  points.add(new Point(0,height));
  points.add(new Point(width,height));
  points.add(new Point(width,0));
  points.add(new Point(0,0));
  println(points);
  delaunay = new DelaunayTriangulation(points, img.width, img.height);
  noLoop();
  pix = img.pixels;
}

void draw() {
  translate(-50,-50);
  println("draw");
  background(255);
  delaunay.dis(pix,img.width, img.height);
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
