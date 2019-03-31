//QUESTIONS : COMMMENT GERER LA PROFONDEUR

float speed = 1;
float rx = 0;
float rz = 0;
float boxWidth = 500;
float boxHeight = 20;
PShape villain;
PImage img;
Mover3D sphere;
enum Mode {NORMAL, EDIT};
Mode mode = Mode.NORMAL;
ParticleSystem particleSystem;
void settings() {
  size(1000, 1000, P3D);
}

void setup() {
  sphere = new Mover3D(boxWidth);
  villain = loadShape("Robotnik/robotnik.obj");
  img = loadImage("Robotnik/robotnik.png");
  villain.setStroke(false);
  villain.setTexture(img);
  villain.scale(50.0);
  villain.rotateX(PI);
  //noStroke();
}

void draw(){
  background(200);
  translate(width/2, height/2, 0);
  
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
  
  if(particleSystem != null){
    particleSystem.display();
  }
  if(mode == Mode.NORMAL){
    if (particleSystem != null) {
     particleSystem.run(sphere);
    }
    sphere.update();
  }
}

void mouseDragged() 
{
  rx -= 0.01 * (mouseY - pmouseY) * speed;
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
    if(mouseX >= width/2 - boxWidth/2 && mouseX <= width/2 + boxWidth/2 &&
       mouseY >= height/2 - boxWidth/2 &&  mouseY <= height/2 + boxWidth/2) {
       particleSystem = new ParticleSystem(new PVector(mouseX - width/2, 0, mouseY - height/2), boxWidth, villain, sphere.location);
       //PVector center = new PVector(mouseX - width/2, 0, mouseY - height/2);
     }
  }
}
