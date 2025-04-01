import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/utility/helper_class.dart';
import 'package:hffl_zapisnik/widgets/enter_event.dart';
import 'package:hffl_zapisnik/widgets/game_events_details.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({required this.isEditable, Key? key})
      : super(key: key);
  final bool isEditable;

  @override
  _GameDetailsScreenState createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Pregled",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              flexibleSpace: (state.selectedGameLoadingStatus ==
                      LoadingStatus.success)
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: Helper().getListOfColorsToBlend(
                              state.selectedGameAndPlayers?.homeClubId ?? 21,
                              state.selectedGameAndPlayers?.awayClubId ?? 21),
                          stops: const [
                            0.0,
                            0.5,
                            1.0
                          ], // Define transition points
                        ),
                      ),
                    )
                  : null,
            ),
            floatingActionButton: widget.isEditable
                ? FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              child: const EnterNewEvent());
                        },
                      );
                    },
                    child: const Icon(Icons.add),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            body: switch (state.selectedGameLoadingStatus) {
              LoadingStatus.initial => const Text(
                  "Nesto bar displayam"), //tu sad treba definirat widget za kad nema niceg, itd za ostale
              LoadingStatus.loading =>
                const Center(child: CircularProgressIndicator()),
              LoadingStatus.failure => RefreshIndicator(
                  onRefresh: () => context
                      .read<GameCubit>()
                      .justFetchGameDetails(state.selectedGame?.id ?? 0),
                  child:
                      const Center(child: Text("Neuspijeh, probaj refreshat"))),
              LoadingStatus.success => GameEventsDetails(
                  isEditable: widget.isEditable,
                ),
            });
      },
    );
  }
}
