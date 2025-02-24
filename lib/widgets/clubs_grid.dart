import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/views/clubs_ranking_screen.dart';
import 'package:hffl_zapisnik/widgets/club_row_display.dart';


class ClubsGrid extends StatelessWidget {
  const ClubsGrid({required this.clubs, super.key});

  final Clubs clubs;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: clubs.clubs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        mainAxisExtent: 60,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubsRanking()
                  //DetailClubPlayersScreen(club: clubs.clubs[index]), //todo dodat screen za igrace
            ),
          );
        },
        child: ClubRow(club: clubs.clubs[index]),
      ),
    );
  }
}
