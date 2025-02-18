import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/enterGame.dart';
import 'package:hffl_zapisnik/widgets/enter_tournament.dart';
import 'package:hffl_zapisnik/widgets/games_list.dart';

class GamesScreen extends StatefulWidget {
  final int tournamentId;
  final String tournamentName;

  const GamesScreen({required this.tournamentId, required this.tournamentName, super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
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
              LoadingStatus.loading => const Center(
                  child: SizedBox(
                      width: 100, height: 100, child: CircularProgressIndicator())),
              LoadingStatus.failure => const Text("fail"),
              LoadingStatus.success => GamesList(
                  tournamentId: widget.tournamentId,
                  games: state.games,
                  onRefresh: () =>
                      context.read<GameCubit>().fetchGames(widget.tournamentId),
                ),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
                        bottom: MediaQuery.of(context).viewInsets.bottom * 0.3),
                    child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: EnterGame(tournamentId: widget.tournamentId)));
              });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UploadPicture()),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
