import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/utility/helper_class.dart';



class ClubRow extends StatelessWidget {
  const ClubRow({required this.club, super.key});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        child: Card(
          elevation: 2,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child:  Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    ClubIconsPng.clubIcon[club.id] ?? 'assets/images/club_image_id_1.png',
                    width: 45, // Adjust width
                    height: 45, // Adjust height
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
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
