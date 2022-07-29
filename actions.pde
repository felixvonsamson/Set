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
  }else if(mousePosition() == "table" & activeplayer != null){
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
          }
          resetselection();
          if(is_valid_set(matrix)){
            activeplayer.score++;
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
          }else{
            activeplayer.score--;
          }
          selection.clear();
          activeplayer = null;
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

void keyPressed(){
  if(key>48 & key<49+players.length & activeplayer == null){
    activeplayer = players[key-49];
    stop = millis() + 5000;
    redraw();
  }
}
