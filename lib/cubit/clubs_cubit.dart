import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clubs_cubit.g.dart';
part 'clubs_state.dart';


class ClubsCubit extends HydratedCubit<ClubsState> {
  ClubsCubit(this._hfflRepository) : super(ClubsState());

  final HfflRepository _hfflRepository;


  Future<void> fetchClubsInfo() async{
    try{
      if(state.clubsLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(clubsLoadingStatus: LoadingStatus.loading));
      }
      final clubs = await _hfflRepository.getClubs();
      emit(state.copyWith(clubs: clubs, clubsLoadingStatus: LoadingStatus.success));

    }on Exception{
      emit(state.copyWith(clubsLoadingStatus: LoadingStatus.failure));
    }
  }


  @override
  ClubsState fromJson(Map<String, dynamic> json) =>
      ClubsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ClubsState state) => state.toJson();
}
