import './club.dart';

class Game {
  int id;
  Club clubHome;
  Club clubAway;
  int scoreHome;
  int scoreAway;
  // Game(
  //     {required this.clubHome,
  //     required this.clubAway,
  //     this.scoreAway = 0,
  //     this.scoreHome = 0});
  Game(
      {required this.clubHome,
      required this.clubAway,
      required this.scoreAway,
      required this.scoreHome,
      required this.id});
}
