
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
  float cx;
  float cy;
  float r;
  float a = dist(x1,y1,x2,y2);
  float b = dist(x2,y2,x3,y3);
  float c = dist(x1,y1,x3,y3);
  float conC = (a*a + b*b - c*c)/(2.0*a*b);
  float sinC = sqrt(1.0-conC*conC);
  float l1 = 1/((y2-y1)/(x2-x1));
  float v1 = (x2-x1)*l1/2.0 + (y2-y1)/2.0;
  float l2 = 1/((y3-y1)/(x3-x1));
  float v2 = (x3-x1)*l1/2.0 + (y3-y1)/2.0;
  cx=(y3-y2)/(l2-l1);
  cy= -1*l1*cx + v1;
  r = c / sinC;
  stroke(55);
  noFill();
  ellipse(x1+cx,y1+cy,r,r);

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
