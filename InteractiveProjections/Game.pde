void settings() {
  size(1000, 1000, P3D);
}

void setup() {
  //noStroke();
}

float speed = 1;
void draw(){
  background(200);
  camera(width/8, -height/8, -width/2, 250, 250, 0, 0, 1, 0);
  translate(width/4, height/3, width/4);
  float rx = map(mouseY, 0, height/speed, -PI/3, PI/3);
  float rz = map(mouseX, 0, width, -PI/3, PI/3);
  rotateX(rx);
  rotateZ(rz);
  
  
  
  box(500, 50, 500);
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  speed += 0.1*e;
  
  if(speed >= 1.5){
    speed = 1.5;
  } else if (speed <= 0.2) {
    speed = 0.2;
  }
}
