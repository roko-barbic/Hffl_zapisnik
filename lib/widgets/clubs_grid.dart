import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/views/clubs_ranking_screen.dart';
import 'package:hffl_zapisnik/widgets/club_row_display.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ClubsGrid extends StatelessWidget {
  const ClubsGrid({required this.clubs, super.key});

  final Clubs clubs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubsCubit, ClubsState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: clubs.clubs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 3,
            mainAxisExtent: 60,
          ),
          itemBuilder: (context, index) =>
              GestureDetector(
                onTap: () => context.read<ClubsCubit>().fetchClubPlayersStats(clubs.clubs[index].id, context),
                child: ClubRow(club: clubs.clubs[index]),
              ),
        );
      },
    );
  }
}
