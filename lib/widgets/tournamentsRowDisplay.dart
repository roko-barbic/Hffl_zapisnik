import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/club.dart';
import 'package:hffl_zapisnik/classes/tournament.dart';
import 'package:intl/intl.dart';

class TournamentsRowDisplay extends StatelessWidget {
  Tournament tournament;

  TournamentsRowDisplay({required this.tournament, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
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
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(children: [
                    Text(
                      // "Turnir u " + tournament.location,
                      tournament.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(DateFormat('dd/MM/yyyy').format(tournament.date))
                  ]),
                ),
              ),
              const Icon(Icons.arrow_forward_sharp),
            ],
          ),
        ),
      ),
    );
  }
}
