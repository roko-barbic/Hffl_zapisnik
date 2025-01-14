

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/enterTurnament.dart';
import 'package:hffl_zapisnik/widgets/tournaments_list.dart';

class TournamentsScreen extends StatelessWidget{

  const TournamentsScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: const Text('Tournaments'),
    ),
    body: Center(
      child: BlocBuilder<TournamentCubit, TournamentState>(
        builder: (context, state) {
          return switch(state.tournamentLoadingStatus){
            LoadingStatus.initial => const Text("Nesto bar displayam"), //tu sad treba definirat widget za kad nema niceg, itd za ostale
            LoadingStatus.loading => const CircularProgressIndicator(),
            LoadingStatus.failure => const Text("fail"),
            LoadingStatus.success =>  TournamentsList(tournaments: state.tournaments, onRefresh: () => context.read<TournamentCubit>().fetchTournaments(),),
          };

        },
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Call the cubit's function to add or modify state
        //context.read<TournamentCubit>().addTournament();
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const EnterTurnament();
            });
      },
      child: const Icon(Icons.add),
    ),);

  }

}