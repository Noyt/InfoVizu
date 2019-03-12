class Mover {
  PVector location;
  PVector velocity;
  PVector gravity = new PVector(0, 0.5);
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(1, 1);
  }
  void update() {
    location.add(velocity);
    velocity.add(gravity);
  }
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, 48, 48);
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
