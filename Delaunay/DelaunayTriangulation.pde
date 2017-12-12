import java.util.Map;
import java.util.*;
class DelaunayTriangulation {
  HashSet triangleSet;

  public DelaunayTriangulation(ArrayList points) {
    doTriangulation(points);
  }
  public void doTriangulation(ArrayList pointList) {
    triangleSet = new HashSet();

    DTriangle baseTriangle = getBaseTriangle();
    triangleSet.add(baseTriangle);

    try {
      /* Do Triangulation */
      int i = 1;
      for (Iterator pIter = pointList.iterator(); pIter.hasNext();) {
        println(i++);
        Object element = pIter.next();
        Point p = element instanceof Point ? (Point)element: new Point((PVector)element);

        // println("u", triangleSet);
        HashMap tmpTriangleSet = new HashMap();

        for (Iterator tIter=triangleSet.iterator(); tIter.hasNext();) {
          DTriangle t = (DTriangle)tIter.next();
          Circle c = getCircumscrivedCircle(t);

          if (dist(c.c.x, c.c.y, p.x, p.y) <= c.r) {
            addElementToRedundanciesMap(tmpTriangleSet, new DTriangle(p, t.p1, t.p2));
            addElementToRedundanciesMap(tmpTriangleSet, new DTriangle(p, t.p2, t.p3));
            addElementToRedundanciesMap(tmpTriangleSet, new DTriangle(p, t.p1, t.p3));

            tIter.remove();
          }
        }
        for(Iterator tmpIter = tmpTriangleSet.entrySet().iterator(); tmpIter.hasNext();) {
          Map.Entry entry = (Map.Entry)tmpIter.next();
          Object t = entry.getKey();

          Boolean isUnique = ((Boolean)entry.getValue()).booleanValue();
          if (isUnique) {
            triangleSet.add(t);
          }
        }
      }
      for(Iterator tIter = triangleSet.iterator(); tIter.hasNext();) {
        DTriangle t = (DTriangle)tIter.next();
        if (baseTriangle.hasCommonPoints(t)) {
          tIter.remove();
        }
      }
    } catch (Exception ex) {
      return;
    }
  }

  private void addElementToRedundanciesMap(HashMap map, Object t) {
    if (map.containsKey((DTriangle)t)) {
      map.put(t, new Boolean(false));
    } else {
      map.put(t, new Boolean(true));
    }
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
  DTriangle getBaseTriangle() {
    /*
      画面に外接する円に外接する正方形
    */
    float r = sqrt(width*width/4.0 + height*height/4.0);
    float l = 2*r*sqrt(3);
    return new DTriangle(new Point(width/2.0, height/2.0 + r - sqrt(3)*l/2.0),new Point((width-l)/2.0,height/2.0+r),new Point((width+l)/2.0,height/2.0+r));
  }

  public void dis() {

    for(Iterator tIter=triangleSet.iterator(); tIter.hasNext();) {
      DTriangle t = (DTriangle)tIter.next();
      t.draw();
    }
  }
}
