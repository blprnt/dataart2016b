JSONArray json;
JSONObject catname;
void setup(){
  size(1280, 800, P3D);
  background(0);
  smooth(4);
  json = loadJSONArray("lostobjects.json"); 

JSONObject array = json.getJSONObject(0);
//println(array.size());

JSONObject a = array.getJSONObject("LostProperty");
//println(a.size());

JSONArray lostprop = a.getJSONArray("Category");
//println(lostprop.size());


for (int j = 0 ; j < lostprop.size(); j++) {
       //println(lostprop.size());
      JSONObject cat = lostprop.getJSONObject(j);
      JSONArray subcat = cat.getJSONArray("SubCategory");
      for (int i = 0 ; i < subcat.size(); i++) { 
        //println("*********************");
        //println(subcat.size());
        //println("*********************");
        JSONObject count = subcat.getJSONObject(i);
        String number = count.getString("_count");
        float n2 = Float.parseFloat(number);
    
        //int n = (int)n2;
         
        
        float x = i + width/random(6);//map (i + width/random(5), 0, 1000, 0, width);
        float y = height/random(10);
    
        noFill();
        stroke(255,80);
        ellipse(x, y, n2/50,n2/50);
        
  
        print(n2);
        print(',');
        print(count.getString("_SubCategory"));
        println("");
      }
    }
    
    //saveFrame(); 
}