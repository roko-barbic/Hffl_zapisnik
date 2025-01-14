import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';



class ClubRow extends StatelessWidget {
  const ClubRow({required this.club, super.key});

  final Club club;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        child: Card(
          elevation: 2,
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
              Text(club.loss.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
