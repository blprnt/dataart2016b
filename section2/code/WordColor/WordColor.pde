import rita.*;

//relative path
String dataPath = "../../../data/lyrics/";
String lines[];



void setup() {
  size(800, 800);
  loadText("mobydick.txt");

  
}

void draw() {
  background(255);
  translate(50, 50);
  for (int i = 0; i < 60; i++) {
    String s = lines[100 + i];
    drawSentence(s);
    translate(0,11);
  }
}

void loadText(String corpus) {
  String url = dataPath + corpus;
  lines = loadStrings(url);
  lines = RiTa.splitSentences(join(lines, " "));
}

void drawSentence(String s) {

  float x = 0;
  

  s = RiTa.stripPunctuation(s);
  s = s.toLowerCase();

  String[] words = RiTa.tokenize(s);

  for (String w : words) {
    //For each word, split into letters
    String[] letters = w.split("");
    for (String l : letters) {
      //For each letter, draw a box
      fill(0);
      if (isVowel(l)) fill(#FF0000);
      float letterWidth = textWidth(l);
      if (c < frameCount) rect(x, 0, letterWidth, 10);
      //Move forward after drawing the letter (like a typewriter!)
      x += letterWidth;
      c++;
    }

    //Move forward for the space at the end of each word.
    x += 10;
    c++;
  }
}