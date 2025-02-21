import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_api/hffl_api.dart';

class EnterNewEvent extends StatefulWidget {
  const EnterNewEvent({super.key});

  @override
  State<EnterNewEvent> createState() => _EnterNewEventState();
}

class _EnterNewEventState extends State<EnterNewEvent> {
  int? typeOfEvent;
  late bool isHomeClub;
  int? firstPlayerId;
  int? secondPlayerId;

  @override
  void initState() {
    isHomeClub = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Touchdown'),
                  ),
                  DropdownMenuItem(
                    value: 7,
                    child: Text('TouchDown Run'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Interception'),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('Pick Six'),
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text('Extrapoint'),
                  ),
                  DropdownMenuItem(
                    value: 8,
                    child: Text('Extrapoint Run'),
                  ),
                  DropdownMenuItem(
                    value: 5,
                    child: Text('Extrapoint 2'),
                  ),
                  DropdownMenuItem(
                    value: 9,
                    child: Text('Extrapoint 2 Run'),
                  ),
                  DropdownMenuItem(
                    value: 6,
                    child: Text('Safety'),
                  ),
                ],
                onChanged: (int? value) {
                  setState(() {
                    resetValues();
                    typeOfEvent = value;
                  });
                },
                value: typeOfEvent,
                hint: const Center(child: Text("Odabirete tip događaja")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: SegmentedButton(
                segments: <ButtonSegment<bool>>[
                  ButtonSegment<bool>(
                      value: true,
                      label: Text(
                          state.selectedGame?.clubHome.name ?? "Nije ucitano")),
                  ButtonSegment<bool>(
                      value: false,
                      label: Text(
                          state.selectedGame?.clubAway.name ?? "Nije ucitano"))
                ],
                selected: <bool>{isHomeClub},
                onSelectionChanged: (newSet) {
                  setState(() { // This now updates the whole widget
                    resetValues();
                    isHomeClub = newSet.first;
                  });
                },
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return ChosePlayersWidget(
                    state.selectedGameAndPlayers?.homePlayersCombination ??
                        <PlayerCombination>[],
                    state.selectedGameAndPlayers?.awayPlayersCombination ??
                        <PlayerCombination>[],
                    isHomeClub,
                    typeOfEvent);
              },
            ),
            if (isButtonVisible(state.selectedGameAndPlayers!.gameId))
              ElevatedButton(
                  onPressed: () {
                    if(typeOfEvent == 6){
                      if(isHomeClub){
                        firstPlayerId = state.selectedGameAndPlayers!.homePlayersCombination.first.playerId;
                      }
                      else{
                        firstPlayerId = state.selectedGameAndPlayers!.awayPlayersCombination.first.playerId;
                      }
                    }
                    context.read<GameCubit>().addNewEvent(
                      state.selectedGameAndPlayers!.gameId, EventDto(playerOneId: firstPlayerId ?? 0, playetTwoId: secondPlayerId ?? 0, type: typeOfEvent!));
                      Navigator.of(context).pop();
                    },
                  child: const Icon(Icons.add))
          ],
        ),
      );
    });
  }

  bool isButtonVisible(int? gameId) {

    if(typeOfEvent == 1 || typeOfEvent == 4 || typeOfEvent == 5 || typeOfEvent == 2 || typeOfEvent == 3){
      return (gameId != null &&
          firstPlayerId != null &&
          secondPlayerId != null &&
          typeOfEvent != null);
    }else if(typeOfEvent == 7 || typeOfEvent == 8 || typeOfEvent == 9){
      return (gameId != null &&
          firstPlayerId != null &&
          typeOfEvent != null);
    }
    else{
      return (gameId != null &&
          typeOfEvent == 6);
    }
  }

  List<DropdownMenuItem<int>> buildDropdownItems(
      List<PlayerCombination> players) {
    return players
        .where((player) => player.jerseyNumber != null && player.jerseyNumber != 0)
        .map((player) {
      return DropdownMenuItem<int>(
        value: player.playerId,
        child: Container(
            width: 50,
            child: Text("${player.jerseyNumber ?? '-'}")), //mozes dodat i ime
      );
    }).toList();
  }

  void resetValues(){
    firstPlayerId = null;
    secondPlayerId = null;

  }

  Widget ChosePlayersWidget(List<PlayerCombination> homePlayersCombination,
      List<PlayerCombination> awayPlayersCombination, bool isHome, int? type) {
    switch (type) {
      case 1:
      case 4:
      case 5:
        return isHome
            ? ChosePlayerSegment(
                "Loptu je bacio",
                "Loptu je uhvatio",
                buildDropdownItems(homePlayersCombination),
                buildDropdownItems(homePlayersCombination))
            : ChosePlayerSegment(
                "Loptu je bacio",
                "Loptu je uhvatio",
                buildDropdownItems(awayPlayersCombination),
                buildDropdownItems(awayPlayersCombination));
      case 7:
      case 8:
      case 9:
        return isHome
            ? ChosePlayerSegment("Run je napravio", null,
                buildDropdownItems(homePlayersCombination), null)
            : ChosePlayerSegment("Run je napravio", null,
                buildDropdownItems(awayPlayersCombination), null);
      case 2:
      case 3:
        return isHome
            ? ChosePlayerSegment(
                "Loptu je bacio",
                "Loptu je presjekao",
                buildDropdownItems(awayPlayersCombination),
                buildDropdownItems(homePlayersCombination))
            : ChosePlayerSegment(
                "Run je napravio",
                "Loptu je presjekao",
                buildDropdownItems(homePlayersCombination),
                buildDropdownItems(awayPlayersCombination));
      case 6:
      case null:
        return const SizedBox(
          height: 0,
        );
    }
    return const Row(
      children: [
        Column(
          children: [],
        ),
      ],
    );
  }

  Widget ChosePlayerSegment(
      String? playerOneDescription,
      String? playerTwoDescription,
      List<DropdownMenuItem<int>>? playersOne,
      List<DropdownMenuItem<int>>? playersTwo) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          if (playerOneDescription != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    playerOneDescription,
                    style: const TextStyle(fontSize: 16),
                  ),
                  DropdownButton(
                    items: playersOne,
                    onChanged: (value) {
                      setState(() {
                        if(value != null)
                        firstPlayerId = value;
                      });
                    },
                    value: firstPlayerId,
                    hint: const Text("Broj dresa igrača"),
                  )
                ],
              ),
            ),
          if (playerTwoDescription != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  playerTwoDescription,
                  style: const TextStyle(fontSize: 16),
                ),
                DropdownButton(
                  items: playersTwo,
                  onChanged: (value) {
                    setState(() {
                      secondPlayerId = value;
                    });
                  },
                  value: secondPlayerId,
                  hint: const Text("Broj dresa igrača"),
                )
              ],
            ),
        ],
      ),
    );
  }
}
