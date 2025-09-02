import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/utility/helper_class.dart';

class GamesRowDisplay extends StatelessWidget {
  final Game game;
  final Function() onDelete;

  GamesRowDisplay({required this.game, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                    color: ClubColors.clubColors[game.clubHomeId] ?? Colors.black,
                    width: 9.0,
                  ),
                  right: BorderSide(
                    color: ClubColors.clubColors[game.clubAwayId] ?? Colors.black,
                    width: 9.0,
                  ),
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  clubNameAndIcon(game.clubHome.name, "iconPath", true, context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: 70,
                    child: Center(
                      child: Text(
                        "${game.scoreHome} : ${game.scoreAway}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  clubNameAndIcon(game.clubAway.name, "iconPath", false, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget clubNameAndIcon(
      String name, String iconPath, bool isHomeClub, BuildContext context) {
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
                      ClubIconsPng.clubIcon[game.clubHomeId] ??
                          'assets/images/club_image_id_1.png',
                      width: 39,
                      height: 39,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          name,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(name,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Image.asset(
                      ClubIconsPng.clubIcon[game.clubAwayId] ??
                          'assets/images/club_image_id_1.png',
                      width: 39,
                      height: 39,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
