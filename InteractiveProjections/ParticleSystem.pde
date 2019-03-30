// A class to describe a group of Particles
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  float particleRadius = 10;
 
  
  ParticleSystem(PVector origin) {
    this.origin = origin.copy();
    particles = new ArrayList<Particle>();
    particles.add(new Cylinder(origin, particleRadius));
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
      center.y += cos(angle) * 2 * particleRadius;
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
    if (center.x + particleRadius  > width || center.x - particleRadius  < 0  || 
        center.y + particleRadius  > height || center.y - particleRadius  < 0 ) {
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
  void run() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
}
