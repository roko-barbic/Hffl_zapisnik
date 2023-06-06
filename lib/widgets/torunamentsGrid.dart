import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/providers/tournaments.dart';
import 'package:hffl_zapisnik/widgets/tournamentsRowDisplay.dart';
import 'package:provider/provider.dart';

class TournamentsGrid extends StatelessWidget {
  const TournamentsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final torunamentsData = Provider.of<TournamentsList>(context);
    final loadedTournaments = torunamentsData.tournaments;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedTournaments.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          mainAxisExtent: 50,
        ),
        itemBuilder: (context, index) =>
            TournamentsRowDisplay(tournament: loadedTournaments[index]));
  }
}
