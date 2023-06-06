import 'package:flutter/material.dart';

import './club.dart';
import './game.dart';

class Tournament {
  String location;
  List<Club> clubs;
  DateTime date;
  List<Game> games;
  Tournament(
      {required this.location,
      required this.clubs,
      required this.date,
      required this.games});
}
