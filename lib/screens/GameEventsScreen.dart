import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/playerDTO.dart';
import 'package:hffl_zapisnik/widgets/eventRowDisplay.dart';
import '../classes/game.dart';
import '../classes/eventInGame.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class GameEventsScreen extends StatefulWidget {
  Game game;
  GameEventsScreen({required this.game, super.key});

  @override
  State<GameEventsScreen> createState() => _GameEventsScreenState();
}

class _GameEventsScreenState extends State<GameEventsScreen> {
  List<EventInGame> events = [];

  void getEvents() async {
    print('get events in game');
    var url = Uri.https(
        'hfflzapisnik.azurewebsites.net', '/Game/' + widget.game.id.toString());
    final response = await http.get(url);
    final dynamic listData = json.decode(response.body);
    List<EventInGame> _loadedEvents = [];
    for (var item in listData['events']) {
      _loadedEvents.add(EventInGame(
          id: item['id'],
          playerOne: PlayerDTO(
              name: item['player_One']['firstName'],
              surname: item['player_One']['lastName']),
          playerTwo: PlayerDTO(
              name: item['player_Two']['firstName'],
              surname: item['player_Two']['lastName']),
          type: item['type'],
          teamGettingPoints: item['teamGettingPoints']));
    }
    print(_loadedEvents);
    events.clear();
    setState(() {
      events.addAll(_loadedEvents);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (events == null) {
      getEvents();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.game.clubHome.name + " vs " + widget.game.clubAway.name,
      )),
      body: Column(children: [
        Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors
                      .black, // You can change the color to your preference
                  width: 2.0, // You can adjust the thickness of the underline
                ),
              ),
            ),
            child: Center(
              child: Text(
                widget.game.clubHome.name +
                    " " +
                    widget.game.scoreHome.toString() +
                    " : " +
                    widget.game.scoreAway.toString() +
                    " " +
                    widget.game.clubAway.name,
                style: TextStyle(fontSize: 15),
              ),
            )),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: events.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              mainAxisExtent: 50,
            ),
            itemBuilder: (context, index) =>
                EventRowDisplay(event: events[index]),
          ),
        ),
      ]),
    );
  }
}
