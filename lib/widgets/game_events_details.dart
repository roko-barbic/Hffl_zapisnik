import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/widgets/eventRowDisplay.dart';



class GameEventsDetails extends StatelessWidget {
  const GameEventsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Column(
          children: [
            // Score Display
            Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                    width: 2.0,
                  ),
                ),
              ),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    children: [
                      TextSpan(
                        text: state.selectedGame!.clubHome.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                          " ${state.selectedGame!.clubHomeScore} : ${state
                              .selectedGame!.clubAwayScore} "),
                      TextSpan(
                        text: state.selectedGame!.clubAway.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),


            const SizedBox(height: 20),

            Expanded(
                child: RefreshIndicator(
                  onRefresh: () async{
                    context.read<GameCubit>().justFetchGameDetails(state.selectedGame?.id);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.selectedGame!.events.length,
                    itemBuilder: (context, index) {
                      final event = state.selectedGame!.events[index];
                      return EventRowDisplay(event: event,);
                    },
                  ),
                ),
            ),
          ],
        );
      },
    );
  }
}
