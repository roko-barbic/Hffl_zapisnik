import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/cubit/season_cubit.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/cubit/auth_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/bouncing_ball_progress_indicator.dart';
import 'package:hffl_zapisnik/widgets/centered_svg.dart';
import 'package:hffl_zapisnik/widgets/connection_error.dart';
import 'package:hffl_zapisnik/widgets/enter_tournament.dart';
import 'package:hffl_zapisnik/widgets/tournaments_list.dart';

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({super.key});

  @override
  State<TournamentsScreen> createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
  builder: (context, authState) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Center(
        child: BlocBuilder<TournamentCubit, TournamentState>(
          builder: (context, state) {
            return switch (state.tournamentLoadingStatus) {
              LoadingStatus.initial => const CenteredSvg(),
              LoadingStatus.loading => const BouncingBallProgressIndicator(),
              LoadingStatus.failure => ConnectionError(
                onRefresh: () {
                    context.read<SeasonCubit>().fetchAvailableSeasons();
                   context.read<TournamentCubit>().fetchTournaments(context.read<SeasonCubit>().state.selectedSeason);
                   },
              ),
              LoadingStatus.success => TournamentsList(
                  tournaments: state.tournaments,
                  onRefresh: () =>
                      context.read<TournamentCubit>().fetchTournaments(context.read<SeasonCubit>().state.selectedSeason),
                ),
            };
          },
        ),
      ),
      floatingActionButton: !authState.isGuestMode ? FloatingActionButton(
        onPressed: () {
          context.read<TournamentCubit>().resetCreatingTournament();
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (BuildContext context) {
                return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom * 0.4),
                    child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const EnterTournament()));
              });
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  },
);
  }
}
