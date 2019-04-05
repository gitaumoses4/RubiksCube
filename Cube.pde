class Cube {

  private int length;
  private Cubie[][][] cubes = new Cubie[3][3][3];
  private int angle = 0;
  private Cubie[][] rotatingSide = null;
  private boolean clockwise = false;
  private Side side;
  private boolean rotate = false;
  private int threshold = 30;
  private int shuffle = 0;
  private int rotateSpeed = 5;
  private int shuffleSpeed = 15;

  public Cube(int length) {
    this.length = length;
    this.init();
  }

  public void init() {
    int index = 0;
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        for (int k=0; k<3; k++) {
          index++;
          float offset = (3 * length) / 2 - length / 2;
          float x = length * i - offset;
          float y = length * j - offset;
          float z = length * k - offset;
          if ( cubes[i][j][k] == null) {
            cubes[i][j][k] = new Cubie(x, y, z, length, index);
          } else {
            cubes[i][j][k].setPoint(new PVector(x, y, z));
          }
        }
      }
    }
  }

  public void shuffle() {
    this.shuffle = threshold;
    this.rotateSide(randomSide(), ((int)random(100)) % 2 == 0);
  }

  public void shuffle(int threshold) {
    this.threshold = threshold;
    this.shuffle();
  }

  public Side randomSide() {
    Side[] sides = Side.values();
    return sides[(int)random(sides.length - 1)];
  }


  public void rotateSide(Side side, boolean clockwise) {
    this.rotatingSide  = getCubes(side);
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

  private void rotate() {
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        int[] pos = calculatePosition(i, j, side == Side.U || side == Side.D ? clockwise : !clockwise);     
        Cubie cubie = rotatingSide[pos[0]][pos[1]];
        cubie.rotate(side, clockwise);
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
    this.init();
  }

  private int[] calculatePosition(int i, int j, boolean clockwise) {
    return clockwise ? new int[]{3 - j - 1, i} : new int[]{j, 3 - i - 1};
  }


  public void show() {
    if ( rotate ) {
      angle += (shuffle > 0 ? shuffleSpeed : rotateSpeed);
      if ( angle % 90 ==  0) {
        rotate = false;
        angle = 0;
        rotate();
      }
      for (int i=0; i<cubes.length; i++) {
        for (int j=0; j<cubes[i].length; j++) {
          Cubie c = rotatingSide[i][j];
          float rotate = clockwise ? angle : -angle;
          switch(side) {
          case U:
          case D:
            c.yRotate = rotate;
            break;
          case F:
          case B:
            c.zRotate = rotate;
            break;
          case L:
          case R:
            c.xRotate = rotate;
            break;
          }
        }
      }
      angle = angle % 360;
      if (angle % 90 == 0) {
        if ( shuffle > 0) {
          this.rotateSide(randomSide(), ((int)random(100)) % 2 == 0);
          shuffle--;
        }
      }
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
