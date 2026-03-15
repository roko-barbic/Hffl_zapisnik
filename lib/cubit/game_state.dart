part of 'game_cubit.dart';


@JsonSerializable()
final class GameState extends Equatable {


  final Games? games;
  final LoadingStatus gamesLoadingStatus;

  final GameDto? selectedGame;
  final LoadingStatus selectedGameLoadingStatus;
  final GameDetails? selectedGameAndPlayers;

  final LoadingStatus creatingGameStatus;
  final List<PlayerDto>? possibleReferees;

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
    this.selectedGameAndPlayers,
    required this.creatingGameStatus,
    this.possibleReferees,
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
          selectedGameAndPlayers == other.selectedGameAndPlayers &&
          creatingGameStatus == other.creatingGameStatus &&
          possibleReferees == other.possibleReferees);

  @override
  int get hashCode =>
      games.hashCode ^
      gamesLoadingStatus.hashCode ^
      selectedGame.hashCode ^
      selectedGameLoadingStatus.hashCode ^
      selectedGameAndPlayers.hashCode ^
      creatingGameStatus.hashCode ^
      possibleReferees.hashCode;

  @override
  String toString() {
    return 'GameState{' +
        ' games: $games,' +
        ' gamesLoadingStatus: $gamesLoadingStatus,' +
        ' selectedGame: $selectedGame,' +
        ' selectedGameLoadingStatus: $selectedGameLoadingStatus,' +
        ' selectedGameAndPlayers: $selectedGameAndPlayers,' +
        ' creatingGameStatus: $creatingGameStatus,' +
        ' possibleReferees: $possibleReferees,' +
        '}';
  }

  GameState copyWith({
    Games? games,
    LoadingStatus? gamesLoadingStatus,
    GameDto? selectedGame,
    LoadingStatus? selectedGameLoadingStatus,
    GameDetails? selectedGameAndPlayers,
    LoadingStatus? creatingGameStatus,
    List<PlayerDto>? possibleReferees,
  }) {
    return GameState(
      games: games ?? this.games,
      gamesLoadingStatus: gamesLoadingStatus ?? this.gamesLoadingStatus,
      selectedGame: selectedGame ?? this.selectedGame,
      selectedGameLoadingStatus:
          selectedGameLoadingStatus ?? this.selectedGameLoadingStatus,
      selectedGameAndPlayers:
          selectedGameAndPlayers ?? this.selectedGameAndPlayers,
      creatingGameStatus: creatingGameStatus ?? this.creatingGameStatus,
      possibleReferees: possibleReferees ?? this.possibleReferees,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'games': this.games,
      'gamesLoadingStatus': this.gamesLoadingStatus,
      'selectedGame': this.selectedGame,
      'selectedGameLoadingStatus': this.selectedGameLoadingStatus,
      'selectedGameAndPlayers': this.selectedGameAndPlayers,
      'creatingGameStatus': this.creatingGameStatus,
      'possibleReferees': this.possibleReferees,
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      games: map['games'] as Games,
      gamesLoadingStatus: map['gamesLoadingStatus'] as LoadingStatus,
      selectedGame: map['selectedGame'] as GameDto,
      selectedGameLoadingStatus:
          map['selectedGameLoadingStatus'] as LoadingStatus,
      selectedGameAndPlayers: map['selectedGameAndPlayers'] as GameDetails,
      creatingGameStatus: map['creatingGameStatus'] as LoadingStatus,
      possibleReferees: map['possibleReferees'] as List<PlayerDto>,
    );
  }

//</editor-fold>
}

// final class GameInitial extends GameState {
//   @override
//   List<Object> get props => [];
// }
