import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';

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
      // floatingActionButton: Visibility(
      //   visible: isLoggedIn,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       showModalBottomSheet(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return Container(
      //             height: MediaQuery.of(context).size.height * 0.5,
      //             padding: EdgeInsets.all(16),
      //             child: EnterEventSc(
      //               gameId: widget.game.id,
      //               refreshEvents: refreshEvents,
      //             ),
      //           );
      //         },
      //       );
      //     },
      //     child: Icon(Icons.add, color: Colors.white),
      //     backgroundColor: Colors.blue,
      //   ),
      // ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state.selectedGameLoadingStatus == LoadingStatus.initial ||
              state.selectedGameLoadingStatus == LoadingStatus.failure)
            return Text("data");
          else if (state.selectedGameLoadingStatus == LoadingStatus.success) {
            return Column(
              children: [
                // Score Display
                Container(
                  height: 80,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
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
                                  " ${state.selectedGame!.clubHomeScore} : ${state.selectedGame!.clubAwayScore} "),
                          TextSpan(
                            text: state.selectedGame!.clubAway.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Events List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: state.selectedGame!.events.length,
                    itemBuilder: (context, index) {
                      final event = state.selectedGame!.events[index];
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text("Event Type: ${event.type}"),
                          subtitle: Text(
                            "Players: ${event.playerOne.firstName} & ${event.playerTwo.firstName}",
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete Event'),
                                    content: Text(
                                      'Are you sure you want to delete this event? (ID: ${event.id})',
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          // bool deleted = await deleteEvent(event.id);
                                          // if (deleted) {
                                          //   refreshEvents();
                                          // }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Text("Fail");
        },
      ),
    );
  }
}
