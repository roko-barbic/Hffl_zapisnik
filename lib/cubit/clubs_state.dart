part of 'clubs_cubit.dart';

@JsonSerializable()
final class ClubsState extends Equatable {
  final LoadingStatus clubsLoadingStatus;
  final Clubs? clubs;
  //todo adde rest

  factory ClubsState.fromJson(Map<String, dynamic> json) => _$ClubsStateFromJson(json);
  Map<String, dynamic> toJson() => _$ClubsStateToJson(this);


  @override
  List<Object?> get props => [clubsLoadingStatus, clubs];


//<editor-fold desc="Data Methods">


  const ClubsState({
    this.clubsLoadingStatus = LoadingStatus.initial,
    this.clubs,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ClubsState &&
              runtimeType == other.runtimeType &&
              clubsLoadingStatus == other.clubsLoadingStatus &&
              clubs == other.clubs
          );


  @override
  int get hashCode =>
      clubsLoadingStatus.hashCode ^
      clubs.hashCode;


  @override
  String toString() {
    return 'ClubsState{' +
        ' clubsLoadingStatus: $clubsLoadingStatus,' +
        ' clubs: $clubs,' +
        '}';
  }


  ClubsState copyWith({
    LoadingStatus? clubsLoadingStatus,
    Clubs? clubs,
  }) {
    return ClubsState(
      clubsLoadingStatus: clubsLoadingStatus ?? this.clubsLoadingStatus,
      clubs: clubs ?? this.clubs,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'clubsLoadingStatus': this.clubsLoadingStatus,
      'clubs': this.clubs,
    };
  }

  factory ClubsState.fromMap(Map<String, dynamic> map) {
    return ClubsState(
      clubsLoadingStatus: map['clubsLoadingStatus'] as LoadingStatus,
      clubs: map['clubs'] as Clubs,
    );
  }


//</editor-fold>
}

//final class ClubsStateInitial extends ClubsState {}
