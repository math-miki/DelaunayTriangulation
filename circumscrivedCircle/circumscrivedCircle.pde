
Particle[] pars;

void setup() {
  pars = new Particle[3];
  size(500,500);
}

void draw() {
  background(255);
  for(int i=0; i<3; i++) {
      if(pars[i] != null) {
        noStroke();
        fill(200,50,50);
        ellipse(pars[i].x,pars[i].y,4,4);
      } else {
        return;
      }
  }
  fill(50);
  triangle(pars[0].x,pars[0].y,pars[1].x,pars[1].y,pars[2].x,pars[2].y);
  drawCircumscrivedCircle(pars[0].x,pars[0].y,pars[1].x,pars[1].y,pars[2].x,pars[2].y);
}
void drawCircumscrivedCircle(float x1,float y1,float x2,float y2,float x3,float y3) {
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
  float r = sqrt((l*l)/4.0 + (m*m)/4.0 - n);
  stroke(55);
  noFill();
  ellipse(cx,cy,r,r);
  println(cx,cy,r);
}
void mousePressed() {
  for(int i=0; i<3; i++) {
    if(pars[i] == null) {
      pars[i] = new Particle(mouseX, mouseY);
      return;
    }
  }
  pars = new Particle[3];
  pars[0] = new Particle(mouseX, mouseY);
}

class Particle {
  float x;
  float y;
  Particle(float _x, float _y) {
    x = _x;
    y = _y;
  }
}
