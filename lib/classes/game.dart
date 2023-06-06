import './club.dart';

class Game {
  Club clubHome;
  Club clubAway;
  int scoreHome;
  int scoreAway;
  Game(
      {required this.clubHome,
      required this.clubAway,
      this.scoreAway = 0,
      this.scoreHome = 0});
}
