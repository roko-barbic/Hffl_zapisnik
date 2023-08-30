import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/widgets/clubRowDisplay.dart';
import 'package:provider/provider.dart';

import '../providers/clubs.dart';
import '../widgets/userItem.dart';
import '../screens/DetailClubPlayersScreen.dart';

import '../classes/club.dart';

class ClubsGrid extends StatefulWidget {
  const ClubsGrid({super.key});

  @override
  State<ClubsGrid> createState() => _ClubsGridState();
}

class _ClubsGridState extends State<ClubsGrid> {
  ClubsList? clubsList;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (clubsList == null) {
      clubsList = Provider.of<ClubsList>(context);
      clubsList!.updateClubs();
    }
  }

  // List<Club> sortClubs(List<Club> clubs) {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: clubsList!.clubs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        mainAxisExtent: 50,
      ),
      itemBuilder: (context, index) =>
          //Text(sortedClubs[index].name + sortedClubs[index].win.toString()),
          GestureDetector(
              onTap: () {
                // Navigate to another widget and pass information
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailClubPlayersScreen(club: clubsList!.clubs[index]),
                  ),
                );
              },
              child: ClubRowDisplay(
                club: clubsList!.clubs[index],
              )),
    );
  }
}
