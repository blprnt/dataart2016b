void setup() {
  size(750,750,P3D);
  smooth(4);
  background(255);
  
  translate(0,height/2);
  noStroke();

  Table table1 = loadTable("Donald Trump.csv");
  fill(#FF0000,180);
  bubbleGraph(table1);
  
  Table table0 = loadTable("Hillary Clinton.csv");
  fill(#0000FF,180);
  bubbleGraph(table0);
  
  Table table2 = loadTable("Bernie Sanders.csv");
  fill(#00FF00,180);
  bubbleGraph(table2);
  
}

void draw() {
  
}

void bubbleGraph(Table table) {
  for(int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    int n = row.getInt(0);
    float x = map(i, 0, table.getRowCount(), 100, width - 100);
    
    //We'll square root this # to prepare for using it in a circle area, where it'll be squared
    float s = map(sqrt(n), 0, sqrt(2000), 0, 100);
    
    ellipse(x,0,5,5);
    ellipse(x, 0, s, s);
  }
}

void barGraph(Table table) {
  for(int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    int n = row.getInt(0);
    
    float w = width / table.getRowCount();
    float x = i * w;
    float y = map(n, 0, 2000, 0, height);
    
    rect(x,height,w,-y);
  }
  
}