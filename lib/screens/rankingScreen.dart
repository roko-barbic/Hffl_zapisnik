import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/widgets/clubsGrid.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: Card(
            elevation: 2,
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
                const SizedBox(
                  width: 10,
                ),
                const Text("N"),
                const SizedBox(
                  width: 10,
                ),
                const Text("I"),
              ],
            ),
          ),
        ),
        const Expanded(child: ClubsGrid()),
      ],
    );
  }
}
