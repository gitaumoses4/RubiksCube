color getColor(Side side) {
  switch(side) {
  case U:
    return #FFFFFF;
  case D:
    return #FFFF00;
  case F:
    return #00FF00;
  case B:
    return #0000FF;
  case L:
    return #FFA500;
  case R:
    return #FF0000;
  default:
    return 0;
  }
}


class Cube {

  private int length;
  private Cubie[][][] cubes = new Cubie[3][3][3];
  private int angle = 0;
  private Cubie[][] rotatingSide = null;
  private boolean clockwise = false;
  private Side side;
  private boolean rotate = false;

  public Cube(int length) {
    this.length = length;

    this.init();
  }


  public void init() {
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        for (int k=0; k<3; k++) {
          float offset = (3 * length) / 2 - length / 2;
          float x = length * i - offset;
          float y = length * j - offset;
          float z = length * k - offset;
          cubes[i][j][k] = new Cubie(x, y, z, length);
        }
      }
    }
  }


  public void rotateSide(Side side, boolean clockwise) {
    this.rotatingSide  = getCubes(side);
    rotate(this.rotatingSide, side, clockwise);


    this.rotate = true;
    this.clockwise = clockwise;
    this.side = side;
  }

  private Cubie[][] getCubes(Side side) {
    Cubie[][] c = new Cubie[3][3];
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        switch(side) {
        case U:
          c[i][j] = cubes[i][0][j];
          break;
        case D:
          c[i][j] = cubes[i][2][j];
          break;
        case F:
          c[i][j] = cubes[i][j][2];
          break;
        case B:
          c[i][j] = cubes[i][j][0];
          break;
        case L:
          c[i][j] = cubes[0][i][j];
          break;
        case R:
          c[i][j] = cubes[2][i][j];
          break;
        }
      }
    }
    return c;
  }

  private void rotate(Cubie c[][], Side side, boolean clockwise) {
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        int[] pos = calculatePosition(i, j, clockwise);
        println("("+i + ", " + j+ ") => ("+pos[0]+", "+pos[1]+")" );
        Cubie cubie = c[3 - j - 1][i];
        switch(side) {
        case U:
          cubes[i][0][j] = cubie;
          break;
        case D:
          cubes[i][2][j] = cubie;
          break;
        case F:
          cubes[i][j][2] = cubie;
          break;
        case B:
          cubes[i][j][0] = cubie;
          break;
        case L:
          cubes[0][i][j] = cubie;
          break;
        case R:
          cubes[2][i][j] = cubie;
          break;
        }
      }
    }
  }

  private int[] calculatePosition(int i, int j, boolean clockwise) {
    return !clockwise ? new int[]{3 - j - 1, i} : new int[]{j, 3 - i - 1};
  }

  public void show() {
    if ( rotate ) {
      angle++;
      if ( angle % 90 ==  0) {
        rotate = false;
        angle = 0;
      }
      for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
          Cubie c = rotatingSide[i][j];
          float rotate = clockwise ? 1 : -1;
          switch(side) {
          case U:
          case D:
            c.yRotate += rotate;
            break;
          case F:
          case B:
            c.zRotate += rotate;
            break;
          case L:
          case R:
            c.xRotate += rotate;
            break;
          }
        }
      }
      angle = angle % 360;
    }
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        for (int k=0; k<3; k++) {
          cubes[i][j][k].show();
        }
      }
    }
  }
}
