import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/providers/tournaments.dart';
import 'package:hffl_zapisnik/screens/gamesScreen.dart';
import 'package:hffl_zapisnik/widgets/tournamentsRowDisplay.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class TournamentsGrid extends StatefulWidget {
  bool isLoggedIn;
  TournamentsGrid({required this.isLoggedIn, super.key});
  @override
  State<TournamentsGrid> createState() => _TournamentsGridState();
}

class _TournamentsGridState extends State<TournamentsGrid> {
  TournamentsList? tournamentsList;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (tournamentsList == null) {
      tournamentsList = Provider.of<TournamentsList>(context);
      tournamentsList!.updateTournaments().then((_) => {
            setState(() {
              isLoaded = true;
            })
          });
    }
  }

  Future<bool> deleteTorunament(int id) async {
    final url = Uri.https(
        'hfflzapisnik.azurewebsites.net', '/deleteTournament/' + id.toString());
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

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: tournamentsList!.tournaments.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              mainAxisExtent: 70,
            ),
            itemBuilder: (context, index) => widget.isLoggedIn
                ? GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete tournament'),
                            content: Text(
                                'Are you sure you want to delete tournament? (id:' +
                                    tournamentsList!.tournaments[index].id
                                        .toString() +
                                    ")"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () async {
                                  bool deleted = await deleteTorunament(
                                      tournamentsList!.tournaments[index].id);
                                  if (deleted) {
                                    setState(() {
                                      tournamentsList!.updateTournaments();
                                    });
                                    Navigator.of(context).pop();
                                  }
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
                              GamesScreen(
                                  tournament:
                                      tournamentsList!.tournaments[index]),
                        ),
                      );
                    },
                    child: TournamentsRowDisplay(
                        tournament: tournamentsList!.tournaments[index]),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GamesScreen(
                              tournament: tournamentsList!.tournaments[index]),
                        ),
                      );
                    },
                    child: TournamentsRowDisplay(
                        tournament: tournamentsList!.tournaments[index]),
                  ))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
