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

void resetselection(){
  for(int i=0; i<selection.size(); i++){
    cards[selection.get(i)].selected = false;
  }
}
