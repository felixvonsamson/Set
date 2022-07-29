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
    noStroke();
    if(tip){
      strokeWeight(15);
      stroke(0,180,0);
    }
    if(selected){
      fill(activeplayer.secondarycolor);
    }
    rectMode(CORNER);
    rect(margin, margin, cardw-2*margin, cardh-2*margin, (cardw+cardh)/20);
    strokeWeight(cardw*0.025);
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
