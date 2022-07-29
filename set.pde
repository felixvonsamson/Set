String[] nplayers = {"Vera", "Felix"}; 
int cardw = 400;
int cardh = cardw*3/2;
int margin = cardw/20;
int transX, transY;

color[] colors = {color(225,39,41), color(0,127,78), color(41,77,209)};

color[][] playercolors = {{color(111,168,220), color(207,226,243)},
                          {color(147,196,125), color(217,234,211)},
                          {color(142,124,195), color(217,210,233)},
                          {color(224,102,102), color(244,204,204)},
                          {color(246,178,107), color(252,229,205)}};
                          
String[] Shapes = {"diamond", "rectangle", "ellipse"};
int[] Fills = {0, 50, 255};

Card[] cards = new Card[81];
ArrayList<Integer> table = new ArrayList<Integer>();
IntList deck = new IntList();
IntList selection = new IntList();

Player[] players = new Player[nplayers.length];
Player activeplayer = null;

ArrayList<int[]> remaining_sets = new ArrayList<int[]>();
int clues = 0;
int stop;
float l;

void draw(){
  fill(237,203,142);
  rect(0, height-400, 400, 100);
  fill(0);
  text(millis()/60000+":"+millis()/1000, 200, height-300);
  if(activeplayer != null){
    l = map(stop-millis(),0,5000,width/2-2.5*cardw,width/2+2.5*cardw);
    fill(237,203,142);
    rect(l,height-250,2000,250);
    if(millis()>stop){
      activeplayer.score--;
      activeplayer = null;
      resetselection();
      selection.clear();
      redraw();
    }
  }
}
