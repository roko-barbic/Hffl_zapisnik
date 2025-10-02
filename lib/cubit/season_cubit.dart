import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:meta/meta.dart';

part 'season_state.dart';

class SeasonCubit extends Cubit<SeasonState> {
  SeasonCubit(this._hfflRepository) : super(SeasonState(selectedSeason: DateTime.now().year));

  final HfflRepository _hfflRepository;

  Future<void> fetchAvailableSeasons() async {
    try {
      // if (state.tournamentLoadingStatus == LoadingStatus.initial) {
      //   emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.loading));
      // }
      Seasons? seasons = await _hfflRepository.getSeasons();
      if(seasons != null && seasons.seasons.isNotEmpty)
        emit(state.copyWith(
          availableSeasons: seasons,));
    } on Exception {
      //emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.failure));
    }
  }

  void setSelectedSeason(int selectedSeason){
    emit(state.copyWith(selectedSeason: selectedSeason));
  }
}
