class Player{
  int id;
  String name;
  color primarycolor;
  color secondarycolor;
  int score;
  Player(int id, String name){
    this.name = name;
    this.id = id;
    primarycolor = playercolors[id][0];
    secondarycolor = playercolors[id][1];
    score = 0;
  }
}
