import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/widgets/tournamentsRowDisplay.dart';

class TournamentsList extends StatelessWidget {

  TournamentsList({this.tournaments, required this.onRefresh, super.key});

  final Tournaments? tournaments;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<TournamentCubit>().fetchTournaments();
          },
          //child: ,
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: tournaments!.tournaments.length,
            itemBuilder: (context, index) {
              return TournamentsRowDisplay(
                tournament: tournaments!.tournaments[index],
                onDelete: (id) {
                  context.read<TournamentCubit>().deleteTournament(id);
                }
              );
            },
          ),
        );
      },
    );
  }
}