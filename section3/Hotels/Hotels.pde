/*

 0  1         2     3     4        5         6           7           8       9        10  11             12       13        14      15           16      17    18         19      20       21                                                                       
 id~hotelName~stars~price~cityName~stateName~countryCode~countryName~address~location~url~tripadvisorUrl~latitude~longitude~latlong~propertyType~chainId~rooms~facilities~checkIn~checkOut~rating
 
 
 */

String dataPath = "/Users/jerthorp/code/data/hotelsbase.csv";

void setup() {
  size(1200, 720, P3D);
  smooth(4);
  background(0);
  loadData(dataPath);
}

void draw() {
}

void loadData(String url) {
  String[] rows = loadStrings(url);
  for (int i = 0; i <rows.length; i++) {
    String row = rows[i];
    String[] cols = row.split("~");

    try {
      float lat = float(cols[12]);
      float lon = float(cols[13]);
      
      float price = float(cols[3]);
      //Full screen
      float x = map(lon, -180, 180, 0, width);
      float y = map(lat, 90, -90, 0, height);
      //Map window
      /*
      x = map(lon, -180, 180, 50, 200);
      y=  map(lat, 90, -90, 50, 150);
      */
      //USA
      //-126.7,24.3,-64.8,50.3
      /*
      x = map(lon, -126.7, -64.8, 0, width);
      y = map(lat,  50.3, 24.3, 0,height);
      */
      
      float priceMark = map(sqrt(price), 0, sqrt(500), 0, width);
      stroke(#FF0000,5);
      //line(priceMark,0,priceMark,height);
      
      stroke(255,150);
      point(priceMark,y);
    } 
    catch(Exception e) {
      println("Exception on line:" + i);
    }
  }
}