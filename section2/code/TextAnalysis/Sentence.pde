class Sentence implements Comparable {
 
  String text;
  String[] posLabels;
  String posString;
  
  PVector pos = new PVector();
  
  Sentence(String _txt) {
   text = _txt; 
  }
  
  void process() {
    posLabels = RiTa.getPosTags(text);
    posString = join(posLabels, " ");
    //println(text);
    //println(posLabels);
  }
  
  int compareTo(Object b) {
    return(text.length() - ((Sentence) b).text.length());
  }
  
}