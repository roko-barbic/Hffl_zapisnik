import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/clubs_ranking_populated.dart';


class ClubsRanking extends StatelessWidget {
  const ClubsRanking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
      ),
      body: Center(
        child: BlocBuilder<ClubsCubit, ClubsState>(
          builder: (context, state){
            return switch(state.clubsLoadingStatus){
              LoadingStatus.initial => const Text("Hello"), //tu sad treba definirat widget za kad nema niceg, itd za ostale
              LoadingStatus.loading => const CircularProgressIndicator(),
              LoadingStatus.failure => const Text("fail"),
              LoadingStatus.success => ClubsRankingPopulated(clubs: state.clubs ?? const Clubs(clubs: <Club>[Club(id: 1, name: "name", win: 1, draw: 1, loss: 1)]), onRefresh: () {
                return context.read<ClubsCubit>().fetchClubsInfo();
              })
            };
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: ,
      // ),
    );
  }
}
