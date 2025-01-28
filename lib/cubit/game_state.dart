part of 'game_cubit.dart';


@JsonSerializable()
final class GameState extends Equatable {


  final Games? games;
  final LoadingStatus gamesLoadingStatus;

  final GameDto? selectedGame;
  final LoadingStatus selectedGameLoadingStatus;

  final LoadingStatus creatingGameStatus;

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
  Map<String, dynamic> toJson() => _$GameStateToJson(this);


  @override
  List<Object> get props => [];

//<editor-fold desc="Data Methods">
  const GameState({
    this.games,
    required this.gamesLoadingStatus,
    this.selectedGame,
    required this.selectedGameLoadingStatus,
    required this.creatingGameStatus,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameState &&
          runtimeType == other.runtimeType &&
          games == other.games &&
          gamesLoadingStatus == other.gamesLoadingStatus &&
          selectedGame == other.selectedGame &&
          selectedGameLoadingStatus == other.selectedGameLoadingStatus &&
          creatingGameStatus == other.creatingGameStatus);

  @override
  int get hashCode =>
      games.hashCode ^
      gamesLoadingStatus.hashCode ^
      selectedGame.hashCode ^
      selectedGameLoadingStatus.hashCode ^
      creatingGameStatus.hashCode;

  @override
  String toString() {
    return 'GameState{' +
        ' games: $games,' +
        ' gamesLoadingStatus: $gamesLoadingStatus,' +
        ' selectedGame: $selectedGame,' +
        ' selectedGameLoadingStatus: $selectedGameLoadingStatus,' +
        ' creatingGameStatus: $creatingGameStatus,' +
        '}';
  }

  GameState copyWith({
    Games? games,
    LoadingStatus? gamesLoadingStatus,
    GameDto? selectedGame,
    LoadingStatus? selectedGameLoadingStatus,
    LoadingStatus? creatingGameStatus,
  }) {
    return GameState(
      games: games ?? this.games,
      gamesLoadingStatus: gamesLoadingStatus ?? this.gamesLoadingStatus,
      selectedGame: selectedGame ?? this.selectedGame,
      selectedGameLoadingStatus:
          selectedGameLoadingStatus ?? this.selectedGameLoadingStatus,
      creatingGameStatus: creatingGameStatus ?? this.creatingGameStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'games': this.games,
      'gamesLoadingStatus': this.gamesLoadingStatus,
      'selectedGame': this.selectedGame,
      'selectedGameLoadingStatus': this.selectedGameLoadingStatus,
      'creatingGameStatus': this.creatingGameStatus,
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      games: map['games'] as Games,
      gamesLoadingStatus: map['gamesLoadingStatus'] as LoadingStatus,
      selectedGame: map['selectedGame'] as GameDto,
      selectedGameLoadingStatus:
          map['selectedGameLoadingStatus'] as LoadingStatus,
      creatingGameStatus: map['creatingGameStatus'] as LoadingStatus,
    );
  }

//</editor-fold>
}

// final class GameInitial extends GameState {
//   @override
//   List<Object> get props => [];
// }
