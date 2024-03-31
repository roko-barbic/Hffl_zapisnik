import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/club.dart';
import 'package:hffl_zapisnik/classes/game.dart';
import 'package:hffl_zapisnik/classes/tournament.dart';
import 'package:hffl_zapisnik/screens/GameEventsScreen.dart';
import 'package:hffl_zapisnik/widgets/GamesRowDisplay.dart';
import 'package:hffl_zapisnik/widgets/enterGame.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GamesScreen extends StatefulWidget {
  Tournament tournament;

  GamesScreen({required this.tournament, super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<Game> games = [];
  bool isLoggedIn = false;
  bool isLoaded = false;

  void getGames() async {
    print('get games');
    var url = Uri.https('hfflzapisnik.azurewebsites.net',
        '/Tournament/' + widget.tournament.id.toString());
    final response = await http.get(url);
    final dynamic listData = json.decode(response.body);
    final List<Game> _loadedGames = [];
    for (var item in listData['games']) {
      _loadedGames.add(Game(
          clubHome: Club.defaultConstr(name: item['club_Home']['name']),
          clubAway: Club.defaultConstr(name: item['club_Away']['name']),
          scoreAway: item['club_Away_Score'],
          scoreHome: item['club_Home_Score'],
          id: item['id']));
    }
    print(_loadedGames);
    games.clear();
    setState(() {
      games.addAll(_loadedGames);
      isLoaded = true;
    });
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('isLoggedIn');
    print("probjera prefsa" + loggedIn.toString());
    setState(() {
      // Update the parent widget's property using widget.isLoggedIn
      isLoggedIn = loggedIn!;
    });
  }

  Future<bool> deleteGame(int id) async {
    var url = Uri.https('hfflzapisnik.azurewebsites.net', '/deleteGame/${id}');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
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

  void refreshGames() {
    setState(() {
      getGames();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (games == null) {
      getGames();
    }
    //getGames();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
    getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.tournament.name,
      )),
      floatingActionButton: Visibility(
        visible: isLoggedIn,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: EnterGame(
                        tournamentId: widget.tournament.id,
                        refreshGames: refreshGames), //enterGame
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: isLoaded
          ? GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: games.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                mainAxisExtent: 70,
              ),
              itemBuilder: (context, index) => isLoggedIn
                  ? GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete game'),
                              content: Text(
                                  'Are you sure you want to delete game? (id:' +
                                      games[index].id.toString() +
                                      ")"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    bool deleted =
                                        await deleteGame(games[index].id);
                                    if (deleted) {
                                      setState(() {
                                        getGames();
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
                      onTap: () {
                        // Navigate to another widget and pass information
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // DetailClubPlayersScreen(club: clubsList!.clubs[index]),
                                // RankingScreen(),
                                GameEventsScreen(game: games[index]),
                          ),
                        ).then((value) {
                          setState(() {
                            getGames();
                          });
                        });
                      },
                      child: GamesRowDisplay(
                        game: games[index],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        // Navigate to another widget and pass information
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // DetailClubPlayersScreen(club: clubsList!.clubs[index]),
                                // RankingScreen(),
                                GameEventsScreen(game: games[index]),
                          ),
                        ).then((value) {
                          setState(() {
                            getGames();
                          });
                        });
                      },
                      child: GamesRowDisplay(
                        game: games[index],
                      ),
                    ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
