import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/widgets/deletePopUp.dart';
import 'package:hffl_zapisnik/widgets/eventRowDisplay.dart';

import '../utility/helper_class.dart';

class GameEventsDetails extends StatelessWidget {

  final bool isEditable;
  const GameEventsDetails({required this.isEditable, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
              top: 149,
              // Matches Container height
              left: 0,
              right: 0,
              height: 2,
              // Slightly thicker to ensure coverage
              child: Container(
                decoration:
                BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: Helper().getListOfColorsToBlend(
                      state.selectedGameAndPlayers?.homeClubId ?? 21,
                      state.selectedGameAndPlayers?.awayClubId ?? 21,
                    ),
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                // Score Display
                Container(
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    /*border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.8),
                      width: 0,
                    ),
                  ),*/
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: Helper().getListOfColorsToBlend(
                          state.selectedGameAndPlayers?.homeClubId ?? 21,
                          state.selectedGameAndPlayers?.awayClubId ?? 21),
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.39,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    ClubIconsPng.clubIcon[state
                                                .selectedGameAndPlayers
                                                ?.homeClubId ??
                                            1] ??
                                        "assets/images/club_image_id_1.png",
                                    //iconPath
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 32.0),
                                    child: Text(
                                      state.selectedGame?.clubHomeScore
                                              .toString() ??
                                          '-',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromRGBO(
                                            237, 237, 237, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(237, 237, 237, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.39,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 32.0),
                                    child: Text(
                                      state.selectedGame?.clubAwayScore
                                              .toString() ??
                                          '-',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromRGBO(
                                            237, 237, 237, 1),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    ClubIconsPng.clubIcon[state
                                                .selectedGameAndPlayers
                                                ?.awayClubId ??
                                            1] ??
                                        "assets/images/club_i„mage_id_1.png",
                                    //iconPath
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text(
                                state.selectedGame?.clubHome.name ?? '-',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(237, 237, 237, 1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                state.selectedGame?.clubAway.name ?? '-',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(237, 237, 237, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(fit: StackFit.expand, children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(1.0),
                            Colors.white.withOpacity(0.30),
                          ],
                          stops: const [0.0, 0.45],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: Helper().getListOfColorsToBlend(
                                state.selectedGameAndPlayers?.homeClubId ?? 21,
                                state.selectedGameAndPlayers?.awayClubId ?? 21),
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<GameCubit>()
                            .justFetchGameDetails(state.selectedGame?.id);
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.selectedGame!.events.length,
                        itemBuilder: (context, index) {
                          final event = state.selectedGame!.events[index];
                          return GestureDetector(
                              onLongPress: () => isEditable ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteModal(
                                        id:
                                            state.selectedGame?.events[index]
                                                    .id ??
                                                0,
                                        onDelete: () =>
                                            context
                                                .read<GameCubit>()
                                                .deleteEvent(
                                                    state
                                                            .selectedGame
                                                            ?.events[index]
                                                            .id ??
                                                        0,
                                                    state.selectedGame?.id ??
                                                        0),
                                        warningMessage:
                                            'Želite li obrisati događaj? (id:%s)',
                                        title: 'Brisanje događaja');
                                  }) : {},
                              child: EventRowDisplay(
                                event: event,
                              ));
                        },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
