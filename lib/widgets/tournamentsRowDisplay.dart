import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:intl/intl.dart';

class TournamentsRowDisplay extends StatelessWidget {
  Tournament tournament;
  Function(int) onDelete;

  TournamentsRowDisplay(
      {required this.tournament, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => context.read<TournamentCubit>().deleteTournament(tournament.id),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete tournament'),
              content: Text(
                  'Are you sure you want to delete tournament? (id: ${tournament.id.toString()})'),
              actions: <Widget>[
                BlocBuilder<TournamentCubit, TournamentState>(builder: (context, state){
                  if(state.deletingTournament == LoadingStatus.initial){
                    return TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          onDelete(tournament.id);
                          Navigator.of(context).pop();
                        }
                    );
                  }
                  else if(state.deletingTournament == LoadingStatus.loading){
                    return const CircularProgressIndicator();
                  }
                  else{
                    return TextButton(
                        child: const Text('Failed'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }
                    );
                  }
                }),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 80,
          child: Card(
            elevation: 2,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      Text(
                        // "Turnir u " + tournament.location,
                        tournament.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(DateFormat('dd/MM/yyyy').format(tournament.date))
                    ]),
                  ),
                ),
                const Icon(Icons.arrow_forward_sharp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
