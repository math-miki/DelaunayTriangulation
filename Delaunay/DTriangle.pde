class DTriangle {
  Point p1,p2,p3;
  DTriangle(Point _p1, Point _p2, Point _p3) {
    p1 = _p1;
    p2 = _p2;
    p3 = _p3;
  }
  boolean equals(Object o) {
    try {
      DTriangle t = (DTriangle)o;
      return true;
    } catch (Exception ex) {
      return false;
    }
  }
  void dis() {
    triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
  }
}
