import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/widgets/game_row.dart';
import 'package:hffl_zapisnik/widgets/deletePopUp.dart';
import 'package:hffl_zapisnik/widgets/game_row.dart';

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
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: games!.games.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    context
                        .read<GameCubit>()
                        .fetchGameDetails(games?.games[index].id ?? 0, context, false);
                  },
                  onLongPress: () => showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteModal(
                            id: games?.games[index].id ??
                                0,
                            onDelete: () => context
                                .read<GameCubit>()
                                .deleteGame(
                                games?.games[index].id ??
                                    0,
                                state.games?.id ?? 0),
                            warningMessage:
                            'Želite li obrisati utakmicu? (id:%s)',
                            title: 'Brisanje utakmice');
                      }),
                  child: GamesRowDisplay(
                  game: games!.games[index],
                   onDelete: () { //TODO delete tournament
                     context.read<GameCubit>().deleteGame(games?.games[index].id ?? 0, tournamentId);
                  }
              ));
            },
          ),
        );
      },
    );
  }
}