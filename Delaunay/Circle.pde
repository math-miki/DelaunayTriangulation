class Circle {
  Point c;
  float r;
  Circle(Point _c; float _r) {
    c = _c;
    t = _r;
  }

  dis() {
    ellipse(c.x,c.y,2*r,2*r);
  }
}
