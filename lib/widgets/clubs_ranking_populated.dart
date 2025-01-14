import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/widgets/clubs_grid.dart';


class ClubsRankingPopulated extends StatelessWidget {

  const ClubsRankingPopulated({required this.clubs, required this.onRefresh, super.key});

  final Clubs clubs;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: Card(
            elevation: 2,
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "#Momčad",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                const Text("P"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                const Text("N"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                const Text("I"),
              ],
            ),
          ),
        ),
        Expanded(child: ClubsGrid(clubs: clubs)),
      ],
    );
  }
}
