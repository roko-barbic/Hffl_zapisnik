import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/auth_cubit.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/delegates/parallax_flow_delegate.dart';
import 'package:hffl_zapisnik/screens/games_screen.dart';
import 'package:hffl_zapisnik/widgets/modals/delete_modal.dart';
import 'package:intl/intl.dart';

class TournamentsRowDisplay extends StatelessWidget {
  Tournament tournament;
  Function(int) onDelete;
  final GlobalKey _backgroundImageKey = GlobalKey();

  TournamentsRowDisplay(
      {required this.tournament, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => GamesScreen(
                    tournamentId: tournament.id ?? 0,
                    tournamentName: tournament.name,
                    isEditable: (!(tournament.isFinished ?? true) &&
                        !(state.isGuestMode))),
              ),
            );
          },
          onLongPress: () => state.isGuestMode
              ? {}
              : {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteModal(
                          id: tournament.id ?? 0,
                          onDelete: () => onDelete(tournament.id ?? 0),
                          warningMessage:
                              "Jeste li sigurni da želite obrisati ${tournament.name}?",
                          title: "Brisanje turnira");
                    },
                  )
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        //color: Theme.of(context).primaryColor, // Shadow color
                        blurRadius: 10, // Spread of the shadow
                        offset: Offset(0, 4),
                      )
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      _buildParallaxBackground(context),
                      if (!state.isGuestMode) ...<Widget>[
                        _buildGradient(),
                        _buildTitleAndSubtitle(),
                        _buildDownloadButton(context),
                        _buildLockTournamentButton(context),
                      ]
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
              child: CircularProgressIndicator(),
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

  Widget _buildLockTournamentButton(BuildContext context) {
    return Positioned(
      right: 50,
      bottom: 20,
      child: GestureDetector(
        onTap: () => context.read<TournamentCubit>().toggleTournamentStatus(
            tournament.isFinished ?? false, tournament.id ?? 0),
        child: Icon(
          (tournament.isFinished ?? false) ? Icons.lock : Icons.lock_open,
          color: Colors.white,
        ),
      ),
    );
  }
}
