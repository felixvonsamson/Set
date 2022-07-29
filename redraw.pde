void redraw(){
  background(237,203,142);
  if(activeplayer != null){
    pushStyle();
    fill(activeplayer.primarycolor);
    textSize(200);
    text("Set !", width/2, 250);
    rect(width/2-2.5*cardw, height-220, 5*cardw, 130);
    popStyle();
  }
  
  stroke(1);
  fill(210);
  rectMode(CORNER);
  rect(50,50,300,100);
  rect(50,200,300,100);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Show set", 200, 90);
  text("Clue", 200, 240);
  
  for(int i=0; i<players.length; i++){
    noStroke();
    fill(players[i].primarycolor);
    rect(50,500+i*200,600,150);
    fill(0);
    text(players[i].name, 250, 500+65+i*200);
    text(players[i].score, 500, 500+65+i*200);
  }
  
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
