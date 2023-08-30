import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hffl_zapisnik/classes/game.dart';
import 'package:hffl_zapisnik/classes/tournament.dart';

import 'package:http/http.dart' as http;

import '../classes/player.dart';
import '../classes/club.dart';

class TournamentsList extends ChangeNotifier {
  // final marko = Player(height: 150, name: 'Marko');
  // final ivan = Player(height: 150, name: 'Ivan');
  // static List<Player> players = [
  //   Player(height: 150, name: 'Marko'),
  //   Player(height: 150, name: 'Ivan'),
  // ];
  // static DateTime dateTime = DateTime.now();

  // static List<Club> clubs = [
  //   // Club(name: 'Cannons', players: players),
  //   // Club(name: 'Patriots', players: players),
  //   // Club(name: 'SeaWolves', players: players),
  // ];

  // static List<Game> games = [
  //   Game(clubHome: clubs[0], clubAway: clubs[1]),
  //   Game(clubHome: clubs[1], clubAway: clubs[0]),
  // ];

  // final List<Tournament> _tournaments = [
  //   Tournament(location: "Osijek", clubs: clubs, date: dateTime, games: games),
  //   Tournament(location: "Zagreb", clubs: clubs, date: dateTime, games: games),
  //   Tournament(location: "Split", clubs: clubs, date: dateTime, games: games)
  // ];
  final List<Tournament> _tournaments = [];

  UnmodifiableListView<Tournament> get tournaments =>
      UnmodifiableListView(_tournaments);

  void updateTournaments() async {
    print('update tournaments');
    var url = Uri.https('hfflzapisnik.azurewebsites.net', '/Tournament');
    final response = await http.get(url);
    final List<dynamic> listData = json.decode(response.body);
    final List<Tournament> _loadedTournaments = [];
    for (var item in listData) {
      _loadedTournaments.add(Tournament(
          date: DateTime.parse(item['date']),
          name: item['name'],
          id: item['id']));
    }
    _tournaments.clear();
    _tournaments.addAll(_loadedTournaments);
    notifyListeners();
  }

  void add(Tournament tournament) {
    const url =
        'https://hffl-zapisnik-default-rtdb.europe-west1.firebasedatabase.app/events.json';
    /* http.post(url, body:json.encode({
      'title' : event.
    }) );*/
    _tournaments.add(tournament);
    notifyListeners();
  }

  void removeAll() {
    _tournaments.clear();
    notifyListeners();
  }
}
