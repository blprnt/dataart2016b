Record[] recs; //recs is an array of objects 



int recordAmounts;
void setup() {
  

  background(5, 14, 25, 200);
  color[] totalColor = { #3fd5f4, #38bfdb, #32aac3, #3fd5f4, 
    #52d9f5, 
    #65ddf6, 
    #78e1f7, 
    #6bb4c3, 
    #9feaf9, 
    #b2eefa, 
    #00d4ff, 
    #6bb4c3, 
    #4ce0ff, 
    #7fe9ff
  };

  color[] fatalColor = { 
    #f45a3f, 
    #f45a3f, 
    #f56a52, 
    #f67a65, 
    #f56a52, 
    #f67a65, 
    #f78b78, 
    #f89c8b, 
    #f45a3f, 
    #db5138, 
    #f8a293, 
    #f06744, 
    #ff9c82, 
    #f78b78
  };

  size(800, 800);
  smooth(4);
  loadData("sharkdata.json");
  description();
  for ( int i = 0; i < recordAmounts; i++) {
    println(recordAmounts);

    noStroke();
    fill(totalColor[i], 60);
    drawTotal(i);
    fill(fatalColor[i], 90);
    noStroke();
    drawFatal(i);
    fill(255, 190);
    regionsText(i);
    fill(totalColor[i], 140);

    totalText(i);
    fill(fatalColor[i], 140);

    fatalText(i);
  }
  for ( int i = 0; i < 50; i++) {
    noFill();
    stroke(255, 26);
    ellipse(width/2, height/2, (i+1)*50, (i+1)*50);
  }
}

void draw() {
save("dataArt3.tif");
}


void drawTotal(int index) {

  float angle = radians(random(360));
  float x = width/2 + cos(angle) * (index+1)*20;
  float y = height/2 + sin(angle) * (index+1)*20;
  ellipse( x, y, recs[index].total/5, recs[index].total/5);
}

void drawFatal(int index) {

  float angle = radians(random(360));
  float x = width/2 + cos(angle) * (index+1)*20;
  float y = height/2 + sin(angle) * (index+1)*20;

  ellipse( x, y, recs[index].fatal, recs[index].fatal);
}

//////////////////  DRAW REGIONS & DATAS   ///////////////////// 

void description() {
  fill(255, 220);
  text("Total and fatal Shark Attacks between 1958 and 2016", 20, 30);

  text("Region", 20, height - 240);
  text("total", 130, height - 240);
  text("fatal", 190, height - 240);
}
void regionsText(int index) {
  text(recs[index].region, 20, height - 245 +(2+index)*15.2); 
  // println(recs[index].region);
}
void totalText(int index) {


  text(recs[index].total, 130, height - 245 + (2+index)*15.2); 
  // println(recs[index].total);
}
void fatalText(int index) {

  text(recs[index].fatal, 190, height - 245 + (2 +index)*15.2); 
  // println(recs[index].total);
}

//void writeText(int index) {

//  //fill(255, 0, 255, 25);
//  //float angle = radians(random(360));
//  //float x = width/2 + cos(angle) * (index+1)*20;
//  //float y = height/2 + sin(angle) * (index+1)*20;

//  text( x, y, recs[index].fatal, recs[index].fatal);
//}


void loadData(String url) {
  JSONArray SharkArray = loadJSONArray(url);




  recordAmounts = SharkArray.size();
  recs = new Record[SharkArray.size()];
  for (int i = 0; i < SharkArray.size(); i++) {

    JSONObject j = SharkArray.getJSONObject(i);
    // println(j);

    recs[i]= new Record().fromJSON(j); // creating a new obj of class 'record' usinig JSON obj jk






    //******************************************


    //    text(recs[i].region, 10, 60+i*15); 
    //    println(recs[i].region);
  }
}