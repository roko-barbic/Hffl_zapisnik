import 'package:flutter/material.dart';

import 'event.dart';
import '../player.dart';

class XP2 extends Event {
  Player xp2Catch;
  Player xp2Pass;
  XP2({required this.xp2Catch, required this.xp2Pass});
  void addStatistic() {
    xp2Catch.extraPointCatchCounter++;
    xp2Pass.extreaPointPassCounter++;
  }

  @override
  Widget writeCard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 95,
      height: 100,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 15, right: 50),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Catch:' + xp2Catch.name,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pass' + xp2Pass.name,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
