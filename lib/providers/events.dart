import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../classes/eventClasses/event.dart';
import '../classes/player.dart';
import '../classes/eventClasses/eventTD.dart';
import '../classes/eventClasses/eventXP2.dart';

class EventsList extends ChangeNotifier {
  // final Player marko = Player(height: 150, name: 'Marko');
  final List<Event> _events = [
    // TouchDown(
    //     touchdownCatch: Player(height: 150, name: 'Marko'),
    //     touchdownPass: Player(height: 150, name: 'Ivan')),
    // TouchDown(
    //     touchdownCatch: Player(height: 150, name: 'Ivan'),
    //     touchdownPass: Player(height: 150, name: 'Marko')),
    // XP2(
    //   xp2Catch: Player(height: 150, name: 'Ivan'),
    //   xp2Pass: Player(height: 150, name: 'Ivan'),
    // )
  ];

  UnmodifiableListView<Event> get events => UnmodifiableListView(_events);

  void add(Event event) {
    const url =
        'https://hffl-zapisnik-default-rtdb.europe-west1.firebasedatabase.app/events.json';
    /* http.post(url, body:json.encode({
      'title' : event.
    }) );*/
    _events.add(event);
    notifyListeners();
  }

  void removeAll() {
    _events.clear();
    notifyListeners();
  }
}
