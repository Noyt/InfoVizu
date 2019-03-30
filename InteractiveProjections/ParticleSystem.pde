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
  PImage img;
 
  
  ParticleSystem(PVector origin, float boxWidth) {
    this.origin = origin.copy();
    particles = new ArrayList<Particle>();
    particles.add(new Cylinder(origin, particleRadius));
    villain = loadShape("Robotnik/robotnik.obj");
    img = loadImage("Robotnik/robotnik.png");
    villain.setStroke(false);
    villain.setTexture(img);
    
    
    xMin = -boxWidth/2;
    xMax = boxWidth/2;
    zMin = -boxWidth/2;
    zMax = boxWidth/2;
  }
  
  void addParticle() {
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
    if (frameCount % ((int)frameRate/2) == 0) {
      addParticle();
    }
    int hittenIndex = sphere.checkCylinderCollision(particles, particleRadius);
    if(hittenIndex != -1){
      particles.remove(hittenIndex);
    }
  }
  
  void display() {
    shape(villain);
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
    }
  }
  
}
