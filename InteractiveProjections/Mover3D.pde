class Mover3D {
  
  //forces
  double gravityConstant = 0.08;
  float mu = 0.01;
  PVector gravityForce;
  float frictionMagnitude =  mu;
  PVector friction;
  
  //location handling
  PVector location;
  PVector velocity;
  PVector boundariesMin;
  PVector boundariesMax;
  float elasticity = 0.8;
  
  //Sphere image
  float radius = 30;
  
   Mover3D(float boxWidth, float boxHeight) {
    location = new PVector(0, -boxHeight/2 - radius, 0);
    velocity = new PVector(0, 0, 0);
    gravityForce = new PVector(0, 0, 0);
    boundariesMin = new PVector(location.x - boxWidth/2 , 0, location.z - boxWidth/2); 
    boundariesMax = new PVector(location.x + boxWidth/2 , 0, location.z + boxWidth/2);
  }
  
  void update(ArrayList<PVector> cylinders, float cylinderRadius) {
    checkEdges();
    checkCylinderCollision(cylinders, cylinderRadius);
    velocity.add(gravityForce);
    velocity.add(friction);
    location.add(velocity);
  }
  
  void display() {
    translate(location.x, location.y, location.z);
    sphere(radius);
  }
  
  void forces(float rx, float rz) {
      gravityForce.x = (float)(sin(rz) * gravityConstant);
      gravityForce.z = - (float)(sin(rx) * gravityConstant);
      friction = velocity.copy();
      friction.mult(-1);
      friction.normalize();
      friction.mult(frictionMagnitude);
  }
  
  void checkCylinderCollision(ArrayList<PVector> cylinders, float cylinderRadius) {
    for(int i = 0; i < cylinders.size(); ++i) {
      PVector n = location.sub(cylinders.get(i));
      if (n.mag() <= (radius + cylinderRadius)) {
        //n = n.normalize();
        //velocity = velocity.sub(n.mult(velocity.dot(n) * 2));
        velocity.x = -velocity.x;
      }
    }
  }
  
  void checkEdges() {
    
    if (location.x > boundariesMax.x) {
      location.x = boundariesMax.x;
      if (velocity.x > 0) {
        velocity.x = -velocity.x * elasticity;
      }
    }
    
    if (location.z > boundariesMax.z) {
      location.z = boundariesMax.z;
      if (velocity.z > 0) {
        velocity.z = -velocity.z * elasticity;
      }
    }
    
    if (location.x < boundariesMin.x) {
      location.x = boundariesMin.x;
      if (velocity.x < 0) {
        velocity.x = -velocity.x * elasticity;
      }
    }
    
    if (location.z < boundariesMin.z) {
      location.z = boundariesMin.z;
      if (velocity.z < 0) {
        velocity.z = -velocity.z * elasticity;
      }
    }
  }
  
}
