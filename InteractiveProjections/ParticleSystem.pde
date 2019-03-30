// A class to describe a group of Particles
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float particleRadius = 10;
  float xMin;
  float xMax;
  float yMin;
  float yMax;
  
  ParticleSystem(PVector origin, float boxWidth) {
    this.origin = origin.copy();
    particles = new ArrayList<Particle>();
    particles.add(new Cylinder(origin, particleRadius));
    xMin = -boxWidth/2;
    xMax = boxWidth/2;
    yMin = xMin;
    yMax = -yMax;
  }
  
  void addParticle() {
    PVector center;
    int numAttempts = 100;
    for(int i = 0; i < numAttempts; i++) {
       // Pick a cylinder and its center.
      int index = int(random(particles.size()));
      center = particles.get(index).center.copy();
      //center = new PVector(0, 0, 0);
      
      // Try to add an adjacent cylinder.
      float angle = random(TWO_PI);
      center.x += sin(angle) * 2 * particleRadius;
      center.z += cos(angle) * 2 * particleRadius;
      if(checkPosition(center)) {
        particles.add(new Cylinder(center, particleRadius));
        break;
      }
      
    }
    
    /*center = origin;
      float angle = random(TWO_PI);
      center.x += sin(angle) * 2 * particleRadius;
      center.z += cos(angle) * 2 * particleRadius;
      if(checkPosition(center)) {
        particles.add(new Cylinder(center, particleRadius));  
      }  
      */
  } 
  
  // Check if a position is available, i.e.
  // - would not overlap with particles that are already created
  // (for each particle, call checkOverlap())
  // - is inside the board boundaries
  boolean checkPosition(PVector center) {
    if (center.x > xMax || center.x < xMin  || 
        center.z > yMax || center.z < yMin ) {
      return false;
    }
    /*for (int i = particles.size() - 1; i >= 0; i--) {
      if (checkOverlap(center, particles.get(i).center)) {
        return false; 
      }
    }*/
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
  void run() {
    if (frameCount % ((int)frameRate/5) == 0) {
      addParticle();
    }
  }
  
  void display() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
    }
  }
  
}
