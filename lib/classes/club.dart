import './player.dart';

class Club {
  String name;
  List<Player> players = [];
  int? win;
  int? draw;
  int? lose;
  Club(
      {required this.name,
      required this.players,
      this.win = 0,
      this.draw = 0,
      this.lose = 0});

  void addPlayer(Player player) {
    players.add(player);
  }

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
