IntDict concordance;

String lyrics;
String[] words;

void setup() {
  size(1000,1000,P3D);
  smooth(4);
  loadData("lyrics.json");
  
  textFont(createFont("Georgia", 24));
}

void draw() {
 
}

void loadData(String url) {
  
  JSONArray value = loadJSONArray(url);
  concordance = new IntDict();
          
  for( int i = 0; i < value.size(); i++) {
    JSONObject songs = value.getJSONObject(i);
    int year = songs.getInt("Year");
      if ( year > 2009 && year < 2016) {
        //String artist = songs.getString("Artist");
        lyrics = songs.getString("Lyrics");
        println(lyrics);
        
        //String[] lines = new String[] {lyrics};
        //String allText = join(lines, " ").toLowerCase();
        //words = splitTokens(allText, " ,.?!:;[]-\"");
        //println(words.length);
          
          //for (int j = 0; j < words.length; j++) {
          // concordance.increment(words[j]);
          // concordance.sortValuesReverse();
          //}
          //println(concordance);
          
          //String[] keys = concordance.keyArray();
          //for (int i = 0; i < keys.length; i++) {
          //  int count = concordance.get(keys[i]);
          //  println(keys[i], count);
          //}
      }
  }
  
}