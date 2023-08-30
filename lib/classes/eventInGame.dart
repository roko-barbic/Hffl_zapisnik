import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/playerDTO.dart';

import './club.dart';
import './game.dart';

class EventInGame {
  int id;
  PlayerDTO playerOne;
  PlayerDTO playerTwo;
  int type;
  int teamGettingPoints;
  EventInGame(
      {required this.id,
      required this.playerOne,
      required this.playerTwo,
      required this.type,
      required this.teamGettingPoints});
}
