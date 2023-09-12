import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/widgets/clubsGrid.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
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
        const Expanded(child: ClubsGrid()),
      ],
    );
  }
}
