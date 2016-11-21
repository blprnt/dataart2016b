//bounds - 17.13,-13.74,24.76,-21.04

String dataPath = "../../data/allSightingsUpdate.json";
ArrayList<Sighting> allSightings = new ArrayList();

void setup() {
  size(800, 900, P3D);
  background(255);
  smooth(4);

  loadSightings();
  scrambleSightings();
}

void draw() {
  background(255);
  for (Sighting s : allSightings) {
    s.update();
    s.render();
  }
}

void mapSightings() {
  //bounds - 17.13,-13.74,24.76,-21.04
  for (Sighting s : allSightings) {
    float x = map(s.lonLat.x, 17.13, 24.76, 0, width);
    float y = map(s.lonLat.y, -13.74, -21.04, 0, height);
    s.tpos.set(x, y);
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
    } 
    catch(Exception e) {
      println(e);
    }
  }
  println(features.size());
  println(c);
}

void keyPressed() {
  if (key == ' ') scrambleSightings();
  if (key == 'm') mapSightings();
  if (key == 'b') separateBirds();
}