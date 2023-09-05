import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/eventInGame.dart';

class EventRowDisplay extends StatelessWidget {
  EventInGame event;
  EventRowDisplay({required this.event, super.key});

  String getText() {
    if (event.type == 1) {
      return 'TD';
    } else if (event.type == 2) {
      return 'INT';
    } else if (event.type == 3) {
      return 'Pick 6';
    } else if (event.type == 4) {
      return 'XP';
    } else if (event.type == 5) {
      return 'XP2';
    } else {
      return 'SAF';
    }
  }

  @override
  Widget build(BuildContext context) {
    String textType = getText();
    return Align(
      alignment: event.teamGettingPoints == 1
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 50,
        child: Card(
          elevation: 2,
          child: event.teamGettingPoints == 1
              ? Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Text(textType),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text('Pass: ' +
                              event.playerOne.surname +
                              " " +
                              event.playerOne.name.characters.first +
                              "."),
                          Text('Catch: ' +
                              event.playerTwo.surname +
                              " " +
                              event.playerTwo.name.characters.first +
                              "."),
                        ],
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.13,
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Text('Pass: ' +
                              event.playerOne.surname +
                              " " +
                              event.playerOne.name.characters.first +
                              "."),
                          Text('Catch: ' +
                              event.playerTwo.surname +
                              " " +
                              event.playerTwo.name.characters.first +
                              "."),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Text(textType),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
