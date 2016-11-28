class Sighting {

  //Object-specific data
  int count;
  JSONObject taxo;
  String species;
  PVector lonLat = new PVector();

  //Display properties
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  color col = 255;

  void update() {
    pos.lerp(tpos, 0.1);
  }  

  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z * globalDepth);
    //Billboarding code - faces the object to the camera
    rotateZ(-globalRotation.z);
    rotateY(-globalRotation.y);
    rotateX(-globalRotation.x);
    noStroke();
    fill(col);
    rect(0, 0, 5, 5);
    //box(5);

    popMatrix();
  }
}