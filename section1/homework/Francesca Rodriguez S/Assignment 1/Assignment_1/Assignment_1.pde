
void setup () {
  size (1500, 750, P3D); //3D Mode
  smooth (8);
  background (255);
  noFill();

  loadData1 ("Obamas.json");
  loadData2 ("Kardashians.json");
}

void draw () {

  /*textSize (14);
   text ("The Democratic Presidential Nominee", 700, 280);
   stroke (0.5);
   fill (0);
   
   textSize (14);
   text ("Her look and celebrity made her a brand", 500, 400);
   stroke (0.5);
   fill (0);*/
}

void loadData1(String url) {
  JSONObject j = loadJSONObject(url);
  JSONObject response = j.getJSONObject("response");
  JSONObject meta = response.getJSONObject("meta");
  Float hit = meta.getFloat("hits");
  String headline = meta.getString("headline");
  println (headline);




  // Black Curve
  stroke (150);
  strokeWeight (0.5);
  curveTightness(0);
  beginShape();
  curveVertex (hit/16 + 200, 300);
  curveVertex (hit/16 + 200, 300);
  curveVertex (hit/14 + 200, 290);
  curveVertex (hit/12 + 200, 310);
  curveVertex (hit/10 + 200, 340);
  curveVertex (hit/8 + 200, 270);
  curveVertex (hit/6 + 200, 320);
  curveVertex (hit/4 + 200, 280);
  curveVertex (hit/2 + 200, 300);
  curveVertex (hit/2 + 200, 300);
  endShape();

  // Second Curve
  stroke (50);
  strokeWeight (0.5);
  curveTightness(-2);
  beginShape();
  curveVertex (hit/16 + 200, 300);
  curveVertex (hit/16 + 200, 300);
  curveVertex (hit/14 + 200, 290);
  curveVertex (hit/12 + 200, 310);
  curveVertex (hit/10 + 200, 340);
  curveVertex (hit/8 + 200, 270);
  curveVertex (hit/6 + 200, 320);
  curveVertex (hit/4 + 200, 280);
  curveVertex (hit/2 + 200, 300);
  curveVertex (hit/2 + 200, 300);
  endShape();

  // Third Curve
  stroke (200);
  strokeWeight (0.5);
  curveTightness(-4);
  beginShape();
  curveVertex (hit/16 + 200, 300);
  curveVertex (hit/16 + 200, 300);
  curveVertex (hit/14 + 200, 290);
  curveVertex (hit/12 + 200, 310);
  curveVertex (hit/10 + 200, 340);
  curveVertex (hit/8 + 200, 270);
  curveVertex (hit/6 + 200, 320);
  curveVertex (hit/4 + 200, 280);
  curveVertex (hit/2 + 200, 300);
  curveVertex (hit/2 + 200, 300);
  endShape();

  // Red Dots2
  strokeWeight (10);
  stroke (210);
  point (hit/16 + 200, 300);
  point (hit/16 + 200, 300);
  point (hit/14 + 200, 290);
  point (hit/12 + 200, 310);
  point (hit/10 + 200, 340);
  point (hit/8 + 200, 270);
  point (hit/6 + 200, 320);
  point (hit/4 + 200, 280);
  point (hit/2 + 200, 300);
  point (hit/2 + 200, 300);

  // Red Dots
  strokeWeight (8);
  stroke (100);
  point (hit/16 + 200, 300);
  point (hit/16 + 200, 300);
  point (hit/14 + 200, 290);
  point (hit/12 + 200, 310);
  point (hit/10 + 200, 340);
  point (hit/8 + 200, 270);
  point (hit/6 + 200, 320);
  point (hit/4 + 200, 280);
  point (hit/2 + 200, 300);
  point (hit/2 + 200, 300);

  //headline

  pushStyle();

  PFont mono;
  mono = createFont("Letra.ttf", 24);
  textFont (mono);
  stroke(2);
  fill (0);
  text (headline, 850, 280);
  popStyle();
};

void loadData2(String url) {
  JSONObject j = loadJSONObject(url);
  JSONObject response = j.getJSONObject("response");
  JSONObject meta = response.getJSONObject("meta");
  Float hit = meta.getFloat("hits");
  String headline = meta.getString("headline");
  println (headline);

  // Black Curve
  stroke (150);
  strokeWeight (0.5);
  curveTightness(0);
  beginShape();
  curveVertex (hit/16 + 260, 400);
  curveVertex (hit/16 + 260, 400);
  curveVertex (hit/14 + 260, 390);
  curveVertex (hit/12 + 260, 410);
  curveVertex (hit/10 + 260, 440);
  curveVertex (hit/8 + 260, 370);
  curveVertex (hit/6 + 260, 420);
  curveVertex (hit/4 + 260, 380);
  curveVertex (hit/2 + 260, 400);
  curveVertex (hit/2 + 260, 400);
  endShape();

  // Other Curve
  stroke (50);
  strokeWeight (0.5);
  curveTightness(-2);
  beginShape();
  curveVertex (hit/16 + 260, 400);
  curveVertex (hit/16 + 260, 400);
  curveVertex (hit/14 + 260, 390);
  curveVertex (hit/12 + 260, 410);
  curveVertex (hit/10 + 260, 440);
  curveVertex (hit/8 + 260, 370);
  curveVertex (hit/6 + 260, 420);
  curveVertex (hit/4 + 260, 380);
  curveVertex (hit/2 + 260, 400);
  curveVertex (hit/2 + 260, 400);
  endShape();

  // Third Curve
  stroke (200);
  strokeWeight (0.5);
  curveTightness(-4);
  beginShape();
  curveVertex (hit/16 + 260, 400);
  curveVertex (hit/16 + 260, 400);
  curveVertex (hit/14 + 260, 390);
  curveVertex (hit/12 + 260, 410);
  curveVertex (hit/10 + 260, 440);
  curveVertex (hit/8 + 260, 370);
  curveVertex (hit/6 + 260, 420);
  curveVertex (hit/4 + 260, 380);
  curveVertex (hit/2 + 260, 400);
  curveVertex (hit/2 + 260, 400);
  endShape();

  // Red Dots2
  strokeWeight (10);
  stroke (210);
  point (hit/16 + 260, 400);
  point (hit/16 + 260, 400);
  point (hit/14 + 260, 390);
  point (hit/12 + 260, 410);
  point (hit/10 + 260, 440);
  point (hit/8 + 260, 370);
  point (hit/6 + 260, 420);
  point (hit/4 + 260, 380);
  point (hit/2 + 260, 400);
  point (hit/2 + 260, 400);

  // Red Dots
  strokeWeight (8);
  stroke (100);
  point (hit/16 + 260, 400);
  point (hit/16 + 260, 400);
  point (hit/14 + 260, 390);
  point (hit/12 + 260, 410);
  point (hit/10 + 260, 440);
  point (hit/8 + 260, 370);
  point (hit/6 + 260, 420);
  point (hit/4 + 260, 380);
  point (hit/2 + 260, 400);
  point (hit/2 + 260, 400);

  //headline

  pushStyle();
  stroke(2);
  fill (0);
  text (headline, 480, 380);
  popStyle();





  //println(hit);
};