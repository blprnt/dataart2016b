float i = 0;
float m = 0;
float nConvert;
float Stroke = 3;
float Space = 60;
float PhisColor;
float PsicColor;
float transparency;
float n;


void setup() {
  size(800, 600, P3D);
  smooth(4);
  loadData("ligue180.json");
}

void draw() {
}

void loadData(String dataset) {
  JSONObject YearStats = loadJSONObject(dataset);

  JSONArray TotalCalls = YearStats.getJSONArray("Ligue-180");
  JSONArray PhisViolence = YearStats.getJSONArray("violenciaFisica");
  JSONArray PsicViolence = YearStats.getJSONArray("violenciaPsicologica");
  //JSONArray ViolenceStart = YearStats.getJSONArray("inicioViolencia");

  translate(width/2, 0);

  background(255);

  for (int j = 0; j < PhisViolence.size(); j++) {
    for (int k = 0; k < PsicViolence.size(); k++) {
      float o = PhisViolence.getInt(j);
      float p = PsicViolence.getInt(k);
      m = j*Space;
      float PhisColor = (map(o, 10000, 32000, 0, 255))/5;
      float PsicColor = (map(p, 2000, 18500, 0, 255))/5;
      float transparency = (PhisColor + PsicColor)/2;
      stroke(PhisColor, 0, PsicColor, transparency);
      //stroke(transparency);
      strokeWeight(60);
      line(0, m+30, width, m+30);
      line(-width, m+30, 0, m+30);
    }
  }

  beginShape();
  noFill();
  for (int i =0; i < TotalCalls.size(); i++) {

    float n = TotalCalls.getInt(i);
    float m = i*60;
    float nConvert = n/20000;

    strokeWeight(Stroke);
    stroke(255);

    vertex(nConvert, m);
  }
  endShape();

  beginShape();
  noFill();
  for (int i =0; i < TotalCalls.size(); i++) {

    float n = TotalCalls.getInt(i);
    float m = i*60;
    float nConvert = n/20000;

    strokeWeight(Stroke);
    stroke(255);

    vertex(-nConvert, m);
  }
  endShape();
  fill(255);
}