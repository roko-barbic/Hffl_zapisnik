import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/club.dart';
import 'package:hffl_zapisnik/classes/eventClasses/eventTD.dart';
import 'package:hffl_zapisnik/classes/player.dart';
import 'package:hffl_zapisnik/screens/GameEventsScreen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../classes/playerIdDto.dart';
import '../classes/game.dart';
import '../classes/club.dart';
import '../providers/events.dart';

class EnterEventSc extends StatefulWidget {
  EnterEventSc({required this.gameId, super.key});
  int gameId;
  @override
  State<EnterEventSc> createState() => _EnterEventScState();
}

class _EnterEventScState extends State<EnterEventSc> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  late String _dropDownValue;
  bool isLoaded = false;
  int? type;

  Club clubSelected = Club.defaultConstr(name: "pocetni");

  List<PlayerIdDTO> homePlayers = [];
  List<PlayerIdDTO> awayPlayers = [];
  late Club homeClub;
  late Club awayClub;

  List<DropdownMenuItem<PlayerIdDTO>> player1DropdownItems = [];
  List<DropdownMenuItem<PlayerIdDTO>> player2DropdownItems = [];

  PlayerIdDTO? selectedValuePlayerOne;
  PlayerIdDTO? selectedValuePlayerTwo;

  Widget _conditionalWidget = Container();

  //Odabir vrste događaja
  void chooseTypeOfEvent(String? selectedValue) {
    setState(() {
      selectedValuePlayerOne = null;
      selectedValuePlayerTwo = null;
      player1DropdownItems.clear();
      player2DropdownItems.clear();
      _dropDownValue = selectedValue!;
      if (_dropDownValue == 'touchdown') {
        type = 1;
        if (clubSelected == homeClub) {
          player1DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        } else if (clubSelected == awayClub) {
          player1DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        }
        _conditionalWidget = Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač pass: '),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerOne,
                          items: player1DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerOne = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač catch:'),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerTwo,
                          items: player2DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerTwo = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FloatingActionButton(
                  onPressed: () => {createEvent()},
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        );
      } else if (_dropDownValue == 'extrapoint2') {
        type = 4;
        if (clubSelected == homeClub) {
          player1DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        } else if (clubSelected == awayClub) {
          player1DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        }
        _conditionalWidget = Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač pass: '),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerOne,
                          items: player1DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerOne = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač catch:'),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerTwo,
                          items: player2DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerTwo = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FloatingActionButton(
                  onPressed: () => {createEvent()},
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        );
      } else if (_dropDownValue == 'extrapoint4') {
        type = 5;
        if (clubSelected == homeClub) {
          player1DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        } else if (clubSelected == awayClub) {
          player1DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        }
        _conditionalWidget = Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač pass: '),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerOne,
                          items: player1DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerOne = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač catch:'),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerTwo,
                          items: player2DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerTwo = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FloatingActionButton(
                  onPressed: () => {createEvent()},
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        );
      } else if (_dropDownValue == 'interception') {
        type = 2;
        if (clubSelected == homeClub) {
          player1DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        } else if (clubSelected == awayClub) {
          player1DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        }
        _conditionalWidget = Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač pass: '),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerOne,
                          items: player1DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerOne = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač catch INT:'),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerTwo,
                          items: player2DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerTwo = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FloatingActionButton(
                  onPressed: () => {createEvent()},
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        );
      } else if (_dropDownValue == 'pick6') {
        type = 3;
        print(type);
        if (clubSelected == homeClub) {
          player1DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        } else if (clubSelected == awayClub) {
          player1DropdownItems = homePlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
          player2DropdownItems = awayPlayers
              .map((PlayerIdDTO player) => DropdownMenuItem<PlayerIdDTO>(
                    value: player,
                    child: Text(player.name + " " + player.surname),
                  ))
              .toList();
        }
        _conditionalWidget = Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač pass: '),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerOne,
                          items: player1DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerOne = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Text('Igrač catch INT:'),
                      const SizedBox(
                        width: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return DropdownButton<PlayerIdDTO>(
                          value: selectedValuePlayerTwo,
                          items: player2DropdownItems,
                          onChanged: (newValue) => {
                            setState(() {
                              selectedValuePlayerTwo = newValue;
                              // Update the selected value
                            })
                          },
                          hint: Text('Izaberi igrača'),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FloatingActionButton(
                  onPressed: () => {createEvent()},
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        );
      } else if (_dropDownValue == 'safety') {
        type = 6;
        _conditionalWidget =
            Container(child: Text("+2 boda " + clubSelected.name));
      }
    });
  }

  Future<void> getGameInfo() async {
    print('get infoAboutGame');
    var url = Uri.https('hfflzapisnik.azurewebsites.net', '/gameIdShort',
        {'id': widget.gameId.toString()});

    final response = await http.get(url);
    final dynamic listData = json.decode(response.body);
    print(response.body);
    final List<PlayerIdDTO> _loadedPlayers = [];
    for (var item in listData['club_Home']['players']) {
      _loadedPlayers.add(PlayerIdDTO(
          name: item['firstName'], surname: item['lastName'], id: item['id']));
    }
    homePlayers.clear();
    final List<PlayerIdDTO> _loadedPlayers2 = [];
    for (var item in listData['club_Away']['players']) {
      _loadedPlayers2.add(PlayerIdDTO(
          name: item['firstName'], surname: item['lastName'], id: item['id']));
    }
    awayPlayers.clear();
    setState(() {
      homeClub = Club.defaultConstr(name: listData['club_Home']['name']);
      homeClub.id = listData['club_Home']['id'];
      awayClub = Club.defaultConstr(name: listData['club_Away']['name']);
      awayClub.id = listData['club_Away']['id'];
      homePlayers.addAll(_loadedPlayers);
      awayPlayers.addAll(_loadedPlayers2);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGameInfo().then((_) {
      setState(() {
        clubSelected = homeClub;
        _dropDownValue = 'touchdown';
        isLoaded = true;
        chooseTypeOfEvent(_dropDownValue);
      });
    });

    // _conditionalWidget = Container(
    //   child: Text('Potrebno je odabrati vrstu događaja'),
    // );
  }

  void createEvent() async {
    print('add event ' + type.toString());
    var url = Uri.https('hfflzapisnik.azurewebsites.net',
        '/Game/api/games/' + widget.gameId.toString() + '/events');
    Map body = {
      "player_OneId": selectedValuePlayerOne!.id.toString(),
      "player_TwoId": selectedValuePlayerTwo!.id.toString(),
      "type": type.toString()
    };
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
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
        // Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              // Navigate back to the original widget
              return GameEventsScreen(
                game: gameToReturnBack,
              );
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Adding new event failed'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle network errors or other exceptions
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                DropdownButton(
                  items: const [
                    DropdownMenuItem(
                      child: Text('Touchdown'),
                      value: 'touchdown',
                    ),
                    DropdownMenuItem(
                      child: Text('Interception'),
                      value: 'interception',
                    ),
                    DropdownMenuItem(
                      child: Text('Pick Six'),
                      value: 'pick6',
                    ),
                    DropdownMenuItem(
                      child: Text('Extrapoint 2'),
                      value: 'extrapoint2',
                    ),
                    DropdownMenuItem(
                      child: Text('Extrapoint4'),
                      value: 'extrapoint4',
                    ),
                    DropdownMenuItem(
                      child: Text('Safety'),
                      value: 'safety',
                    ),
                  ],
                  onChanged: chooseTypeOfEvent,
                  value: _dropDownValue,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return SegmentedButton(
                    segments: <ButtonSegment<Club>>[
                      ButtonSegment<Club>(
                          value: homeClub, label: Text(homeClub.name)),
                      ButtonSegment<Club>(
                          value: awayClub, label: Text(awayClub.name))
                    ],
                    selected: <Club>{clubSelected},
                    onSelectionChanged: (newSet) {
                      final newClub = newSet.isNotEmpty ? newSet.first : null;
                      setState(() {
                        clubSelected = newClub!;
                        selectedValuePlayerOne =
                            null; // Reset selected player values
                        selectedValuePlayerTwo = null;
                        chooseTypeOfEvent(_dropDownValue);
                      });
                    },
                  );
                }),
                StatefulBuilder(builder: (context, setState) {
                  return _conditionalWidget;
                })
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
