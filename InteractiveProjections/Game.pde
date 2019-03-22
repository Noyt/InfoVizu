float speed = 1;
float rx = 0;
float rz = 0;
float boxWidth = 500;
float boxHeight = 50;
Mover3D sphere;
enum Mode {NORMAL, EDIT};
Mode mode = Mode.NORMAL;
ArrayList<PVector> cylinderCenters;
ArrayList<Cylinder> cylinders;

void settings() {
  size(1000, 1000, P3D);
}

void setup() {
  sphere = new Mover3D(boxWidth);
  //noStroke();
}

void draw(){
  background(200);
  translate(width/2, height/2, width/8);
  
  
  //box
  if(mode == Mode.EDIT){
    rotateX(-PI/2);
    rotateZ(0);
  } else if (mode == Mode.NORMAL){
    rotateX(rx);
    rotateZ(rz);
  }
  
  box(boxWidth, boxHeight, boxWidth);
  
  //sphere
  sphere.forces(rx, rz);
  sphere.display();
  
  //for(int i = 0; i < cylinders.size(); i++) {
    //cylinders.get(i).display();
  //}
  
  if(mode == Mode.NORMAL){
    sphere.update();
  }

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

void keyPressed(){
  if(key == CODED){
    if(keyCode == SHIFT) {
      mode = Mode.EDIT;
    }
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == SHIFT) {
      mode = Mode.NORMAL;
    }
  }
}

void mouseClicked(){
  if(mode == Mode.EDIT){
    PVector center = new PVector(mouseX, mouseY);
    cylinderCenters.add(center);
    cylinders.add(new Cylinder(center));
  }
}
