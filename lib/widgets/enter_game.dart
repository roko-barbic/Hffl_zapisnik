import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';

class EnterGame extends StatefulWidget {
  const EnterGame({required this.tournamentId, Key? key}) : super(key: key);

  final int tournamentId;

  @override
  State<EnterGame> createState() => _EnterGameState();
}

class _EnterGameState extends State<EnterGame> {
  Club? selectedValueClubOne;
  Club? selectedValueClubTwo;

  bool canGameBeCreated() {
    if (selectedValueClubOne != null &&
        selectedValueClubTwo != null &&
        !(selectedValueClubOne?.id == selectedValueClubTwo?.id)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final clubs = context.read<ClubsCubit>().state.clubs!.clubs;
    final dropdownItems = clubs
        .map<DropdownMenuItem<Club>>(
          (club) => DropdownMenuItem<Club>(
            value: club,
            child: Text(club.name),
          ),
        )
        .toList();

    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        if (state.creatingGameStatus == LoadingStatus.initial) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<Club>(
                        items: dropdownItems,
                        onChanged: (selectedClub) {
                          setState(() {
                            selectedValueClubOne = selectedClub;
                          });
                        },
                        hint: const Text('Odaberite domacina'),
                        value: selectedValueClubOne,
                      ),
                      const SizedBox(width: 20, child: Text(' vs ')),
                      DropdownButton<Club>(
                        items: dropdownItems,
                        onChanged: (selectedClub) {
                          setState(() {
                            selectedValueClubTwo = selectedClub;
                          });
                        },
                        hint: const Text('Odaberite gosta'),
                        value: selectedValueClubTwo,
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (canGameBeCreated())
                    FloatingActionButton(
                      onPressed: () {
                        if (selectedValueClubOne != null &&
                            selectedValueClubTwo != null) {
                          context.read<GameCubit>().createGame(
                                widget.tournamentId,
                                selectedValueClubOne!.id,
                                selectedValueClubTwo!.id,
                              );
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Potrebno je odabrati oba kluba'),
                            ),
                          );
                        }
                      },
                      child: const Icon(Icons.add),
                    )
                ],
              ),
            ),
          );
        } else if (state.creatingGameStatus == LoadingStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.creatingGameStatus == LoadingStatus.success) {
          return const Text("Uspijeh");
        }
        return const Text("Neuspiheh");
      },
    );
  }
}
