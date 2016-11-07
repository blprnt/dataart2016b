String baseURL = "http://elections.huffingtonpost.com/pollster/api";


void setup() {
  loadChart("2012-iowa-gop-primary");
}

void draw() {
  
}

void loadChart(String slug) {
  //http://elections.huffingtonpost.com/pollster/api/charts/SLUG.json
  String url = baseURL + "/charts/" + slug + ".json";
  JSONObject json = loadJSONObject(url);
  println(json);
  
}