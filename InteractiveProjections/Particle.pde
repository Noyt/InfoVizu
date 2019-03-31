// A simple Particle class
abstract class Particle {
  PVector center;
  float radius;

  Particle(PVector center, float radius) {
    this.center = center.copy();
    this.radius = radius;
  }
  void run() {
    //update();
    display();
  }
  // Method to update the particle's remaining lifetime
  void update() {}
  
   // Method to display
  abstract void display();
}
