import 'package:flutter/material.dart';

import './club.dart';
import './game.dart';

class Tournament {
  int id;
  // String location;
  // List<Club> clubs;
  DateTime date;
  // List<Game> games;
  String name;
  Tournament(
      {
      // {required this.location,
      // required this.clubs,
      required this.id,
      required this.date,
      required this.name
      // required this.games
      });
}
