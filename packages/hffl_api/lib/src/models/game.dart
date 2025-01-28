import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_api/src/models/club_name.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'game.g.dart';

@immutable
@JsonSerializable()
class Game{
  final int? id;
  final ClubName clubHome;
  final ClubName clubAway;
  final int scoreHome;
  final int scoreAway;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);

//<editor-fold desc="Data Methods">
  const Game({
    this.id,
    required this.clubHome,
    required this.clubAway,
    required this.scoreHome,
    required this.scoreAway,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Game &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          clubHome == other.clubHome &&
          clubAway == other.clubAway &&
          scoreHome == other.scoreHome &&
          scoreAway == other.scoreAway);

  @override
  int get hashCode =>
      id.hashCode ^
      clubHome.hashCode ^
      clubAway.hashCode ^
      scoreHome.hashCode ^
      scoreAway.hashCode;

  @override
  String toString() {
    return 'Game{' +
        ' id: $id,' +
        ' clubHome: $clubHome,' +
        ' clubAway: $clubAway,' +
        ' scoreHome: $scoreHome,' +
        ' scoreAway: $scoreAway,' +
        '}';
  }

  Game copyWith({
    int? id,
    ClubName? clubHome,
    ClubName? clubAway,
    int? scoreHome,
    int? scoreAway,
  }) {
    return Game(
      id: id ?? this.id,
      clubHome: clubHome ?? this.clubHome,
      clubAway: clubAway ?? this.clubAway,
      scoreHome: scoreHome ?? this.scoreHome,
      scoreAway: scoreAway ?? this.scoreAway,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'clubHome': this.clubHome,
      'clubAway': this.clubAway,
      'scoreHome': this.scoreHome,
      'scoreAway': this.scoreAway,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as int,
      clubHome: map['clubHome'] as ClubName,
      clubAway: map['clubAway'] as ClubName,
      scoreHome: map['scoreHome'] as int,
      scoreAway: map['scoreAway'] as int,
    );
  }

//</editor-fold>
}