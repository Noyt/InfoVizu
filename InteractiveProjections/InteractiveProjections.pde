void settings2() {
  size(500, 500, P3D);
}

void setup2() {
  noStroke();
}

float depth = 2000;

void draw2() {
  camera(width/2, height/2, depth, 250, 250, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, 0);
  ambientLight(100, 102, 102);
  background(200);
  translate(width/2, height/2, 0);
  float ry = map(mouseY, 0, height, 0, PI);
  float rz = map(mouseX, 0, width, 0, PI);
  rotateZ(rz);
  rotateY(ry);
  for(int x = -2; x <= 2; x++) {
    for(int y = -2; y <= 2; y++){
       for(int z = -2; z <= 2; z++) {
         pushMatrix();
         translate(100* x, 100* y, -100 * z);
         box(50);
         popMatrix();
       }
     }
   }
}

void keyPressed2() {
  if (key == CODED) {
    if (keyCode == UP) {
      depth -= 50;
    } else if (keyCode == DOWN) {
      depth += 50;
    }
  }
}

class My2DPoint2 {
  float x;
  float y;
  My2DPoint2(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class My3DPoint2 {
  float x;
  float y;
  float z;
  My3DPoint2(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

My2DPoint2 projectPoint2(My3DPoint2 eye, My3DPoint2 p) {
  float[][] P = {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, -1/eye.z, 0}};
  float[][] T = {{1, 0, 0, -eye.x}, {0, 1, 0, -eye.y}, {0, 0, 1, -eye.z}, {0, 0, 0, 1}};
  float[][] v = {{p.x}, {p.y}, {p.z}, {1}};
  float[][] res = matrixMul2(matrixMul2(P, T), v);
  return new My2DPoint2(-eye.z * res[0][0]/res[2][0], -eye.z * res[1][0]/res[2][0]);
}

class My2DBox2 {
  My2DPoint2[] s;
  My2DBox2(My2DPoint2[] s) {
    this.s = s;
  }
  void render(){
     line(s[0].x, s[0].y, s[1].x, s[1].y);
     line(s[1].x, s[1].y, s[2].x, s[2].y);
     line(s[2].x, s[2].y, s[3].x, s[3].y);
     line(s[3].x, s[3].y, s[0].x, s[0].y);
     line(s[3].x, s[3].y, s[7].x, s[7].y);
     line(s[7].x, s[7].y, s[4].x, s[4].y);
     line(s[4].x, s[4].y, s[0].x, s[0].y);
     line(s[4].x, s[4].y, s[5].x, s[5].y);
     line(s[1].x, s[1].y, s[5].x, s[5].y);
     line(s[5].x, s[5].y, s[6].x, s[6].y);
     line(s[2].x, s[2].y, s[6].x, s[6].y);
     line(s[7].x, s[7].y, s[6].x, s[6].y);
  }
}
class My3DBox2 {
  My3DPoint2[] p;
  My3DBox2(My3DPoint2 origin, float dimX, float dimY, float dimZ) {
    float x = origin.x;
    float y = origin.y;
    float z = origin.z;
    this.p = new My3DPoint2[]{ new My3DPoint2(x,y+dimY,z+dimZ),
                              new My3DPoint2(x,y,z+dimZ),
                              new My3DPoint2(x+dimX,y,z+dimZ),
                              new My3DPoint2(x+dimX,y+dimY,z+dimZ),
                              new My3DPoint2(x,y+dimY,z),
                              origin,
                              new My3DPoint2(x+dimX,y,z),
                              new My3DPoint2(x+dimX,y+dimY,z)
                            };
  }              
  My3DBox2(My3DPoint2[] p) {
    this.p = p;
  }
}

My2DBox2 projectBox2 (My3DPoint2 eye, My3DBox2 box) {
  My2DPoint2[] pointVector = new My2DPoint2[box.p.length];
  for(int i = 0; i < box.p.length; ++i) {
    pointVector[i] = projectPoint2(eye, box.p[i]);
  }
  return new My2DBox2(pointVector);
}

float[][] matrixMul2(float[][] m1, float[][] m2) {
  float[][] m1m2 = new float[m1.length][m2[0].length];
   for (int i = 0; i < m1.length; ++i) {
     for (int j = 0; j < m2[0].length; ++j) {
       m1m2[i][j] = 0;
         for(int k = 0; k < m1[0].length; ++k) {
            m1m2[i][j] += m1[i][k] * m2[k][j];
            //Salut
         }
      }
    }
    return m1m2;
}

float[] homogeneous3DPoint2 (My3DPoint2 p) { 
  float[] result = {p.x, p.y, p.z , 1};
  return result; 
}

float[][] rotateXMatrix2(float angle) { 
  return(new float[][] {{1, 0 , 0 , 0},
                        {0, cos(angle), -sin(angle) , 0},
                        {0, sin(angle) , cos(angle) , 0},
                        {0, 0 , 0 , 1}});
}

float[][] rotateYMatrix2(float angle) {
   return(new float[][] {{cos(angle),0,sin(angle),0},
                         {0,1,0,0},
                         {-sin(angle),0,cos(angle),0},
                         {0,0,0,1}});
}

float[][] rotateZMatrix2(float angle) {
   return(new float[][] {{ cos(angle), -sin(angle), 0,0},
                         { sin(angle), cos(angle), 0, 0},
                         { 0, 0, 1, 0},
                         { 0, 0, 0, 1}});
}

float[][] scaleMatrix2(float x, float y, float z) {
   return(new float[][] {{x,0,0,0},
                         {0,y,0,0},
                         {0,0,z,0},
                         {0,0,0,1}});
}
float[][] translationMatrix2(float x, float y, float z) {
   return (new float[][] {{1,0,0,x},
                         {0,1,0,y},
                         {0,0,1,z},
                         {0,0,0,1}});
}

float[] matrixProduct2(float[][] a, float[] b){
  float[][] tmp = new float[b.length][1];
  for(int i = 0; i < b.length; i++){
    tmp[i][0] = b[i];
  }
  
  float[][] res = matrixMul2(a, tmp);
  float[] sol = new float[b.length];
  for(int i = 0; i < b.length; i++){
    sol[i] = res[i][0];
  }
  
  return sol;
}

My3DBox2 transformBox2(My3DBox2 box, float[][] transformMatrix) {
        //Complete the code! You need to use the euclidian3DPoint() function given below.
              
        My3DPoint2[] tmp = box.p;
        
        My3DPoint2[] res = new My3DPoint2[tmp.length]; 
        
        for(int i = 0; i < tmp.length; i++){
          res[i] = euclidian3DPoint2(matrixProduct2(transformMatrix, homogeneous3DPoint2(tmp[i])));
        }
        
        return new My3DBox2(res);
}

My3DPoint2 euclidian3DPoint2(float[] a){
  My3DPoint2 result = new My3DPoint2(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
  return result;
}
