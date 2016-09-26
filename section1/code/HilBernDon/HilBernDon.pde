void setup() {
  size(750,750,P3D);
  smooth(4);

  Table table1 = loadTable("Donald Trump.csv");
  fill(#FF0000);
  barGraph(table1);
  
  Table table0 = loadTable("Hillary Clinton.csv");
  fill(#0000FF);
  barGraph(table0);
  
  Table table2 = loadTable("Bernie Sanders.csv");
  fill(#00FF00);
  barGraph(table2);
  
  for (int i = 0; i < 20; i++) {
   int n = i * 200;
   float y = map(n, 0, 2000, 0, height);
   fill(0);
   text(n, 30, height - y);
  }
}

void draw() {
  
}

void barGraph(Table table) {
  int c = 0;
  for(int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    int n = row.getInt(0);
    c += n;
    
    float w = width / table.getRowCount();
    float x = i * w;
    float y = map(n, 0, 2000, 0, height);
    
    rect(x,height,w,-y);
  }
  println(c);
  
}