import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hffl_zapisnik/classes/club.dart';
import 'package:http/http.dart' as http;

import '../classes/club.dart';
import '../classes/player.dart';

class ClubsList extends ChangeNotifier {
  final marko = Player(height: 150, name: 'Marko');
  final ivan = Player(height: 150, name: 'Ivan');
  static List<Player> players = [
    Player(height: 150, name: 'Marko'),
    Player(height: 150, name: 'Ivan'),
  ];

  final List<Club> _clubs = [
    Club(name: 'Cannons', players: players),
    Club(name: 'Patriots', players: players),
    Club(name: 'SeaWolves', players: players),
  ];

  UnmodifiableListView<Club> get clubs => UnmodifiableListView(_clubs);

  void add(Club club) {
    const url =
        'https://hffl-zapisnik-default-rtdb.europe-west1.firebasedatabase.app/events.json';
    /* http.post(url, body:json.encode({
      'title' : event.
    }) );*/
    _clubs.add(club);
    notifyListeners();
  }

  void removeAll() {
    _clubs.clear();
    notifyListeners();
  }
}
