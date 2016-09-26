import ComputationalGeometry.*;
IsoSkeleton skeleton;

String year;
int planets;
Table table;
float thickPts;
float thickWeb;
int i = 0;
PFont f;


void setup() {
  size(900, 700, P3D);
  smooth(10);
  fill(50);
  f = createFont("Arial",16,true);
  table = loadTable("Kepler-year.csv");
  
 // Create iso-skeleton
  skeleton = new IsoSkeleton(this);

  // Create points to make the network
  PVector[] pts = new PVector[100];
  for (int i=0; i<pts.length; i++) {
    pts[i] = new PVector(random(-100, 100), random(-100, 100), random(-100, 100) );
  }  

  for (int i=0; i<pts.length; i++) {
    for (int j=i+1; j<pts.length; j++) {
      if (pts[i].dist( pts[j] ) < 50) {
        skeleton.addEdge(pts[i], pts[j]);
      }
    }
  }
}

void draw() {
  background(220);
  lights();
  float zm = 150;
  float sp = 0.015 * frameCount;
  camera(zm * cos(sp), zm * sin(sp), zm, 0, 0, 0, 0, 0, -1);
  
  noStroke();
  year  = table.getString(i, 0);
  planets = table.getInt(i, 1);
  
  thickPts = (10.f * float(planets) / (3.0f*width));
  thickWeb = (1 / (3.0*height));
  
  skeleton.plot(thickPts, thickWeb); // Thickness as parameter
  
  i++;
  if (i > 11) {
    i = 1;
  }
  delay(400);
  
}