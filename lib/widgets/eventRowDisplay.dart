// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/eventInGame.dart';

class EventRowDisplay extends StatelessWidget {
  EventInGame event;
  EventRowDisplay({required this.event, super.key});

  String getText() {
    if (event.type == 1 || event.type == 7) {
      return 'TD  +6';
    } else if (event.type == 2) {
      return 'INT';
    } else if (event.type == 3) {
      return 'PickSix  +6';
    } else if (event.type == 4 || event.type == 8) {
      return 'XP  +1';
    } else if (event.type == 5 || event.type == 9) {
      return 'XP2  +2';
    } else {
      return 'SAF  +2';
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
        width: event.type == 6
            ? MediaQuery.of(context).size.width * 0.3
            : MediaQuery.of(context).size.width * 0.6,
        height: 60,
        child: Card(
          elevation: 2,
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
                                        event.playerOne.surname +
                                        " " +
                                        event.playerOne.name.characters.first +
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
                                        event.playerOne.surname +
                                        " " +
                                        event.playerOne.name.characters.first +
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  child: Text(textType),
                                ),
                              ),
                            ],
                ),
        ),
      ),
    );
  }
}
