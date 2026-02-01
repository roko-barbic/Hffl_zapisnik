import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/season_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/screens/add_new_player_container.dart';
import 'package:hffl_zapisnik/screens/clubs_players_container.dart';
import 'package:hffl_zapisnik/screens/clubs_players_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hffl_zapisnik/global_keys.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';
import 'package:hffl_zapisnik/widgets/add_new_player_screen.dart';
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

  void initClubsPlayersStats(int clubId, BuildContext context, int season) async{
    await fetchClubPlayersStats(clubId, season);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClubsPlayersContainer(),
      ),
    );
  }

  Future<ClubPlayersStats?> fetchClubPlayersStats(int clubId, int season) async{
    navigatorKey.currentContext?.loaderOverlay.show();
    //emit(state.copyWith(clubPlayersStats: null));//useless
    try{
      //if(state.statsLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(statsLoadingStatus: LoadingStatus.loading));
     // }
      final clubs = await _hfflRepository.fetchClubPlayersStats(clubId, season);
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.success, clubPlayersStats: clubs));
    }on Exception{
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }

  Future<void> initCreatNewPlayer(BuildContext context) async{
    navigatorKey.currentContext?.loaderOverlay.show();
    emit(state.copyWith(clubPlayersStats: null));
    try{
      if(state.statsLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(statsLoadingStatus: LoadingStatus.loading));
      }
      final archivedPlayers = await _hfflRepository.fetchArchivedPlayers();
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.success, archivedPlayer: archivedPlayers));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNewPlayerContainer(),
        ),
      );
    }catch(e){
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();

  }

  Future<void> creatNewPlayer(CreatePlayerDto createPlayerDto) async{
    navigatorKey.currentContext?.loaderOverlay.show();
    emit(state.copyWith(clubPlayersStats: null));
    try{
      if(state.statsLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(statsLoadingStatus: LoadingStatus.loading));
      }
      final createdSuccessfully  = await _hfflRepository.addNewPlayer(createPlayerDto);

      emit(state.copyWith(statsLoadingStatus: LoadingStatus.success));
      await fetchClubPlayersStats(createPlayerDto.clubId, DateTime.now().year);
      navigatorKey.currentState?.pop();
    }on Exception{
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();

  }

  Future<void> returnArchivedPlayer(ArchivePlayerDto archivePlayerDto) async{
    navigatorKey.currentContext?.loaderOverlay.show();
    emit(state.copyWith(clubPlayersStats: null));
    try{
      if(state.statsLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(statsLoadingStatus: LoadingStatus.loading));
      }
      await _hfflRepository.activateArchivedPlayer(archivePlayerDto);

      emit(state.copyWith(statsLoadingStatus: LoadingStatus.success));
      await fetchClubPlayersStats(archivePlayerDto.clubId, DateTime.now().year);
      navigatorKey.currentState?.pop();
    }on Exception{
      emit(state.copyWith(statsLoadingStatus: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }

  Future<void> archivePlayer(int playerId) async{
    navigatorKey.currentContext?.loaderOverlay.show();
    emit(state.copyWith(clubPlayersStats: null));
    try{
      if(state.statsLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(statsLoadingStatus: LoadingStatus.loading));
      }
      ArchivePlayerDto archivePlayerDto = ArchivePlayerDto(playerId: playerId, clubId: state.clubPlayersStats?.clubId ?? 0);
      await _hfflRepository.archivePlayer(archivePlayerDto);

      emit(state.copyWith(statsLoadingStatus: LoadingStatus.success));
      navigatorKey.currentState?.pop();
      await fetchClubPlayersStats(archivePlayerDto.clubId, DateTime.now().year);
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
