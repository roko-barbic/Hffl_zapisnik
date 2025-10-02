import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/cubit/season_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/bouncing_ball_progress_indicator.dart';
import 'package:hffl_zapisnik/widgets/centered_svg.dart';
import 'package:hffl_zapisnik/widgets/clubs_ranking_populated.dart';
import 'package:hffl_zapisnik/widgets/connection_error.dart';

class ClubsRanking extends StatelessWidget {
  const ClubsRanking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: BlocBuilder<ClubsCubit, ClubsState>(
        builder: (context, state) {
          return switch (state.clubsLoadingStatus) {
            LoadingStatus.initial => const CenteredSvg(),
            LoadingStatus.loading => RefreshIndicator(
                onRefresh: () => context.read<ClubsCubit>().fetchClubsInfo(context.read<SeasonCubit>().state.selectedSeason),
                child: const BouncingBallProgressIndicator()),
            LoadingStatus.failure => ConnectionError(
                onRefresh: () {
                  context.read<SeasonCubit>().fetchAvailableSeasons();
                  return context.read<ClubsCubit>().fetchClubsInfo(context.read<SeasonCubit>().state.selectedSeason);
                },
              ),
            LoadingStatus.success => ClubsRankingPopulated(
                clubs: state.clubs ??
                    const Clubs(clubs: <Club>[
                      Club(id: 1, name: "name", win: 1, draw: 1, loss: 1)
                    ]),
                onRefresh: () {
                  return context.read<ClubsCubit>().fetchClubsInfo(context.read<SeasonCubit>().state.selectedSeason);
                })
          };
        },
      ),
    );
  }
}
