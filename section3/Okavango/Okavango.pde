//bounds - 17.13,-13.74,24.76,-21.04

String dataPath = "../../data/allSightingsUpdate.json";
ArrayList<Sighting> allSightings = new ArrayList();

PGraphics critterCanvas;

void setup() {
  size(800, 900, P3D);
  background(255);
  smooth(4);
  
  loadSightings();
}

void draw() {
  background(255);
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