class Cubie { //<>//

  public static final color WHITE = #FFFFFF;
  public static final color YELLOW = #FFFF00;
  public static final color GREEN = #00FF00;
  public static final color BLUE = #0000FF;
  public static final color ORANGE = #FFA500;
  public static final color RED = #FF0000;

  private PVector point;
  private int length;
  private int index;

  public float xRotate = 0, yRotate = 0, zRotate = 0;
  private HashMap<Side, Integer> config = new HashMap();

  Cubie(float x, float y, float z, int length, int index) {
    this.point = new PVector(x, y, z);
    this.length = length;
    this.index = index;
    config.put(Side.U, WHITE);
    config.put(Side.D, YELLOW);
    config.put(Side.F, GREEN);
    config.put(Side.B, BLUE);
    config.put(Side.L, ORANGE);
    config.put(Side.R, RED);
  }
  
  
  public void setPoint(PVector point){
    this.point = point;
  }

  @Override
    public String toString() {
    return index+"";
  }


  void show() {
    fill(255);
    stroke(0);
    strokeWeight(8);
    pushMatrix();

    translate(0, 0, 0);
    rotateX(radians(xRotate));
    translate(0, 0, 0);
    rotateY(radians(yRotate));
    translate(0, 0, 0); 
    rotateZ(radians(zRotate));


    translate(point.x, point.y, point.z);

    beginShape(QUADS);

    for (Side side : Side.values()) {
      fill(config.get(side));
      drawSide(side);
    }
    endShape();
    popMatrix();
  }


  public void rotate(Side side, boolean clockwise) {
    HashMap<Side, Integer> temp = new HashMap(config);
    switch(side) {
    case U:
    case D:
      config.put(Side.F, clockwise ? temp.get(Side.L) : temp.get(Side.R));
      config.put(Side.R, clockwise ? temp.get(Side.F) : temp.get(Side.B));
      config.put(Side.B, clockwise ? temp.get(Side.R) : temp.get(Side.L));
      config.put(Side.L, clockwise ? temp.get(Side.B) : temp.get(Side.F));
      break;
    case F:
    case B:
      config.put(Side.U, clockwise ? temp.get(Side.R) : temp.get(Side.L));
      config.put(Side.R, clockwise ? temp.get(Side.D) : temp.get(Side.U));
      config.put(Side.D, clockwise ? temp.get(Side.L) : temp.get(Side.R));
      config.put(Side.L, clockwise ? temp.get(Side.U) : temp.get(Side.D));
      break;
    case R:
    case L:
      config.put(Side.U, clockwise ? temp.get(Side.B) : temp.get(Side.F));
      config.put(Side.F, clockwise ? temp.get(Side.U): temp.get(Side.D));
      config.put(Side.D, clockwise ? temp.get(Side.F) : temp.get(Side.B));
      config.put(Side.B, clockwise ? temp.get(Side.D): temp.get(Side.U));
      break;
    }
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
      pushMatrix();
      //text(index+"", 0, 0, 0);
      popMatrix();

    for (int i=0; i<4; i++) {
      vertex(x[i], y[i], z[i]);
    }
  }
}
