import peasy.*;

PeasyCam cam;

int length = 50;
Cube cube = new Cube(length);

HashMap<Character, Side> keyMap = new HashMap();

void setup() {
  size(1200, 800, P3D);
  cam = new PeasyCam(this, 400);
  keyMap.put('u', Side.U);
  keyMap.put('d', Side.D);
  keyMap.put('r', Side.R);
  keyMap.put('f', Side.F);
  keyMap.put('b', Side.B);
  keyMap.put('l', Side.L);
}


void draw() {
  background(50);
  rotateX(-0.3);
  rotateY(0.1);
  cube.show();
}

void keyPressed() {
  boolean clockwise = Character.isUpperCase(key);
  Side side = keyMap.get(Character.toLowerCase(key));
  if ( side != null) {
    cube.rotateSide(side, clockwise);
  }
  if( keyCode == BACKSPACE){
    cube = new Cube(length);
    cube.show();
  }
}
