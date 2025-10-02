import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/season_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/screens/clubs_players_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hffl_zapisnik/global_keys.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';
import 'package:flutter/material.dart';

part 'clubs_cubit.g.dart';
part 'clubs_state.dart';


class ClubsCubit extends HydratedCubit<ClubsState> {
  ClubsCubit(this._hfflRepository) : super(ClubsState(clubsLoadingStatus: LoadingStatus.initial, statsLoadingStatus: LoadingStatus.initial));

  final HfflRepository _hfflRepository;

  Future<void> fetchClubsInfo(int season) async{
    try{

      emit(state.copyWith(clubsLoadingStatus: LoadingStatus.loading));

      final clubs = await _hfflRepository.getClubs(season);
      emit(state.copyWith(clubs: clubs, clubsLoadingStatus: LoadingStatus.success));

    }on Exception{
      emit(state.copyWith(clubsLoadingStatus: LoadingStatus.failure));
    }
  }

  Future<ClubPlayersStats?> fetchClubPlayersStats(int clubId, BuildContext context) async{
    navigatorKey.currentContext?.loaderOverlay.show();
    emit(state.copyWith(clubPlayersStats: null));
    try{
      if(state.statsLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(statsLoadingStatus: LoadingStatus.loading));
      }
      final clubs = await _hfflRepository.fetchClubPlayersStats(clubId);
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.success, clubPlayersStats: clubs));

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClubsPlayersScreen(), //todo dodat screen za igrace
        ),
      );

    }on Exception{
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();

  }


  @override
  ClubsState fromJson(Map<String, dynamic> json) =>
      ClubsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ClubsState state) => state.toJson();
}
