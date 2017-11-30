void setup() {

}

void draaw() {

}

Circle CircumscrivedCircle(DTriangle t) {
  float x1 = t.p1.x;
  float y1 = t.p1.y;
  float x2 = t.p2.x;
  float y2 = t.p2.y;
  float x3 = t.p3.x;
  float y3 = t.p3.y;

  float x12 = x1-x2;
  float x13 = x1-x3;
  float y12 = y1-y2;
  float y13 = y1-y3;
  float z21 = x2*x2 + y2*y2 - x1*x1 - y1*y1;
  float z31 = x3*x3 + y3*y3 - x1*x1 - y1*y1;
  float l = (y12*z31 - y13*z21) / (x13*y12 - x12*y13);
  float m = (z21 - x12*l)/y12;
  float n = -1*(x1*x1 + y1*y1 + x1*l + y1*m);
  float cx = -1*l/2.0;
  float cy = -1*m/2.0;
  float r = sqrt((l*l + m*m)/4.0 - n);

  return new Circle(new Point(cx, cy), r)
}
