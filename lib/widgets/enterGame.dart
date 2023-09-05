import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/club.dart';
import '../classes/clubIdDTO.dart';
import '../providers/clubs.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class EnterGame extends StatefulWidget {
  EnterGame({required this.tournamentId, super.key});
  final int tournamentId; // Add 'final' to the member variable.
  @override
  State<EnterGame> createState() => _EnterGameState();
}

class _EnterGameState extends State<EnterGame> {
  late String _dropDownValue;
  bool isLoaded = false;
  int? type;
  List<ClubIdDTO> clubsIDDTO = [];

  Club? clubSelected; // Initialize clubSelected as nullable.

  List<DropdownMenuItem<ClubIdDTO>> club1DropdownItems = [];
  List<DropdownMenuItem<ClubIdDTO>> club2DropdownItems = [];

  ClubIdDTO? selectedValueClubOne;
  ClubIdDTO? selectedValueClubTwo;
  ClubsList? clubs;
  void getClubs() {
    for (var club in clubs!.clubs) {
      bool isInAlready = false;
      for (var clubdto in clubsIDDTO) {
        if (club.id == clubdto.id) {
          isInAlready = true;
        }
      }
      if (!isInAlready) {
        clubsIDDTO.add(ClubIdDTO(name: club.name, id: club.id ?? 0));
      }
    }

    club1DropdownItems = clubsIDDTO
        .map<DropdownMenuItem<ClubIdDTO>>(
          (ClubIdDTO clubIdDTO) => DropdownMenuItem<ClubIdDTO>(
            value: clubIdDTO,
            child: Text(clubIdDTO.name),
          ),
        )
        .toList();
    club2DropdownItems = clubsIDDTO
        .map<DropdownMenuItem<ClubIdDTO>>(
          (ClubIdDTO clubIdDTO) => DropdownMenuItem<ClubIdDTO>(
            value: clubIdDTO,
            child: Text(clubIdDTO.name),
          ),
        )
        .toList();
    isLoaded = true;
  }

  void createGame() async {
    print('create game ' +
        selectedValueClubOne!.id.toString() +
        " " +
        selectedValueClubTwo!.id.toString());
    var url = Uri.https('hfflzapisnik.azurewebsites.net',
        '/newGame/' + widget.tournamentId.toString());
    Map body = {
      "club_HomeId": selectedValueClubOne!.id.toString(),
      "club_AwayId": selectedValueClubTwo!.id.toString()
    };
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // You should initialize _dropDownValue here if needed.
    _dropDownValue = ''; // Replace with an appropriate initial value.
  }

  @override
  Widget build(BuildContext context) {
    clubs = Provider.of<ClubsList>(context);
    getClubs();
    return isLoaded
        ? Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<ClubIdDTO>(
                        items: club1DropdownItems,
                        onChanged: (selectedClub) {
                          // Handle the selected club here.
                          setState(() {
                            selectedValueClubOne = selectedClub;
                          });
                        },
                        hint: const Text('Izaberi klub'),
                        value: selectedValueClubOne,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Text(' vs '),
                      ),
                      DropdownButton<ClubIdDTO>(
                        items: club2DropdownItems,
                        onChanged: (selectedClub) {
                          // Handle the selected club here.
                          setState(() {
                            selectedValueClubTwo = selectedClub;
                          });
                        },
                        hint: const Text('Izaberi klub'),
                        value: selectedValueClubTwo,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () => {createGame()},
                    child: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
