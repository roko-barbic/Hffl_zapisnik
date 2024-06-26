import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/playerDTO.dart';
import 'package:hffl_zapisnik/screens/enterEvent.dart';
import 'package:hffl_zapisnik/widgets/eventRowDisplay.dart';
import '../classes/game.dart';
import '../classes/club.dart';

import '../classes/eventInGame.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GameEventsScreen extends StatefulWidget {
  Game game;
  GameEventsScreen({required this.game, super.key});

  @override
  State<GameEventsScreen> createState() => _GameEventsScreenState();
}

class _GameEventsScreenState extends State<GameEventsScreen> {
  List<EventInGame> events = [];
  bool isLoggedIn = false;
  bool isSwiped = false;
  bool isLoaded = false;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('isLoggedIn');
    print("probjera prefsa" + loggedIn.toString());
    setState(() {
      // Update the parent widget's property using widget.isLoggedIn
      isLoggedIn = loggedIn!;
    });
  }

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
      isLoaded = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (events == null) {
      getEvents();
    }
  }

  void refreshEvents(Game game) {
    setState(() {
      widget.game = game;
      getEvents();
    });
  }

  Future<bool> deleteEvent(int id) async {
    var url = Uri.https(
        'hfflzapisnik.azurewebsites.net', '/deleteEvent/${id.toString()}');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        final dynamic _loadedGame = json.decode(response.body);
        final gameToReturnBack = Game(
            clubHome:
                Club.defaultConstr(name: _loadedGame['club_Home']['name']),
            clubAway:
                Club.defaultConstr(name: _loadedGame['club_Away']['name']),
            scoreAway: _loadedGame['club_Away_Score'],
            scoreHome: _loadedGame['club_Home_Score'],
            id: _loadedGame['id']);
        widget.game = gameToReturnBack;
        return true;
      } else {
        print('Failed to delete tournament');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.game.clubHome.name + " vs " + widget.game.clubAway.name,
      )),
      floatingActionButton: Visibility(
        visible:
            isLoggedIn, //_tabcontroller.index == 1, da bi bio samo turniri tab
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: EnterEventSc(
                      gameId: widget.game.id,
                      refreshEvents: refreshEvents,
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Column(children: [
        Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors
                      .black, 
                  width: 2.0, 
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
                style: const TextStyle(fontSize: 15),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: isLoaded
              ? GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: events.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 60,
                  ),
                  itemBuilder: (context, index) => isLoggedIn
                      ? GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Delete event'),
                                  content: Text(
                                      'Are you sure you want to delete event? (id:' +
                                          events[index].id.toString() +
                                          ")"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () async {
                                        bool deleted =
                                            await deleteEvent(events[index].id);
                                        if (deleted) {
                                          setState(() {
                                            getEvents();
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: EventRowDisplay(event: events[index]))
                      : EventRowDisplay(event: events[index]),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),

        // Expanded(
        //   child: GridView.builder(
        //     padding: const EdgeInsets.all(10),
        //     itemCount: events.length,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 1,
        //       mainAxisSpacing: 10,
        //       mainAxisExtent: 50,
        //     ),
        //     itemBuilder: (context, index) {
        //       // Track whether the row is swiped or not.

        //       return GestureDetector(
        //         onHorizontalDragUpdate: (details) {
        //           // Detect horizontal swipe gesture.
        //           if (details.delta.dx < -20) {
        //             // If swiped left by a certain threshold, set isSwiped to true.
        //             setState(() {
        //               isSwiped = true;
        //             });
        //           }
        //         },
        //         onHorizontalDragEnd: (details) {
        //           // When the swipe gesture ends, reset isSwiped.
        //           setState(() {
        //             isSwiped = false;
        //           });
        //         },
        //         child: Row(
        //           children: [
        //             if (isSwiped)
        //               Expanded(
        //                 child: IconButton(
        //                   icon: Icon(Icons.delete),
        //                   onPressed: () {
        //                     // Call deleteEvent() when the trash icon is pressed.
        //                     // deleteEvent(
        //                     //     index); // You may need to pass the correct index here.
        //                   },
        //                 ),
        //               ),
        //             Expanded(
        //               child: EventRowDisplay(event: events[index]),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ]),
    );
  }
}
