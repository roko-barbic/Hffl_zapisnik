import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/connection_error.dart';
import 'package:hffl_zapisnik/widgets/enter_game.dart';
import 'package:hffl_zapisnik/widgets/games_list.dart';

class GamesScreen extends StatefulWidget {
  final int tournamentId;
  final String tournamentName;
  final bool isEditable;

  const GamesScreen(
      {required this.tournamentId,
      required this.tournamentName,
      required this.isEditable,
      super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GameCubit>().fetchGames(widget.tournamentId); // Trigger loader
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tournamentName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<GameCubit>().cleanGamesState();
            Navigator.of(context).pop(); // Pops the current screen
          },
        ),
      ),
      body: Center(
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return switch (state.gamesLoadingStatus) {
              LoadingStatus.initial => const Text(
                  "Nesto bar displayam"), //tu sad treba definirat widget za kad nema niceg, itd za ostale
              LoadingStatus.loading => const SizedBox.shrink(),
              LoadingStatus.failure => ConnectionError(
                  onRefresh: () {
                    return context
                        .read<GameCubit>()
                        .fetchGames(widget.tournamentId);
                  },
                ),
              LoadingStatus.success => GamesList(
                  tournamentId: widget.tournamentId,
                  games: state.games,
                  onRefresh: () =>
                      context.read<GameCubit>().fetchGames(widget.tournamentId),
                  isEditable: widget.isEditable,
                ),
            };
          },
        ),
      ),
      floatingActionButton: widget.isEditable
          ? FloatingActionButton(
              onPressed: () {
                context.read<GameCubit>().resetCreatingGame();

                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (BuildContext context) {
                      return AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom *
                                  0.3),
                          child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: EnterGame(
                                  tournamentId: widget.tournamentId)));
                    });
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
