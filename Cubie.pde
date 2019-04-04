class Cubie {

  private PVector point;
  private int length;
  
  public float xRotate = 0, yRotate = 0, zRotate = 0;

  Cubie(float x, float y, float z, int length) {
    this.point = new PVector(x, y, z);
    this.length = length;
  }


  void show() {
    fill(255);
    stroke(0);
    strokeWeight(8);
    pushMatrix();
    
    float center =(3 * length) / 2;
    translate(0, 0, 0);
    rotateX(radians(xRotate));
    translate(0,0, 0);
    rotateY(radians(yRotate));
    translate(0, 0, 0); 
    rotateZ(radians(zRotate));
    
    
    translate(point.x , point.y, point.z);
    

    beginShape(QUADS);

    for (Side side : Side.values()) {
      fill(getColor(side));
      drawSide(side);
    }
    endShape();
    popMatrix();
  }

  void drawSide(Side side) {
    float r = length / 2;
    float a[] = {-r, -r, r, r};
    float b[] = {-r, r, r, -r};
    float c[] = {r, r, r, r};
    float d[] = {-r, -r, -r, -r};


    float x[] = a, y[] = b, z[] = c;
    switch(side) {
    case U:
      y = c;
      z = b;
      break;
    case D:
      y = d;
      z = b;
      break;
    case F:
      z = c;
      break;
    case B:
      z = d;
      break;
    case L:
      x = d;
      z = a;
      break;
    case R:
      x = c;
      z = a;
      break;
    }

    for (int i=0; i<4; i++) {
      vertex(x[i], y[i], z[i]);
    }
  }
}
