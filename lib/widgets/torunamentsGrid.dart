import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/providers/tournaments.dart';
import 'package:hffl_zapisnik/screens/gamesScreen.dart';
import 'package:hffl_zapisnik/screens/rankingScreen.dart';
import 'package:hffl_zapisnik/widgets/tournamentsRowDisplay.dart';
import 'package:provider/provider.dart';

class TournamentsGrid extends StatefulWidget {
  const TournamentsGrid({super.key});

  @override
  State<TournamentsGrid> createState() => _TournamentsGridState();
}

class _TournamentsGridState extends State<TournamentsGrid> {
  TournamentsList? tournamentsList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (tournamentsList == null) {
      tournamentsList = Provider.of<TournamentsList>(context);
      tournamentsList!.updateTournaments();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final torunamentsData = Provider.of<TournamentsList>(context);
    // final loadedTournaments = torunamentsData.tournaments;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: tournamentsList!.tournaments.length,
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
                        GamesScreen(
                            tournament: tournamentsList!.tournaments[index]),
                  ),
                );
              },
              child: TournamentsRowDisplay(
                  tournament: tournamentsList!.tournaments[index]),
            ));
  }
}
