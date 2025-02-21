import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:provider/provider.dart';

class GamesRowDisplay extends StatelessWidget {
  Game game;

  GamesRowDisplay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          context
              .read<GameCubit>()
              .fetchGameDetails(game.id ?? 0, context, false);
        },
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 100,
            child: Card(
              elevation: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    clubNameAndIcon(game.clubHome.name, "iconPath", true, context),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: 70,
                        child: Center(
                          child: Text(game.scoreHome.toString() +
                              " : " +
                              game.scoreAway.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                        )),
                    clubNameAndIcon(game.clubAway.name, "iconPath", false, context),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget clubNameAndIcon(String name, String iconPath, bool isHomeClub, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.29,
        height: 100,
        child: isHomeClub
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Image.asset(
                      'assets/images/club_image_id_1.png', //iconPath
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Expanded(child: Padding(
                        padding: const EdgeInsets.only(left: 18.0), child: Text(name,
                    softWrap: true,
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)),
                  ),
                ],
              )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                  Expanded(child:Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child:  Text(name,  softWrap: true,
                      textAlign: TextAlign.center,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Image.asset(
                      'assets/images/club_image_id_1.png', //iconPath
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
