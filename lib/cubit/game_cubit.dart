import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/views/game_details_screen.dart';
import 'package:hffl_zapisnik/views/register_players_screen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hffl_zapisnik/global_keys.dart';
import 'package:loader_overlay/loader_overlay.dart';

part 'game_state.dart';

part 'game_cubit.g.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this._hfflRepository)
      : super(const GameState(
          gamesLoadingStatus: LoadingStatus.initial,
          selectedGameLoadingStatus: LoadingStatus.initial,
          creatingGameStatus: LoadingStatus.initial,
        ));

  final HfflRepository _hfflRepository;

  Future<void> fetchGames(int tournamentId) async {
    navigatorKey.currentContext?.loaderOverlay.show();
    //cleanGamesState();
    try {
      if (state.gamesLoadingStatus == LoadingStatus.initial) {
        emit(state.copyWith(gamesLoadingStatus: LoadingStatus.loading));
      }
      final games =
          await _hfflRepository.fetchGames(tournamentId); //ovo sam changeo
      if (games != null)
        emit(state.copyWith(
            games: games, gamesLoadingStatus: LoadingStatus.success));
    } on Exception {
      emit(state.copyWith(gamesLoadingStatus: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }

  void cleanGamesState() {
    emit(
        state.copyWith(games: null, gamesLoadingStatus: LoadingStatus.initial));
  }

  Future<void> resetCreatingGame() async {
    return emit(state.copyWith(creatingGameStatus: LoadingStatus.initial));
  }

  Future<void> createGame(
      int tournamentId, int homeClubId, int awayClubId) async {
    if (state.creatingGameStatus == LoadingStatus.initial) {
      emit(state.copyWith(creatingGameStatus: LoadingStatus.loading));
    }
    final complete =
        await _hfflRepository.createGame(tournamentId, homeClubId, awayClubId);
    if (complete ?? false) {
      fetchGames(tournamentId);
      emit(state.copyWith(creatingGameStatus: LoadingStatus.success));
    } else {
      emit(state.copyWith(creatingGameStatus: LoadingStatus.failure));
    }
  }

  Future<void> deleteGame(int gameId, int tournamentId) async {
    navigatorKey.currentContext?.loaderOverlay.show();
    final isSuccessful = await _hfflRepository.deleteGame(gameId);
    navigatorKey.currentContext?.loaderOverlay.hide();
    if (isSuccessful) {
      fetchGames(tournamentId);
    }
  }

  Future<void> fetchGameDetails(
      int gameId, BuildContext context, bool isFromRegistration) async {
    navigatorKey.currentContext?.loaderOverlay.show();
    if (state.selectedGameLoadingStatus == LoadingStatus.initial) {
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
    } //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GameDetailsScreen()));
    try {
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
      final gameDetails = await _hfflRepository.getGameDetails(gameId);
      if (gameDetails != null) {
        emit(state.copyWith(
            selectedGame: gameDetails,
            selectedGameLoadingStatus: LoadingStatus.success));
        if (gameDetails.playerRegistration) {
          await fetchGameAndPlayerDetails(gameId);
          if (isFromRegistration) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const GameDetailsScreen()));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GameDetailsScreen()));
          }
        } else {
          await fetchGameAndPlayerDetails(gameId);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RegisterPlayersScreen()));
        }
      } else {
        emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
      }
    } on Exception {
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }

  Future<void> justFetchGameDetails(int? gameId) async {
    if (gameId != null) {
      try {
        if (state.selectedGameLoadingStatus == LoadingStatus.initial) {
          emit(
              state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
        }
        final gameDetails = await _hfflRepository.getGameDetails(gameId);
        if (gameDetails != null) {
          emit(state.copyWith(
              selectedGame: gameDetails,
              selectedGameLoadingStatus: LoadingStatus.success));
        } else {
          emit(
              state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
        }
      } on Exception {
        emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
      }
    }
  }

  Future<void> fetchGameAndPlayerDetails(int gameId) async {
    emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
    try {
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
      final gameDetails = await _hfflRepository.getGameAndPlayerDetails(gameId);
      if (gameDetails != null) {
        emit(state.copyWith(
            selectedGameAndPlayers: gameDetails,
            selectedGameLoadingStatus: LoadingStatus.success));
      } else {
        emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
      }
    } on Exception {
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
    }
  }

  Future<void> registerPlayersToGamme(int gameId, Map<int, int?> homePlayers,
      Map<int, int?> awayPlayers, BuildContext context) async {
    emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GameDetailsScreen()));
    try {
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
      final isSuccessful = await _hfflRepository.addJerseyNumbersToPlayers(
          gameId, homePlayers, awayPlayers);
      if (isSuccessful) {
        emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.success));
        //Navigator.of(context).pop();
        await fetchGameDetails(gameId, context, true);
      } else {
        emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
      }
    } on Exception {
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
    }
  }

  Future<void> addNewEvent(int gameId, EventDto eventDto) async {
    final isSuccessful = await _hfflRepository.addNewEvent(gameId, eventDto);
    if (isSuccessful) {
      justFetchGameDetails(gameId);
    }
  }

  Future<void> deleteEvent(int eventId, int gameId) async {
    navigatorKey.currentContext?.loaderOverlay.show();

    final isSuccessful = await _hfflRepository.deleteEvent(eventId);
    if (isSuccessful) {
      justFetchGameDetails(gameId);
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }
}
