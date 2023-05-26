import 'package:flutter/material.dart';

//ovo cak i ne treba ako eventTD radi
class EventCard extends StatelessWidget {
  String nameTDPass;
  String nameTDCatch;

  EventCard({required this.nameTDCatch, required this.nameTDPass, super.key});

  @override
  Widget build(BuildContext context) {
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
                        text: 'Catch: ' + nameTDCatch,
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
                        text: 'Pass: ' + nameTDPass,
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
