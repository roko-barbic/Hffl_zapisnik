part of 'clubs_cubit.dart';

@JsonSerializable()
final class ClubsState extends Equatable {
  final LoadingStatus clubsLoadingStatus;
  final Clubs? clubs;
  final ClubPlayersStats? clubPlayersStats;
  final LoadingStatus statsLoadingStatus;
  //todo adde rest

  factory ClubsState.fromJson(Map<String, dynamic> json) => _$ClubsStateFromJson(json);
  Map<String, dynamic> toJson() => _$ClubsStateToJson(this);


  @override
  List<Object?> get props => [clubsLoadingStatus, clubs];

//<editor-fold desc="Data Methods">
  const ClubsState({
    required this.clubsLoadingStatus,
    this.clubs,
    this.clubPlayersStats,
    required this.statsLoadingStatus,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClubsState &&
          runtimeType == other.runtimeType &&
          clubsLoadingStatus == other.clubsLoadingStatus &&
          clubs == other.clubs &&
          clubPlayersStats == other.clubPlayersStats &&
          statsLoadingStatus == other.statsLoadingStatus);

  @override
  int get hashCode =>
      clubsLoadingStatus.hashCode ^
      clubs.hashCode ^
      clubPlayersStats.hashCode ^
      statsLoadingStatus.hashCode;

  @override
  String toString() {
    return 'ClubsState{' +
        ' clubsLoadingStatus: $clubsLoadingStatus,' +
        ' clubs: $clubs,' +
        ' clubPlayersStats: $clubPlayersStats,' +
        ' statsLoadingStatus: $statsLoadingStatus,' +
        '}';
  }

  ClubsState copyWith({
    LoadingStatus? clubsLoadingStatus,
    Clubs? clubs,
    ClubPlayersStats? clubPlayersStats,
    LoadingStatus? statsLoadingStatus,
  }) {
    return ClubsState(
      clubsLoadingStatus: clubsLoadingStatus ?? this.clubsLoadingStatus,
      clubs: clubs ?? this.clubs,
      clubPlayersStats: clubPlayersStats ?? this.clubPlayersStats,
      statsLoadingStatus: statsLoadingStatus ?? this.statsLoadingStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clubsLoadingStatus': this.clubsLoadingStatus,
      'clubs': this.clubs,
      'clubPlayersStats': this.clubPlayersStats,
      'statsLoadingStatus': this.statsLoadingStatus,
    };
  }

  factory ClubsState.fromMap(Map<String, dynamic> map) {
    return ClubsState(
      clubsLoadingStatus: map['clubsLoadingStatus'] as LoadingStatus,
      clubs: map['clubs'] as Clubs,
      clubPlayersStats: map['clubPlayersStats'] as ClubPlayersStats,
      statsLoadingStatus: map['statsLoadingStatus'] as LoadingStatus,
    );
  }

//</editor-fold>
}

//final class ClubsStateInitial extends ClubsState {}
