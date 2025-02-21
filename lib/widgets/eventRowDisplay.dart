// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';

class EventRowDisplay extends StatelessWidget {
  Event event;

  EventRowDisplay({required this.event, super.key});

  String getText() {
    if (event.type == 1 || event.type == 7) {
      return 'TD +6';
    } else if (event.type == 2) {
      return 'INT';
    } else if (event.type == 3) {
      return 'PickSix +6';
    } else if (event.type == 4 || event.type == 8) {
      return 'XP +1';
    } else if (event.type == 5 || event.type == 9) {
      return 'XP2 +2';
    } else {
      return 'SAF +2';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: event.teamGettingPoints == 1
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: SizedBox(
          width: event.type == 6
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.6,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.83),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buildEventRow(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildEventRow(BuildContext context) {
    if (event.type == 6) {
      return [
        Center(child: Text(getText())),
      ];
    }

    if (event.type >= 7) {
      return event.teamGettingPoints == 1
          ? buildRunRow(context)
          : buildReversedRunRow(context);
    }

    return event.teamGettingPoints == 1
        ? buildPassRow(context)
        : buildReversedPassRow(context);
  }

  List<Widget> buildRunRow(BuildContext context) {
    return [
      Center(child: Text(getText())),
      buildPlayerInfo('Run', event.playerOne, context),
    ];
  }

  List<Widget> buildReversedRunRow(BuildContext context) {
    return [
      buildPlayerInfo('Run', event.playerOne, context),
      Center(child: Text(getText())),
    ];
  }

  List<Widget> buildPassRow(BuildContext context) {
    return [
      Center(child: Text(getText())),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildPlayerInfo('Catch', event.playerTwo, context),
          buildPlayerInfo('Pass', event.playerOne, context),
        ],
      )
    ];
  }

  List<Widget> buildReversedPassRow(BuildContext context) {
    return [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildPlayerInfo('Catch', event.playerTwo, context),
        buildPlayerInfo('Pass', event.playerOne, context),
      ]),
      Center(child: Text(getText())),
    ];
  }

  Widget buildPlayerInfo(
      String label, PlayerDto? player, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              '$label: ${player?.LastName ?? "Unknown"} ${player?.firstName.characters.first ?? ""}.'),
        ],
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    String textType = getText();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: event.teamGettingPoints == 1
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: SizedBox(
          width: event.type == 6
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.6,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.83),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
              color: Colors.grey, // Border color
              width: 1.0, // Border thickness
            ),
            ),
            child: event.teamGettingPoints == 1
                ? Row(
                    children: event.type == 6
                        ? [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.13,
                                child: Text(textType),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ]
                        : event.type >= 7
                            ? [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.13,
                                    child: Text(textType),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Run: ' +
                                          //TODO OVO SA USKLICNIKOM NIKAKO NIJE DOMBRO
                                          event.playerOne!.LastName +
                                          " " +
                                          event.playerOne!.firstName.characters.first +
                                          "."),
                                    ],
                                  ),
                                )
                              ]
                            : [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.13,
                                    child: Text(textType),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Catch: ' +
                                          event.playerTwo!.LastName +
                                          " " +
                                          event.playerTwo!.firstName.characters.first +
                                          "."),
                                      Text('Pass: ' +
                                          event.playerOne!.LastName +
                                          " " +
                                          event.playerOne!.firstName.characters.first +
                                          "."),
                                    ],
                                  ),
                                )
                              ],
                  )
                : Row(
                    children: event.type == 6
                        ? [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.13,
                                child: Text(textType),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ]
                        : event.type >= 7
                            ? [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Run: ' +
                                          event.playerOne!.LastName +
                                          " " +
                                          event.playerOne!.firstName.characters.first +
                                          "."),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.13,
                                    child: Text(textType),
                                  ),
                                ),
                              ]
                            : [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Catch: ' +
                                          event.playerTwo!.LastName +
                                          " " +
                                          event.playerTwo!.firstName.characters.first +
                                          "."),
                                      Text('Pass: ' +
                                          event.playerOne!.LastName +
                                          " " +
                                          event.playerOne!.firstName.characters.first +
                                          "."),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.13,
                                    child: Text(textType),
                                  ),
                                ),
                              ],
                  ),
          ),
        ),
      ),
    );
  }*/
}
