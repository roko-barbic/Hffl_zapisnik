part of 'season_cubit.dart';

@immutable
final class SeasonState extends Equatable {
  final Seasons? availableSeasons;
  final int selectedSeason;

  @override
  List<Object?> get props => [availableSeasons, selectedSeason];

//<editor-fold desc="Data Methods">
  const SeasonState({
    this.availableSeasons,
    required this.selectedSeason,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeasonState &&
          runtimeType == other.runtimeType &&
          availableSeasons == other.availableSeasons &&
          selectedSeason == other.selectedSeason);

  @override
  int get hashCode => availableSeasons.hashCode ^ selectedSeason.hashCode;

  @override
  String toString() {
    return 'SeasonState{' +
        ' availableSeasons: $availableSeasons,' +
        ' selectedSeason: $selectedSeason,' +
        '}';
  }

  SeasonState copyWith({
    Seasons? availableSeasons,
    int? selectedSeason,
  }) {
    return SeasonState(
      availableSeasons: availableSeasons ?? this.availableSeasons,
      selectedSeason: selectedSeason ?? this.selectedSeason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'availableSeasons': this.availableSeasons,
      'selectedSeason': this.selectedSeason,
    };
  }

  factory SeasonState.fromMap(Map<String, dynamic> map) {
    return SeasonState(
      availableSeasons: map['availableSeasons'] as Seasons,
      selectedSeason: map['selectedSeason'] as int,
    );
  }

//</editor-fold>
}

//final class SeasonInitial extends SeasonState {}
