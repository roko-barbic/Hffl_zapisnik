import 'package:hffl_api/src/models/player_combination.dart';
import 'package:json_annotation/json_annotation.dart';


part 'game_details.g.dart';

@JsonSerializable()
class GameDetails {
  final List<PlayerCombination> homePlayersCombination;
  final List<PlayerCombination> awayPlayersCombination;
  final int homeClubId;
  final int awayClubId;
  final int gameId;

  factory GameDetails.fromJson(Map<String, dynamic> json) =>
      _$GameDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$GameDetailsToJson(this);

//<editor-fold desc="Data Methods">
  const GameDetails({
    required this.homePlayersCombination,
    required this.awayPlayersCombination,
    required this.homeClubId,
    required this.awayClubId,
    required this.gameId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameDetails &&
          runtimeType == other.runtimeType &&
          homePlayersCombination == other.homePlayersCombination &&
          awayPlayersCombination == other.awayPlayersCombination &&
          homeClubId == other.homeClubId &&
          awayClubId == other.awayClubId &&
          gameId == other.gameId);

  @override
  int get hashCode =>
      homePlayersCombination.hashCode ^
      awayPlayersCombination.hashCode ^
      homeClubId.hashCode ^
      awayClubId.hashCode ^
      gameId.hashCode;

  @override
  String toString() {
    return 'GameDetails{' +
        ' homePlayersCombination: $homePlayersCombination,' +
        ' awayPlayersCombination: $awayPlayersCombination,' +
        ' homeClubId: $homeClubId,' +
        ' awayClubId: $awayClubId,' +
        ' gameId: $gameId,' +
        '}';
  }

  GameDetails copyWith({
    List<PlayerCombination>? homePlayersCombination,
    List<PlayerCombination>? awayPlayersCombination,
    int? homeClubId,
    int? awayClubId,
    int? gameId,
  }) {
    return GameDetails(
      homePlayersCombination:
          homePlayersCombination ?? this.homePlayersCombination,
      awayPlayersCombination:
          awayPlayersCombination ?? this.awayPlayersCombination,
      homeClubId: homeClubId ?? this.homeClubId,
      awayClubId: awayClubId ?? this.awayClubId,
      gameId: gameId ?? this.gameId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'homePlayersCombination': this.homePlayersCombination,
      'awayPlayersCombination': this.awayPlayersCombination,
      'homeClubId': this.homeClubId,
      'awayClubId': this.awayClubId,
      'gameId': this.gameId,
    };
  }

  factory GameDetails.fromMap(Map<String, dynamic> map) {
    return GameDetails(
      homePlayersCombination:
          map['homePlayersCombination'] as List<PlayerCombination>,
      awayPlayersCombination:
          map['awayPlayersCombination'] as List<PlayerCombination>,
      homeClubId: map['homeClubId'] as int,
      awayClubId: map['awayClubId'] as int,
      gameId: map['gameId'] as int,
    );
  }

//</editor-fold>
}