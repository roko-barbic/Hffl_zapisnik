import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/club.dart';

class ClubRowDisplay extends StatelessWidget {
  Club club;

  ClubRowDisplay({required this.club, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        child: Card(
          elevation: 0.1,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  club.name,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(club.win.toString()),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(club.draw.toString()),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(club.lose.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
