import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/delegates/parallax_flow_delegate.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/views/games_screen.dart';
import 'package:intl/intl.dart';

class TournamentsRowDisplay extends StatelessWidget {
  Tournament tournament;
  Function(int) onDelete;
  final GlobalKey _backgroundImageKey = GlobalKey();

  TournamentsRowDisplay(
      {required this.tournament, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(builder: (context, state) {
      return GestureDetector(
          //onTap: () => context.read<TournamentCubit>().deleteTournament(tournament.id),

          onTap: () {
            context.read<GameCubit>().fetchGames(tournament.id ?? 0);

            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    GamesScreen(tournamentId: tournament.id ?? 0, tournamentName: tournament.name,),
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete tournament'),
                  content: Text(
                      'Are you sure you want to delete tournament? (id: ${tournament.id.toString()})'),
                  actions: <Widget>[
                    BlocBuilder<TournamentCubit, TournamentState>(
                        builder: (context, state) {
                      if (state.deletingTournament == LoadingStatus.initial) {
                        return TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              onDelete(tournament.id ?? 0); //todo prepravi
                              Navigator.of(context).pop();
                            });
                      } else if (state.deletingTournament ==
                          LoadingStatus.loading) {
                        return const CircularProgressIndicator();
                      } else {
                        return TextButton(
                            child: const Text('Failed'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            });
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow:const  [BoxShadow(
                    //color: Theme.of(context).primaryColor, // Shadow color
                    blurRadius: 10, // Spread of the shadow
                    offset: Offset(0, 4),
                  )]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      _buildParallaxBackground(context),
                      _buildGradient(),
                      _buildTitleAndSubtitle(),
                      _buildDownloadButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          tournament.coverPhoto ??
              "https://media.ksdk.com/assets/CCT/images/d54f648e-df76-466e-bfd6-3b7bcdd2158a/d54f648e-df76-466e-bfd6-3b7bcdd2158a_1140x641.jpg",
          key: _backgroundImageKey,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const Center(
              child: CircularProgressIndicator(
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 48,
                ),
              ));
          },
          )
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tournament.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat('dd/MM/yyyy').format(tournament.date),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: GestureDetector(
        onTap: () => context
            .read<TournamentCubit>()
            .dowloadTournamentSummary(tournament.id ?? 0, context),
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
      ),
    );
  }
}
