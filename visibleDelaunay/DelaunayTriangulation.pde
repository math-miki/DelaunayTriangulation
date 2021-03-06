import java.util.Map;
import java.util.*;
class DelaunayTriangulation {
  HashSet triangleSet;
  int w;
  int h;
  Boolean imageSet;
  color[] pix;
  ArrayList DelaunayPoints;
  DTriangle baseTriangle;
  public DelaunayTriangulation(ArrayList points, int _w, int _h) {
    DelaunayPoints = points;
    w = _w;
    h = _h;
    imageSet = false;

    triangleSet = new HashSet();
    baseTriangle = getBaseTriangle(width+100, height+100);
    triangleSet.add(baseTriangle);
  }
  public void setImage(color[] pixels) {
    pix = pixels;
    imageSet = true;
  }
  public void addPoint(Point newPoint) {
    this.DelaunayPoints.add(newPoint);
    doTriangulation(newPoint);
  }
  private void doTriangulation(Point newPoint) {

    print(" a ", triangleSet.size());
    try {
      /* Do Visible Triangulation */

      for (Iterator pIter = DelaunayPoints.iterator(); pIter.hasNext(); ) {
        Object element = pIter.next();
        Point p = (Point)element;

        HashMap tmpTriangleSet = new HashMap();

        for (Iterator tIter=triangleSet.iterator(); tIter.hasNext(); ) {
          DTriangle t = (DTriangle)tIter.next();
          Circle c = getCircumscrivedCircle(t);

          if (dist(c.c.x, c.c.y, p.x, p.y) <= c.r) {
            addElementToRedundanciesMap(tmpTriangleSet, new DTriangle(p, t.p1, t.p2));
            addElementToRedundanciesMap(tmpTriangleSet, new DTriangle(p, t.p2, t.p3));
            addElementToRedundanciesMap(tmpTriangleSet, new DTriangle(p, t.p1, t.p3));
            tIter.remove();
          } else {
            addElementToRedundanciesMap(tmpTriangleSet, t);
          }
        }
        print(" b ", tmpTriangleSet.size());

        triangleSet.clear();
        for (Iterator tmpIter = tmpTriangleSet.entrySet().iterator(); tmpIter.hasNext(); ) {
          Map.Entry entry = (Map.Entry)tmpIter.next();
          Object t = entry.getKey();

          Boolean isUnique = ((Boolean)entry.getValue());
          if (isUnique) {
            triangleSet.add((DTriangle)t);
          }
        }
      } //

      //for(Iterator tIter = triangleSet.iterator(); tIter.hasNext();) {
      //  DTriangle t = (DTriangle)tIter.next();
      //  if (baseTriangle.hasCommonPoints(t)) {
      //    tIter.remove();
      //  }
      //}
      disMid();
      println("Round: ", DelaunayPoints.size(), "Ts", triangleSet.size());
    } 
    catch (Exception ex) {
      println(ex);
      return;
    }
  }

  private void addElementToRedundanciesMap(HashMap map, DTriangle t) {
    for (Iterator tIt = map.entrySet().iterator(); tIt.hasNext(); ) {
      Map.Entry entry = (Map.Entry) tIt.next();
      DTriangle t_i = (DTriangle)entry.getKey();
      if (t.isSameTriangle(t_i)) {
        map.put(t_i, new Boolean(false));

        return;
      }
    }
    map.put(t, new Boolean(true));
  }

  private Circle getCircumscrivedCircle(DTriangle t) {
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

    return new Circle(new Point(cx, cy), r);
  }
  DTriangle getBaseTriangle(int w, int h) {
    /*
      画面に外接する円に外接する正三角形
     */
    float r = sqrt(w*w/4.0 + h*h/4.0);
    float l = 2*r*sqrt(3);
    return new DTriangle(new Point(w/2.0, h/2.0 + r - sqrt(3)*l/2.0), new Point((w-l)/2.0, h/2.0+r), new Point((w+l)/2.0, h/2.0+r));
  }

  private void dis() {
    if (!(imageSet)) {
      println("====================================\nNone Image\n====================================");
      return;
    }
    HashSet disTriangleSet = new HashSet();
    disTriangleSet = getDisTriangles();
    for (Iterator tIter=disTriangleSet.iterator(); tIter.hasNext(); ) {
      DTriangle t = (DTriangle)tIter.next();
      Point p = t.returnGravity();
      if (0 <= p.x && p.x <= width && 0 <= p.y && p.y <= height) {
        int x = (int)(p.x*w / (width+100));
        int y = (int)(p.y*h / (height+100));
        t.draw(pix[abs(y)*w + abs(x)]);
      } else {
        //print("b");
      }
    }
  }
  private void disMid() {
    if (!(imageSet)) {
      println("====================================\nNone Image\n====================================");
      return;
    }
    HashSet disTriangleSet = new HashSet();
    disTriangleSet = getDisTriangles();
    for (Iterator tIter=disTriangleSet.iterator(); tIter.hasNext(); ) {
      DTriangle t = (DTriangle)tIter.next();
      if ( baseTriangle.hasCommonPoints(t) ) {
      } else {
        Point p = t.returnGravity();
        if (0 <= p.x && p.x <= width && 0 <= p.y && p.y <= height) {
          int x = (int)(p.x*w / (width+100));
          int y = (int)(p.y*h / (height+100));
          t.draw(pix[abs(y)*w + abs(x)]);
        } else {
          //print("b");
        }
      }
    }
  }
  private HashSet getDisTriangles() {
    HashSet hoge = this.triangleSet;
    for (Iterator tIter = hoge.iterator(); tIter.hasNext(); ) {
      DTriangle t = (DTriangle)tIter.next();
      if (baseTriangle.hasCommonPoints(t)) {
        tIter.remove();
      }
    }
    return hoge;
  }
}