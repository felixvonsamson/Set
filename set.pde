int cardw = 200;
int cardh = cardw*3/2;
int margin = cardw/20;
int transX, transY;

color[] colors = {color(225,39,41), color(0,127,78), color(41,77,209)};
String[] Shapes = {"diamond", "rectangle", "ellipse"};
int[] Fills = {0, 50, 255};

Card[] cards = new Card[81];
ArrayList<Integer> table = new ArrayList<Integer>();
IntList deck = new IntList();
IntList selection = new IntList();

ArrayList<int[]> remaining_sets = new ArrayList<int[]>();
int clues = 0;

class Card{
  color Color;
  String shape;
  int fill;
  int count;
  boolean selected;
  boolean tip;
  
  int[] ids = new int[4];
  
  Card(int ColorID, int shapeID, int fillID, int count){
    Color = colors[ColorID];
    shape = Shapes[shapeID];
    fill = Fills[fillID];
    this.count = count+1;
    selected = false;
    tip = false;
    int[] _ids = {ColorID, shapeID, fillID, count};
    ids = _ids;
  }
  
  void display(){
    pushStyle();
    fill(255);
    if(tip){
      fill(210, 255, 210);
    }
    if(selected){
      fill(220);
    }
    noStroke();
    rectMode(CORNER);
    rect(margin, margin, cardw-2*margin, cardh-2*margin, (cardw+cardh)/20);
    strokeWeight(cardw*0.02);
    stroke(Color);
    fill(Color, fill);
    for(int i=1; i<=count; i++){
      pushMatrix();
      translate(cardw*0.5, cardh*(i*0.25+0.375-0.125*count));
      if(shape == "diamond"){
        quad(0,-cardh*0.075,cardw*0.35,0,0,cardh*0.075,-cardw*0.35,0);
      }else if(shape == "rectangle"){
        rectMode(CENTER);
        rect(0, 0, 0.7*cardw, 0.15*cardh);
      }else if(shape  == "ellipse"){
        ellipse(0, 0, 0.7*cardw, 0.15*cardh);
      }
      popMatrix();
    }
    popStyle();
  }
}

void setup(){
  fullScreen();
  //size(1920, 1080);
  textSize(70);
  transX = (width-5*cardw)/2;
  transY = (height-3*cardh)/2;
  int i=0;
  for(int c=0; c<3; c++){
    for(int s=0; s<3; s++){
      for(int f=0; f<3; f++){
        for(int n=0; n<3; n++){
          cards[i] = new Card(c, s, f, n);
          i++;
        }
      }
    }
  }
  
  for(int j=0; j<cards.length; j++){
    deck.append(j);
  }
  deck.shuffle();
  
  for(int j=0; j<12; j++){
    table.add(deck.get(0));
    deck.remove(0);
  }
  count_sets();
  redraw();
}

void draw(){
}

void redraw(){
  background(237,203,142);
  
  fill(210);
  rectMode(CORNER);
  rect(50,50,300,100);
  rect(50,200,300,100);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Show set", 200, 90);
  text("Clue", 200, 240);
  
  textAlign(CENTER, BOTTOM);
  text("Valid sets : "+remaining_sets.size(), 200, height-100);
  
  translate(transX,transY);
  for(int i=0; i<table.size(); i++){
    pushMatrix();
    translate(floor(i/3)*cardw, (cardh*i)%(3*cardh));
    cards[table.get(i)].display();
    popMatrix();
  }
}

void mouseClicked() {
  if(mousePosition() == "solution"){
    for(int i=0; i<table.size(); i++){
      cards[table.get(i)].tip=false;
    }
    int r = floor(random(remaining_sets.size()));
    for(int i=0; i<3; i++){
      cards[table.get(remaining_sets.get(r)[i])].tip = true;
    }
    redraw();
  }else if(mousePosition() == "tip"){
    for(int i=0; i<table.size(); i++){
      cards[table.get(i)].tip=false;
    }
    clues = min(clues+1, 3);
    for(int i=0; i<clues; i++){
      cards[table.get(remaining_sets.get(0)[i])].tip = true;
    }
    redraw();
  }else if(mousePosition() == "table"){
    int cardID = floor((mouseX-transX)/cardw) * 3 + floor((mouseY-transY)/cardh);
    if(cardID < table.size()){
      boolean is_selected = cards[table.get(cardID)].selected == false;
      cards[table.get(cardID)].selected = is_selected;
      if(is_selected){
        selection.append(table.get(cardID));
        if (selection.size()>=3){
          int[][] matrix = new int[3][4];
          for(int i=0; i<selection.size(); i++){
            matrix[i] = cards[selection.get(i)].ids;
            cards[selection.get(i)].selected = false;
          }
          if(is_valid_set(matrix)){
            for(int i=0; i<selection.size(); i++){
              for(int j=0; j<table.size(); j++){
                if(selection.get(i) == table.get(j)){
                  if(deck.size() > 0 & table.size()<13){
                    table.set(j,deck.get(0));
                    deck.remove(0);
                  }else{
                    table.remove(j);
                  }
                }
              }
            }
            clues = 0;
            count_sets();
          }
          selection.clear();
        }
      }else{
        for(int i=selection.size()-1; i>=0; i--){
          if (selection.get(i) == table.get(cardID)){
            selection.remove(i);
            break;
          }
        }
      }
    }
    redraw();
  }
}

String mousePosition(){
  if(mouseX>transX & mouseX<transX+cardw*5 & mouseY>transY & mouseY<transY+cardh*3) return "table";
  if(mouseX>50 & mouseX<350 & mouseY>50 & mouseY<150) return "solution";
  if(mouseX>50 & mouseX<350 & mouseY>200 & mouseY<300) return "tip";
  return null;
}

boolean is_valid_set(int[][] matrix){
  boolean valid = true;
  for(int i=0; i<4; i++){
    boolean same = matrix[0][i] == matrix[1][i] & matrix[0][i] == matrix[2][i];
    boolean different = matrix[0][i] != matrix[1][i] & matrix[0][i] != matrix[2][i] & matrix[1][i] != matrix[2][i];
    if (!(same | different)){
      valid = false;
    }
  }
  return valid;
}

void count_sets(){
  int[][] m = new int [table.size()][4];
  for(int i=0; i<table.size(); i++){
    m[i] = cards[table.get(i)].ids;
  }
  int[][] matrix = new int[3][4];
  remaining_sets.clear();
  for(int i=0; i<table.size()-2; i++){
    matrix[0] = cards[table.get(i)].ids;
    for(int j=i+1; j<table.size()-1; j++){
      matrix[1] = cards[table.get(j)].ids;
      for(int k=j+1; k<table.size(); k++){
        matrix[2] = cards[table.get(k)].ids;
        if(is_valid_set(matrix)){
          int[] arr = {i, j, k};
          remaining_sets.add(arr); 
        }
      }
    }
  }
  if(remaining_sets.size() == 0 & deck.size()>2){
    for(int i=0; i<3; i++){
      table.add(deck.get(0));
      deck.remove(0);
    }
    count_sets();
  }
}
