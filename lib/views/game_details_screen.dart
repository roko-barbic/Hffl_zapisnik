import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/enter_event.dart';
import 'package:hffl_zapisnik/widgets/eventRowDisplay.dart';
import 'package:hffl_zapisnik/widgets/game_events_details.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({Key? key}) : super(key: key);

  @override
  _GameDetailsScreenState createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pregled",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: EnterNewEvent()
                  // EnterEvent(
                  //   gameId: widget.game.id,
                  //   refreshEvents: refreshEvents,
                  // ),
                );
              },
            );
          },
          child: const Icon(Icons.add),

      ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {

          return switch (state.selectedGameLoadingStatus) {
            LoadingStatus.initial => const Text(
                "Nesto bar displayam"), //tu sad treba definirat widget za kad nema niceg, itd za ostale
            LoadingStatus.loading => const Center(child: CircularProgressIndicator()),
            LoadingStatus.failure => const Text("fail"),
            LoadingStatus.success => const GameEventsDetails(),
          };

        },
      ),
    );
  }
}
