import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/utility/helper_class.dart';

class RegisterPlayersSwiper extends StatefulWidget {
  RegisterPlayersSwiper({required this.gameDetails, super.key});

  GameDetails gameDetails;

  @override
  State<RegisterPlayersSwiper> createState() => _RegisterPlayersSwiperState();
}

class _RegisterPlayersSwiperState extends State<RegisterPlayersSwiper> {
  int _currentIndex = 0;
  Map<int, int?> homePlayers = {};
  Map<int, int?> awayPlayers = {};
  List<PlayerCombination> homePlayersCombination = [];
  List<PlayerCombination> awayPlayersCombination = [];
  bool isProceedAvailable = true;

  bool isOnProceedVisible() {
    return isProceedAvailable;//(homePlayers.length > 4 && awayPlayers.length > 4);
  }

  Map<int, int?> convertToIntIntComb(List<PlayerCombination> playerCombination) {
    Map<int, int?> newCombination = {};
    for (var player in playerCombination) {
      newCombination.addAll({player.playerId: player.jerseyNumber});
    }
    return newCombination;
  }

  Widget renderProceed() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<GameCubit>().registerPlayersToGamme(widget.gameDetails.gameId, homePlayers, awayPlayers, context);
          setState(() {
            isProceedAvailable = false;
          });
          },
        child: const Text("Proceed"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  void updatePlayerJerseyNumber(
      int playerId, int newJerseyNumber, bool isHomeClub) {
    setState(() {
      if (isHomeClub) {
        homePlayers[playerId] = newJerseyNumber;
        int index = homePlayersCombination.indexWhere(
          (playerCombination) => playerCombination.playerId == playerId,
        );
        if (index != -1) {
          homePlayersCombination[index] = PlayerCombination(
              playerId: homePlayersCombination[index].playerId,
              name: homePlayersCombination[index].name,
              surname: homePlayersCombination[index].surname,
              jerseyNumber: newJerseyNumber);
        }
      }
      else {
        awayPlayers[playerId] = newJerseyNumber;
        int index = awayPlayersCombination.indexWhere(
              (playerCombination) => playerCombination.playerId == playerId,
        );
        if (index != -1) {
          awayPlayersCombination[index] = PlayerCombination(
              playerId: awayPlayersCombination[index].playerId,
              name: awayPlayersCombination[index].name,
              surname: awayPlayersCombination[index].surname,
              jerseyNumber: newJerseyNumber);
        }
      }
    });
  }

  @override
  void initState() {
    homePlayers =
        convertToIntIntComb(widget.gameDetails.homePlayersCombination);
    awayPlayers =
        convertToIntIntComb(widget.gameDetails.awayPlayersCombination);
    homePlayersCombination = widget.gameDetails.homePlayersCombination;
    awayPlayersCombination = widget.gameDetails.awayPlayersCombination;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Swiper(
            itemCount: 2,
            loop: true,
            index: _currentIndex,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              HapticFeedback.mediumImpact(); // Haptic feedback on swipe
            },
            itemBuilder: (BuildContext context, int index) {
              var clubId = 0;
              _currentIndex == 0
                  ? clubId = widget.gameDetails.homeClubId
                  : clubId = widget.gameDetails.awayClubId;
              return ClubsRegistrationCard(
                index: index,
                clubId: clubId,
                isHomeClub: _currentIndex == 0,
                playersCombination: _currentIndex == 0
                    ? homePlayersCombination
                    : awayPlayersCombination,
                updateMap: updatePlayerJerseyNumber,
              ); // Same widget, different data
            },
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.blue,
                color: Colors.grey,
                size: 10.0,
                activeSize: 12.0,
              ),
            ), // Custom dot styling
          ),
        ),
        if (isOnProceedVisible()) renderProceed(),
      ],
    );
  }
}

class ClubsRegistrationCard extends StatelessWidget {
  final int index;
  final int clubId;
  final bool isHomeClub;
  final List<PlayerCombination> playersCombination;
  final Function(int, int, bool) updateMap;

  const ClubsRegistrationCard(
      {super.key,
      required this.index,
      required this.clubId,
      required this.isHomeClub,
      required this.playersCombination,
      required this.updateMap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              ClubIconsPng.clubIcon[clubId] ?? "assets/images/club_image_id_1.png",
              width: 130, // Adjust width
              height: 130, // Adjust height
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: playersCombination.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Player Name
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                playersCombination[index].name +
                                    ' ' +
                                    playersCombination[index].surname,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),

                            SizedBox(
                              width: 50,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey), // Color when not focused
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2), // Color when focused
                                  ),
                                  hintText: playersCombination[index].jerseyNumber != null ? playersCombination[index].jerseyNumber.toString() : "-",
                                ),
                                onChanged: (value) {
                                  int? number = int.tryParse(value);
                                  if (number != null) {
                                    updateMap(
                                        playersCombination[index].playerId,
                                        number,
                                        isHomeClub);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      );
    });
  }
}
