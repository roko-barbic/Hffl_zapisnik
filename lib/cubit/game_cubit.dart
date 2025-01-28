import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/views/game_details_screen.dart';
import 'package:json_annotation/json_annotation.dart';

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


  Future<void> fetchGames(int tournamentId) async{
    try {
      if (state.gamesLoadingStatus == LoadingStatus.initial) {
        emit(state.copyWith(gamesLoadingStatus: LoadingStatus.loading));
      }
      final games = await _hfflRepository.fetchGames(tournamentId); //ovo sam changeo
      if(games != null)
        emit(state.copyWith(
            games: games,
            gamesLoadingStatus: LoadingStatus.success));
    } on Exception {
      emit(state.copyWith(gamesLoadingStatus: LoadingStatus.failure));
    }
  }

  Future<void> resetCreatingGame() async{
    return emit(state.copyWith(creatingGameStatus: LoadingStatus.initial));
  }

  Future<void> createGame(int tournamentId, int homeClubId, int awayClubId) async{
    if(state.creatingGameStatus == LoadingStatus.initial){
      emit(state.copyWith(creatingGameStatus: LoadingStatus.loading));
    }
    final complete = await _hfflRepository.createGame(tournamentId, homeClubId, awayClubId);
    if(complete ?? false){
      fetchGames(tournamentId);
      emit(state.copyWith(creatingGameStatus: LoadingStatus.success));
    }
    else{
      emit(state.copyWith(creatingGameStatus: LoadingStatus.failure));
    }
  }

  Future<void> fetchGameDetails(int gameId, BuildContext context)async {
    emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GameDetailsScreen()));
    try{
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.loading));
      final gameDetails = await _hfflRepository.getGameDetails(gameId);
      if(gameDetails != null){
        emit(state.copyWith(selectedGame: gameDetails, selectedGameLoadingStatus: LoadingStatus.success));
      }
      else{
        emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
      }
    }on Exception{
      emit(state.copyWith(selectedGameLoadingStatus: LoadingStatus.failure));
    }

  }

}
