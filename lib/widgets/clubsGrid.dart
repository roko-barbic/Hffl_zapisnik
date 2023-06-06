import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/widgets/clubRowDisplay.dart';
import 'package:provider/provider.dart';

import '../providers/clubs.dart';
import '../widgets/userItem.dart';

import '../classes/club.dart';

class ClubsGrid extends StatelessWidget {
  const ClubsGrid({super.key});

  List<Club> sortClubs(List<Club> clubs) {
    List<Club> clubsSorted = clubs;
    for (int i = 0; i < clubsSorted.length - 1; i++) {
      for (int j = 0; j < clubsSorted.length - i - 1; j++) {
        if (clubsSorted[j].win! > clubsSorted[j + 1].win! ||
            ((clubsSorted[j].win! == clubsSorted[j + 1].win!) &&
                clubsSorted[j].draw! > clubsSorted[j + 1].draw!)) {
          Club temp = clubsSorted[j];
          clubsSorted[j] = clubsSorted[j + 1];
          clubsSorted[j + 1] = temp;
        }
      }
    }

    return clubsSorted;
  }

  @override
  Widget build(BuildContext context) {
    final clubsData = Provider.of<ClubsList>(context);
    final loadedClubs = clubsData.clubs;
    final sortedClubs = sortClubs(loadedClubs);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedClubs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        mainAxisExtent: 50,
      ),
      itemBuilder: (context, index) =>
          //Text(sortedClubs[index].name + sortedClubs[index].win.toString()),
          ClubRowDisplay(club: sortedClubs[index]),
    );
  }
}
