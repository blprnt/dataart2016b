//bounds - 17.13,-13.74,24.76,-21.04

String dataPath = "../../data/allSightingsUpdate.json";
ArrayList<Sighting> allSightings = new ArrayList();

PVector globalRotation = new PVector();
PVector tglobalRotation = new PVector();

float globalDepth = 0;
float tglobalDepth = 0;

IntDict colorMap = new IntDict();

void setup() {
  size(800, 900, P3D);
  background(255);
  smooth(4);

  loadSightings();
  scrambleSightings();
}

void draw() {
  globalDepth = lerp(globalDepth, tglobalDepth, 0.1);
  globalRotation.lerp(tglobalRotation, 0.1);
  background(0);

  if (mousePressed) {
    tglobalRotation.z += (mouseX - pmouseX) * 0.01;
    tglobalRotation.x += (mouseY - pmouseY) * 0.01;

    //tglobalRotation.x = map(mouseY, 0, height, 0, PI/2);
    //tglobalRotation.z = map(mouseX, 0, width, 0, TAU);
  }

  pushMatrix();

  translate(width/2, height/2);
  rotateX(globalRotation.x);
  rotateY(globalRotation.y);
  rotateZ(globalRotation.z);
  translate(-width/2, -height/2);

  for (Sighting s : allSightings) {
    s.update();
    s.render();
  }

  popMatrix();
}

void mapSightings() {
  //bounds - 17.13,-13.74,24.76,-21.04
  for (Sighting s : allSightings) {
    float x = map(s.lonLat.x, 17.13, 24.76, 0, width);
    float y = map(s.lonLat.y, -13.74, -21.04, 0, height);
    float z = s.count * 10;
    s.tpos.set(x, y, z);
  }
}

void scrambleSightings() {
  for (Sighting s : allSightings) {
    s.tpos.set(random(width), random(height));
  }
}

void separateBirds() {
  for (Sighting s : allSightings) {
    try {
      if (s.taxo.getString("Class").equals("Aves")) {
        //Leave it where it is
      } else {
        s.tpos.x += width;
      }
    } 
    catch(Exception e) {
      //Couldn't find Class
      s.tpos.x += width;
    }
  }
}

void loadSightings() {
  JSONObject sj = loadJSONObject(dataPath);
  JSONArray features = sj.getJSONObject("results").getJSONArray("features");
  int c = 0;
  for (int i = 0; i < features.size(); i++) {
    JSONObject f = features.getJSONObject(i);
    try {
      Sighting s = new Sighting();
      JSONObject props = f.getJSONObject("properties");
      s.count = props.getInt("Count");
      c += s.count;
      s.species = props.getString("SpeciesName");
      s.taxo = props.getJSONObject("Taxonomy");
      JSONArray coords = f.getJSONObject("geometry").getJSONArray("coordinates");
      s.lonLat.x = coords.getFloat(0);
      s.lonLat.y = coords.getFloat(1);
      allSightings.add(s);

      s.col = getColorForSpecies(s);
    } 
    catch(Exception e) {
      println(e);
    }
  }
  println(features.size());
  println(c);
}

color getColorForSpecies(Sighting s) {
  color c = 0;
  if (colorMap.hasKey(s.species)) {
    return(colorMap.get(s.species));
  } else {
    //c = color(random(255), random(255), random(255));
    colorMode(HSB);
    if (s.taxo.getString("Class").equals("Aves")) {
      c = color(random(0,50), 255, 255);
    } else if (s.taxo.getString("Class").equals("Mammalia")) {
      c = color(random(100,150), 255, 255);
    } else {
      c = color(random(255));
    }
    colorMap.set(s.species, c);
  }
  return(c);
}

void keyPressed() {
  if (key == ' ') scrambleSightings();
  if (key == 'm') mapSightings();
  if (key == 'b') separateBirds();
  if (key == 'z') tglobalDepth = (tglobalDepth == 0) ? 1:0;
}