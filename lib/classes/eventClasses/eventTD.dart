import 'package:flutter/material.dart';

import 'event.dart';
import '../player.dart';
import '../../widgets/eventTDCard.dart';

class TouchDown extends Event {
  Player touchdownCatch;
  Player touchdownPass;
  TouchDown({required this.touchdownCatch, required this.touchdownPass});
  void addStatistic() {
    touchdownCatch.touchdownCatchCounter++;
    touchdownPass.touchdownPassCounter++;
  }

  @override
  Widget writeCard(BuildContext context) {
    return EventCard(
        nameTDCatch: touchdownCatch.name,
        nameTDPass: touchdownPass
            .name); /*SizedBox(
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
                        text: touchdownCatch.name,
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
                        text: touchdownPass.name,
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
    );*/
  }
}
