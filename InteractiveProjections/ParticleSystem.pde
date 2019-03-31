// A class to describe a group of Particles
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float particleRadius = 20;
  float xMin;
  float xMax;
  float zMin;
  float zMax;
  PShape villain;
  PVector villain_to_sphere;
  float villain_default_angle = PI;
  
  ParticleSystem(PVector origin, float boxWidth, PShape villain, PVector sphere_location) {
    this.origin = origin.copy();
    particles = new ArrayList<Particle>();
    particles.add(new Cylinder(origin, particleRadius));
    
    this.villain = villain;
    villain_to_sphere = PVector.sub(sphere_location,origin);
    
    xMin = -boxWidth/2;
    xMax = boxWidth/2;
    zMin = -boxWidth/2;
    zMax = boxWidth/2;
  }
  
  void addParticle() {
    if (particles != null) {
      PVector center;
      int numAttempts = 100;
      for(int i = 0; i < numAttempts; i++) {
         // Pick a cylinder and its center.
        int index = int(random(particles.size()));
        center = particles.get(index).center.copy();
        
        // Try to add an adjacent cylinder.
        float angle = random(TWO_PI);
        center.x += sin(angle) * 2 * particleRadius;
        center.z += cos(angle) * 2 * particleRadius;
        if(checkPosition(center)) {
          particles.add(new Cylinder(center, particleRadius));
          break;
        }
      }
    }
  } 
  
  // Check if a position is available, i.e.
  // - would not overlap with particles that are already created
  // (for each particle, call checkOverlap())
  // - is inside the board boundaries
  boolean checkPosition(PVector center) {
    if (center.x > xMax || center.x < xMin  || 
        center.z > zMax || center.z < zMin ) {
      return false;
    }
    for (int i = particles.size() - 1; i >= 0; i--) {
      if (checkOverlap(center, particles.get(i).center)) {
        return false; 
      }
    }
    return true;
  }
  
  // Check if a particle with center c1
  // and another particle with center c2 overlap.
  boolean checkOverlap(PVector c1, PVector c2) {
    PVector diff = PVector.sub(c1, c2);
    if (diff.mag() < 2 * particleRadius) {
      return true;
    }
    return false;
  }
  
  // Iteratively update and display every particle,
  // and remove them from the list if their lifetime is over.
  void run(Mover3D sphere) {
    if (particles != null) {
      
      villain_to_sphere = PVector.sub(sphere.location,origin);
      
      if (frameCount % ((int)frameRate/2) == 0) {
        addParticle();
      }
      int hittenIndex = sphere.checkCylinderCollision(particles, particleRadius);
      if(hittenIndex != -1){
        if (hittenIndex == 0) {
          particles = null;
        } else {
          particles.remove(hittenIndex);
        }
      }
    }
  }
  
  void display() {
    if (particles != null) {
      
      // Draw the villain
      translate(origin.x, origin.y - 50, origin.z);
      float ry; 
      if (villain_to_sphere.z == 0) {
        if (villain_to_sphere.x >= 0) ry = PI/2;
        else ry = -PI/2;
      }
      else {
        ry = (float)Math.atan((double)(villain_to_sphere.x/villain_to_sphere.z));
        if (villain_to_sphere.z < 0) {
          if(villain_to_sphere.x > 0) ry = PI + ry;
          else ry = - PI + ry;
        }
      }
      ry += villain_default_angle;
      rotateY(ry);
      shape(villain);
      rotateY(-ry);
      translate(-origin.x, -origin.y + 50, -origin.z);
      
      // Draw each particle
      for (int i = particles.size() - 1; i >= 0; i--) {
        Particle p = particles.get(i);
        p.run();
      }
    }
  }
  
}
