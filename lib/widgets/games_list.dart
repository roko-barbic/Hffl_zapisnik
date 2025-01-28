import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/widgets/GamesRowDisplay.dart';

class GamesList extends StatelessWidget {

  GamesList({this.games, required this.tournamentId, required this.onRefresh, super.key});

  final int tournamentId;
  final Games? games;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<GameCubit>().fetchGames(tournamentId);
          },
          //child: ,
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: games!.games.length,
            itemBuilder: (context, index) {
              return GamesRowDisplay(
                  game: games!.games[index],
                  // onDelete: (id) { //TODO delete tournament
                  //   context.read<TournamentCubit>().deleteTournament(id);
                  //}
              );
            },
          ),
        );
      },
    );
  }
}