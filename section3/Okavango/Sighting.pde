class Sighting {
  
 //Object-specific data
 int count;
 JSONObject taxo;
 String species;
 PVector lonLat = new PVector();

 //Display properties
 PVector pos = new PVector();
 PVector tpos = new PVector();
 
 void update() {
   pos.lerp(tpos, 0.1);
   
 }  

 void render() {
   pushMatrix();
     translate(pos.x,pos.y,pos.z);
     rect(0,0,5,5);
   popMatrix();
 }
}