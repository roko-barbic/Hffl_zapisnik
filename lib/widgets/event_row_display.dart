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
          width: MediaQuery.of(context).size.width * 0.7,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(237, 237, 237, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                    spreadRadius: 0,
                  ),
                ]),
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
      return event.teamGettingPoints == 1
          ? buildSafetyRow(context)
          : buildReversedSafetyRow(context);
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

  List<Widget> buildSafetyRow(BuildContext context) {
    return [
      Center(child: Text(getText())),
      buildPlayerInfo('Safety', event.playerTwo, context),
    ];
  }

  List<Widget> buildReversedSafetyRow(BuildContext context) {
    return [
      buildPlayerInfo('Safety', event.playerTwo, context),
      Center(child: Text(getText())),
    ];
  }

  Widget buildPlayerInfo(
      String label, PlayerDto? player, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              '$label: ${player?.LastName ?? "Unknown"} ${player?.firstName.characters.first ?? ""}${player?.firstName != null ? "." : ""}'),
        ],
      ),
    );
  }
}
