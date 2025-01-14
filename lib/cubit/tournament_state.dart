part of 'tournament_cubit.dart';


@JsonSerializable()
final class TournamentState extends Equatable {

  final Tournaments? tournaments;
  final LoadingStatus tournamentLoadingStatus;

  final LoadingStatus creatingTournament;
  final LoadingStatus deletingTournament;


  factory TournamentState.fromJson(Map<String, dynamic> json) => _$TournamentStateFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentStateToJson(this);

  @override
  List<Object?> get props => [tournaments, tournamentLoadingStatus];

//<editor-fold desc="Data Methods">
  const TournamentState({
    this.tournaments,
    required this.tournamentLoadingStatus,
    required this.creatingTournament,
    required this.deletingTournament,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is TournamentState &&
              runtimeType == other.runtimeType &&
              tournaments == other.tournaments &&
              tournamentLoadingStatus == other.tournamentLoadingStatus &&
              creatingTournament == other.creatingTournament &&
              deletingTournament == other.deletingTournament
          );


  @override
  int get hashCode =>
      tournaments.hashCode ^
      tournamentLoadingStatus.hashCode ^
      creatingTournament.hashCode ^
      deletingTournament.hashCode;


  @override
  String toString() {
    return 'TournamentState{' +
        ' tournaments: $tournaments,' +
        ' tournamentLoadingStatus: $tournamentLoadingStatus,' +
        ' creatingTournament: $creatingTournament,' +
        ' deletingTournament: $deletingTournament,' +
        '}';
  }


  TournamentState copyWith({
    Tournaments? tournaments,
    LoadingStatus? tournamentLoadingStatus,
    LoadingStatus? creatingTournament,
    LoadingStatus? deletingTournament,
  }) {
    return TournamentState(
      tournaments: tournaments ?? this.tournaments,
      tournamentLoadingStatus: tournamentLoadingStatus ??
          this.tournamentLoadingStatus,
      creatingTournament: creatingTournament ?? this.creatingTournament,
      deletingTournament: deletingTournament ?? this.deletingTournament,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'tournaments': this.tournaments,
      'tournamentLoadingStatus': this.tournamentLoadingStatus,
      'creatingTournament': this.creatingTournament,
      'deletingTournament': this.deletingTournament,
    };
  }

  factory TournamentState.fromMap(Map<String, dynamic> map) {
    return TournamentState(
      tournaments: map['tournaments'] as Tournaments,
      tournamentLoadingStatus: map['tournamentLoadingStatus'] as LoadingStatus,
      creatingTournament: map['creatingTournament'] as LoadingStatus,
      deletingTournament: map['deletingTournament'] as LoadingStatus,
    );
  }


//</editor-fold>
}

// final class TournamentInitial extends TournamentState {
//   @override
//   List<Object> get props => [];
// }
