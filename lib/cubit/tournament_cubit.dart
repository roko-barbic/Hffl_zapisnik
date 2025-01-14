import 'package:equatable/equatable.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:json_annotation/json_annotation.dart';


part 'tournament_state.dart';
part 'tournament_cubit.g.dart';

class TournamentCubit extends Cubit<TournamentState> {
  TournamentCubit(this._hfflRepository) : super(const TournamentState(tournamentLoadingStatus: LoadingStatus.initial, creatingTournament: LoadingStatus.initial, deletingTournament: LoadingStatus.initial));

  final HfflRepository _hfflRepository;

  Future<void> fetchTournaments() async{
    try{
      if(state.tournamentLoadingStatus == LoadingStatus.initial){
        emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.loading));
      }
      final tournaments = await _hfflRepository.getTournaments();
      emit(state.copyWith(tournaments: tournaments, tournamentLoadingStatus: LoadingStatus.success));

    }on Exception{
      emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.failure));
    }
  }

  Future<void> createTournament(Tournament tournament) async{
    try{

      emit(state.copyWith(creatingTournament: LoadingStatus.loading));
      final creation = await _hfflRepository.createTournament(tournament);
      if(creation == true){
        emit(state.copyWith(creatingTournament: LoadingStatus.success));
      }
    }on Exception{
      emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.failure));
    }
  }

  Future<void> deleteTournament(int tournamentId) async{
    try{

      emit(state.copyWith(creatingTournament: LoadingStatus.loading));
      final deletion = await _hfflRepository.deleteTournament(tournamentId);
      if(deletion == true){
        emit(state.copyWith(creatingTournament: LoadingStatus.success));
        await fetchTournaments();
      }
    }on Exception{
      emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.failure));
    }
  }

  @override
  TournamentState fromJson(Map<String, dynamic> json) =>
      TournamentState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TournamentState state) => state.toJson();
}
