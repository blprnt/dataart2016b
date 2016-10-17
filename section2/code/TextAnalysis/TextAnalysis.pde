import rita.*;

//relative path
String dataPath = "../../../data/lyrics/";
//absolute path
//String dataPath = "/Users/jerthorp/code/dataart2016b/data/lyrics";

String[] lines;
ArrayList<String> questions = new ArrayList();

ArrayList<Sentence> allSentences = new ArrayList();
ArrayList<Sentence> displaySentences = new ArrayList();

void setup() {
  size(800,600,P3D);
  loadText("mobydick.txt");
  displaySentences = filterByWord(allSentences,"whale");
  println(displaySentences);
  displaySentences = filterByPos(displaySentences, "dt jj jj nn");
  
  java.util.Collections.sort(displaySentences);
  //java.util.Collections.reverse(displaySentences);
}

void draw() {
  background(0);
  
  textSize(9);
  for (int i = 0; i < displaySentences.size(); i++) {
    Sentence s = displaySentences.get(i);
    text(s.text, 50, 50 + (i * 20));
  }
  
  /*
  String line = questions.get(frameCount % questions.size());
  
  float done = (float) (frameCount % questions.size()) / questions.size();
  fill(60);
  rect(0,0,width * done, height);
  
  fill(255);
  textSize(24);
  text(line, 50, 50, width - 100, height - 100);
  */
}

ArrayList<Sentence> filterByWord(ArrayList<Sentence> sources, String w) {
  //filterByWord("whale");
  ArrayList<Sentence> outs = new ArrayList();
  for (Sentence s:sources) {
   if (s.text.indexOf(w) != -1) {
     outs.add(s);
   }
  }
  return(outs);
}

ArrayList<Sentence> filterByPos(ArrayList<Sentence> sources, String pos) {
  //Calculate POS
  
  for (Sentence s:sources) {
   s.process(); 
  }
  
  ArrayList<Sentence> outs = new ArrayList();
  for (Sentence s:sources) {
   if (s.posString.indexOf(pos) != -1) {
     outs.add(s);
   }
  }
  return(outs);
}

void loadText(String corpus) {
  String url = dataPath + corpus;
  lines = loadStrings(url);
  
  lines = RiTa.splitSentences(join(lines, " "));
  println(lines.length);
  
  for (String l:lines) {
    Sentence s = new Sentence(l);
    allSentences.add(s);
  }
  
  /*
  for(int i = 0; i < lines.length; i++) {
   boolean isQ = RiTa.isQuestion(lines[i]) && lines[i].indexOf("?") != -1;
   if (isQ) questions.add(lines[i]);
  }
  */
}