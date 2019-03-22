class Cylinder {  
  float cylinderBaseSize = 50;
  float cylinderHeight = 50;
  int cylinderResolution = 40;
  PShape openCylinder;
  PShape topBase;
  PShape botBase;
  PVector location;
  
  Cylinder(PVector center) {
    location = center;
    //location = new PVector(0,0);
    openCylinder = new PShape();
    topBase = new PShape();
    botBase = new PShape();
    
    setupCylinder();
  }
  
  void setupCylinder() {
    float angle;
    float[] x = new float[cylinderResolution + 1];
    float[] y = new float[cylinderResolution + 1];
    
    //get the x and y position on a circle for all the sides
    for(int i = 0; i < x.length; i++) {
      angle = (TWO_PI / cylinderResolution) * i;
      x[i] = sin(angle) * cylinderBaseSize;
      y[i] = cos(angle) * cylinderBaseSize;
    }
    
    //border
    openCylinder = createShape();
      openCylinder.beginShape(QUAD_STRIP);
      //draw the border of the cylinder
      for(int i = 0; i < x.length; i++) {
        openCylinder.vertex(x[i], y[i] , 0);
        openCylinder.vertex(x[i], y[i], cylinderHeight);
      }
    openCylinder.endShape();
    
    //top
    topBase = createShape();
      topBase.beginShape(TRIANGLE_FAN);
      topBase.vertex(0, 0, cylinderHeight);
      for(int i = 0; i < x.length;i++){
        topBase.vertex(x[i], y[i] , cylinderHeight);
      }
    topBase.endShape();
    
    //base
    botBase = createShape();
      botBase.beginShape(TRIANGLE_FAN);
      botBase.vertex(0, 0, 0);
      for(int i = 0; i < x.length;i++){
        botBase.vertex(x[i], y[i] , 0);
      }
    botBase.endShape();
  }
  
  void display() {
    translate(location.x - width/2, -location.y + width/2, 0);
    rotateX(-PI/2);
    shape(openCylinder);
    shape(topBase);
    shape(botBase);
    rotateX(PI/2);
    translate(-location.x + width/2, location.y - width/2, 0);
  }
}
