import './player.dart';

class Club {
  String name;
  // List<Player> players = [];
  int? win;
  int? draw;
  int? lose;
  int? id;
  Club(
      {required this.name,
      // // required this.players,
      // this.win = 0,
      // this.draw = 0,
      // this.lose = 0
      required this.win,
      required this.draw,
      required this.id,
      required this.lose});
  Club.defaultConstr({
    required this.name,
    // // required this.players,
    // this.win = 0,
    // this.draw = 0,
    // this.lose = 0
    // required this.win,
    // required this.draw,
    // required this.id,
    // required this.lose
  });

  // void addPlayer(Player player) {
  //   players.add(player);
  // }

  void addWin() {
    win = win! + 1;
  }

  void addDraw() {
    draw = draw! + 1;
  }

  void addLoss() {
    lose = lose! + 1;
  }
}
