void settings() {
  size(1000, 1000, P3D);
}

void setup() {
  //noStroke();
}

float speed = 1;
float rx = 0;
float rz = 0;

void draw(){
  background(200);
  translate(width/2, height/2, width/8);
  rotateX(rx);
  rotateZ(rz);
  box(500, 50, 500);
}

void mouseDragged() 
{
  rx += 0.01 * (mouseY - pmouseY) * speed;
  rx = min(rx, PI/3);
  rx = max(rx, -PI/3);
  rz += 0.01 * (mouseX - pmouseX) * speed;
  rz = min(rz, PI/3);
  rz = max(rz, -PI/3);
  
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  speed += 0.05*e;
  speed = min(speed, 1.5);
  speed = max(speed, 0.2);
  
}