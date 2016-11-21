import java.util.Date;

JSONArray fullPath;

long startTime;
long endTime;
long currentTime;

float timeMag = 100000000;

float[] world = {-180,-90,180,90};
float[] nyc = {-74.2057800293,40.5855387461,-73.7567138672,40.8000363051};

float[] currentBounds;

void setup() {
  size(1280, 720, P3D);
  smooth(4);
  loadPath("openpaths_blprnt.json");
  //println(fullPath.size());
  currentBounds = world;
}

void draw() {
  //Time operations
  //timeMag = mouseX * mouseX;
  currentTime += (long) ((1.0/frameRate) * 1000 * timeMag);
  Date currentDate = new Date(currentTime);
  if (currentTime > endTime) {
    currentTime = startTime;
  }

  background(255);
  //Time label
  text(currentDate.toString(), 50, 50);

  //Draw dots
  drawPath(fullPath,currentBounds);
}

void drawPath(JSONArray path, float[] bounds) {

  //for(int i = 0; i < frameCount % path.size(); i++) {
  for (int i = 0; i < path.size(); i++) {
    JSONObject point = path.getJSONObject(i);
    float lat = point.getFloat("lat");
    float lon = point.getFloat("lon");

    float x = map(lon, bounds[0], bounds[2], 0, width);
    float y = map(lat, bounds[3], bounds[1], 0, height);

    long t = point.getLong("t") * 1000;

    if (t < currentTime) {

      if (mousePressed) y = map(t, startTime, endTime, 0, height);

      ellipse(x, y, 5, 5);
      pushMatrix();
      translate(x, y);
      rotate(-PI/4);
      fill(0);
      //text(d.toString(), 10, -6);
      popMatrix();
    }
  }
}

void loadPath(String url) {
  JSONObject j = loadJSONObject(url);
  fullPath = j.getJSONArray("path");
  startTime = fullPath.getJSONObject(0).getLong("t") * 1000;
  endTime = fullPath.getJSONObject(fullPath.size() - 1).getLong("t") * 1000;
  currentTime = startTime;
}

void keyPressed() {
 if (key == 'w') currentBounds = world;
 if (key == 'n') currentBounds = nyc;
}