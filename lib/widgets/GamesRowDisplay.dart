import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/game.dart';

class GamesRowDisplay extends StatelessWidget {
  Game game;
  GamesRowDisplay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 70,
        child: Card(
          elevation: 2,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 50,
                  child: Center(child: Text(game.clubHome.name))),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 50,
                  child: Center(
                    child: Text(game.scoreHome.toString() +
                        " : " +
                        game.scoreAway.toString()),
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 50,
                  child: Center(child: Text(game.clubAway.name))),
              const Icon(Icons.arrow_forward_sharp),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
