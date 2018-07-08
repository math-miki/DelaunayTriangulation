class DHashableTriangle {
  Point p1,p2,p3;
  int hashX;
  int hashY;
  DHashableTriangle(Point _p1, Point _p2, Point _p3) {
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
  void draw(color c) {
    stroke(0);
    strokeWeight(1);
    fill(c);
    //fill(random(255));
    // noFill();
    stroke(c);
    triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
  }

  Boolean hasCommonPoints (DTriangle t) {
      return (p1.equals(t.p1) || p1.equals(t.p2) || p1.equals(t.p3) ||
              p2.equals(t.p1) || p2.equals(t.p2) || p2.equals(t.p3) ||
              p3.equals(t.p1) || p3.equals(t.p2) || p3.equals(t.p3) );
  }

  Boolean isSameTriangle (DTriangle t) {
    return ((p1.equals(t.p1) && p2.equals(t.p2) && p3.equals(t.p3)) ||
            (p1.equals(t.p1) && p2.equals(t.p3) && p2.equals(t.p2)) ||
            (p1.equals(t.p2) && p2.equals(t.p3) && p3.equals(t.p1)) ||
            (p1.equals(t.p2) && p2.equals(t.p1) && p3.equals(t.p3)) ||
            (p1.equals(t.p3) && p2.equals(t.p1) && p3.equals(t.p2)) ||
            (p1.equals(t.p2) && p2.equals(t.p2) && p3.equals(t.p1)) );
  }
  Point returnGravity() {
    float x = (p1.x + p2.x + p3.x) / 3.0;
    float y = (p1.y + p2.y + p3.y) / 3.0;

    return new Point(x,y);
  }
}
