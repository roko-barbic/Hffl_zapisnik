import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/player.dart';

class PlayerRowDisplay extends StatelessWidget {
  Player player;
  PlayerRowDisplay({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        child: Card(
          elevation: 2,
          child: Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.20,
              child: Text(
                player.surname + ' ' + player.name.characters.first + ".",
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.09,
            ),
            Text(player.touchdownPassCounter.toString()),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Text(player.touchdownCatchCounter.toString()),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.09,
            ),
            Text(player.interceptionCounter.toString()),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Text(player.extreaPointPassCounter.toString()),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.09,
            ),
            Text(player.extraPointCatchCounter.toString()),
          ]),
        ),
      ),
    );
    ;
  }
}
