void setup() {
  size(1000,1000,P3D);
  smooth(4);
  background(255);
  loadData("heartratesample.json");
}

void draw() {
  
}

void loadData(String url) {

  
  JSONObject j = loadJSONObject(url);
  JSONObject results = j.getJSONObject("results");
  JSONArray features = results.getJSONArray("features");
  JSONObject f = features.getJSONObject(0);
  JSONObject props = f.getJSONObject("properties");
  JSONArray beats = props.getJSONArray("Beats");
  
  for(int i = 0; i < beats.size(); i++) {
   int n = beats.getInt(i); 
   
   float x = map(i, 0, beats.size(), 100, width + 2000);
   float y = height/2;
   float r = map(n, 300, 1000, 0, PI);
   
   pushMatrix();
     translate(x,y);
     rotate(PI +r);
     stroke(0,50);
     line(0,0,100,0);
   popMatrix();
   
   
  }
  
  
  
}