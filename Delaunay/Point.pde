class Point extends PVector {
  public Point() {
    super();
  }
  public Point(float x, float y) {
    super(x,y);
  }
  public Point(Point v) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
  }
  public Point(PVector v) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
  }

  boolean equals(Object o) {
    try {
      PVector p = (PVector)o;
      return (x == p.x && y == p.y && z == p.z);
    } catch (Exception ex) {
      return false;
    }
  }
}
