class Mover3D {
  double gravityConstant = 0.08;
  float mu = 0.01;
  PVector location;
  PVector velocity;
  PVector gravityForce;
  float frictionMagnitude =  mu;
  PVector friction;
  
   Mover3D() {
    location = new PVector(0, -55, 0);
    velocity = new PVector(0, 0, 0);
    gravityForce = new PVector(0, 0, 0);
  }
  void update() {
    velocity.add(gravityForce);
    velocity.add(friction);
    location.add(velocity);
  }
  void display() {
    translate(location.x, location.y, location.z);
    sphere(30);
  }
  
  void forces(float rx, float rz) {
      gravityForce.x = (float)(sin(rz) * gravityConstant);
      gravityForce.z = - (float)(sin(rx) * gravityConstant);
      friction = velocity.copy();
      friction.mult(-1);
      friction.normalize();
      friction.mult(frictionMagnitude);
  }
  
  
  void checkEdges() {
    if ((location.x > width) || (location.x < 0)) {
      velocity.x = -velocity.x;
    }
    if ((location.y > height)||(location.y < 0)) {
      velocity.y = -velocity.y;
    }
  }
}
