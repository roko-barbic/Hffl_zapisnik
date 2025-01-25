import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/enter_tournament.dart';
import 'package:hffl_zapisnik/widgets/tournaments_list.dart';
import 'package:hffl_zapisnik/widgets/upload_image.dart';

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({super.key});

  @override
  State<TournamentsScreen> createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournaments'),
      ),
      body: Center(
        child: BlocBuilder<TournamentCubit, TournamentState>(
          builder: (context, state) {
            return switch (state.tournamentLoadingStatus) {
              LoadingStatus.initial => const Text(
                  "Nesto bar displayam"), //tu sad treba definirat widget za kad nema niceg, itd za ostale
              LoadingStatus.loading => const CircularProgressIndicator(),
              LoadingStatus.failure => const Text("fail"),
              LoadingStatus.success => TournamentsList(
                  tournaments: state.tournaments,
                  onRefresh: () =>
                      context.read<TournamentCubit>().fetchTournaments(),
                ),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: const EnterTournament()
                    ));
              });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UploadPicture()),
          // );
    },
        child: const Icon(Icons.add),
      ),
    );
  }
}
