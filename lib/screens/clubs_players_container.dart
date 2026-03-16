import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/auth_cubit.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/cubit/season_cubit.dart';
import 'package:hffl_zapisnik/screens/clubs_players_screen.dart';


class ClubsPlayersContainer extends StatefulWidget {
  const ClubsPlayersContainer({super.key});

  @override
  State<ClubsPlayersContainer> createState() => _ClubsPlayersContainerState();
}

class _ClubsPlayersContainerState extends State<ClubsPlayersContainer> {
  @override
  Widget build(BuildContext context) {
    final currentSeason = context.select((SeasonCubit cubit) => cubit.state.selectedSeason);
    return BlocBuilder<ClubsCubit, ClubsState>(builder: (context, state){
      return ClubsPlayersScreen(
        createNewPlayer: createNewPlayer,
        archivePlayer: archivePlayer,
        clubName: state.clubPlayersStats?.name ?? "Nan",
        players: state.clubPlayersStats?.players ?? [],
        season: currentSeason
      );
    });
  }

  void archivePlayer(int playerId){
    bool isLoggedIn = context.read<AuthCubit>().state.isLoggedIn;
    bool isCurrentSeason = context.read<SeasonCubit>().state.selectedSeason == DateTime.now().year;
    if(isLoggedIn && isCurrentSeason){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Archive Player"),
          content: const Text("Are you sure you want to archive?\nPlayer will be visible in the when you press plus button on top right corner of this screen"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                context.read<ClubsCubit>().archivePlayer(playerId);
              },
              child: const Text("Archive"),
            ),
          ],
        ),
      );
    }
  }

  void createNewPlayer(){
    context.read<ClubsCubit>().initCreatNewPlayer(context);
  }

  // String findPlayerName(int playerId){
  // }
}