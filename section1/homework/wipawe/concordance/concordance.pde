IntDict concordance;
String[] lyrics;
int counter = 0;
PFont font;
color pink = color(255,130,211);
color yellow = color(255,235,87);
color red = color(240,46,55);
color pastelpink = color(255,201,213);
color purple = color(255,163,253);
color teal = color(155,250,245);

void setup() {
  size(1000, 1000, P3D);
  smooth(4);
  concordance = new IntDict();
  noStroke();
  font = loadFont("FuturaStd-Medium.vlw");
    
  String[] lines = loadStrings("10s.txt");
  String allText = join(lines, " ").toUpperCase();
  lyrics = splitTokens(allText, " ,.?!:;[]-\"");
  
  for (int i = 0; i < lyrics.length; i++) {
    concordance.increment(lyrics[i]);
  }
  //concordance.sortValuesReverse();
  //println(concordance);
 
}

void draw() {
  background(0);
  gradientRect(0,0,1000,1000, teal, purple);
  fill(232,77,229);
  
  float x = 100;
  float y = 150;

  String[] keys = concordance.keyArray();
  
  for (int i = 0; i < keys.length; i++) {
    int count = concordance.get(keys[i]);
    if ( count > 100 ) {
      println(keys[i], count);
      textFont(font, 80);
      float fontSize = map(count, 100, 9223, 10, 80);
      textSize(fontSize);
      text(keys[i], x, y);
      x += textWidth(keys[i] + " ");
    } 
    
    if(x > width - 100) {
      x = 100; 
      y += 60;
    }
  }
  noLoop();
  saveFrame("10s-2.png");
}
void gradientRect(int x, int y, int w, int h, color c1, color c2) {
  beginShape();
  fill(c1);
  vertex(x,y);
  vertex(x+w,y);
  fill(c2);
  vertex(x+w, y+h);
  vertex(x,y+h);
  endShape();
}