import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/club.dart';
import 'package:hffl_zapisnik/classes/game.dart';
import 'package:hffl_zapisnik/classes/tournament.dart';
import 'package:hffl_zapisnik/screens/GameEventsScreen.dart';
import 'package:hffl_zapisnik/widgets/GamesRowDisplay.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GamesScreen extends StatefulWidget {
  Tournament tournament;

  GamesScreen({required this.tournament, super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<Game> games = [];

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
          scoreAway: item['club_Home_Score'],
          scoreHome: item['club_Away_Score'],
          id: item['id']));
    }
    print(_loadedGames);
    games.clear();
    setState(() {
      games.addAll(_loadedGames);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (games == null) {
      getGames();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.tournament.name,
      )),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: games.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            mainAxisExtent: 50,
          ),
          itemBuilder: (context, index) => GestureDetector(
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
                  );
                },
                child: GamesRowDisplay(
                  game: games[index],
                ),
              )),
    );
  }
}
