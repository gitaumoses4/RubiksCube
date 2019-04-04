import peasy.*;

PeasyCam cam;
Cube cube = new Cube(50);

void setup(){
  size(1200, 800, P3D);
  cam = new PeasyCam(this, 400);
}


void draw(){
  background(50);
  rotateX(-0.3);
  rotateY(0.1);
  cube.show();
}

void keyPressed(){
  boolean clockwise = true;
  Side side = Side.F;
  if ( key == 'u'){
    side = Side.U;
  }else if( key == 'f'){
    side = Side.F;
  }
  
  cube.rotateSide(side, clockwise);
}
