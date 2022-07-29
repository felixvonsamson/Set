void setup(){
  fullScreen();
  //size(1920, 1080);
  textSize(70);
  
  for (int i=0; i<nplayers.length; i++){
    players[i] = new Player(i, nplayers[i]);
  }
  
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
