import 'package:hffl_api/src/models/event.dart';
import 'package:json_annotation/json_annotation.dart';
import 'club_dto_short.dart';

part 'game_dto_expanded.g.dart';

@JsonSerializable()
class GameDto {
  final int id;
  final ClubDtoShort clubHome;
  final ClubDtoShort clubAway;
  final int clubHomeScore;
  final int clubAwayScore;
  final List<Event> events;
  final bool playerRegistration;

  factory GameDto.fromJson(Map<String, dynamic> json) =>
      _$GameDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameDtoToJson(this);

//<editor-fold desc="Data Methods">
  const GameDto({
    required this.id,
    required this.clubHome,
    required this.clubAway,
    required this.clubHomeScore,
    required this.clubAwayScore,
    required this.events,
    required this.playerRegistration,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          clubHome == other.clubHome &&
          clubAway == other.clubAway &&
          clubHomeScore == other.clubHomeScore &&
          clubAwayScore == other.clubAwayScore &&
          events == other.events &&
          playerRegistration == other.playerRegistration);

  @override
  int get hashCode =>
      id.hashCode ^
      clubHome.hashCode ^
      clubAway.hashCode ^
      clubHomeScore.hashCode ^
      clubAwayScore.hashCode ^
      events.hashCode ^
      playerRegistration.hashCode;

  @override
  String toString() {
    return 'GameDto{' +
        ' id: $id,' +
        ' clubHome: $clubHome,' +
        ' clubAway: $clubAway,' +
        ' clubHomeScore: $clubHomeScore,' +
        ' clubAwayScore: $clubAwayScore,' +
        ' events: $events,' +
        ' playerRegistration: $playerRegistration,' +
        '}';
  }

  GameDto copyWith({
    int? id,
    ClubDtoShort? clubHome,
    ClubDtoShort? clubAway,
    int? clubHomeScore,
    int? clubAwayScore,
    List<Event>? events,
    bool? playerRegistration,
  }) {
    return GameDto(
      id: id ?? this.id,
      clubHome: clubHome ?? this.clubHome,
      clubAway: clubAway ?? this.clubAway,
      clubHomeScore: clubHomeScore ?? this.clubHomeScore,
      clubAwayScore: clubAwayScore ?? this.clubAwayScore,
      events: events ?? this.events,
      playerRegistration: playerRegistration ?? this.playerRegistration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'clubHome': this.clubHome,
      'clubAway': this.clubAway,
      'clubHomeScore': this.clubHomeScore,
      'clubAwayScore': this.clubAwayScore,
      'events': this.events,
      'playerRegistration': this.playerRegistration,
    };
  }

  factory GameDto.fromMap(Map<String, dynamic> map) {
    return GameDto(
      id: map['id'] as int,
      clubHome: map['clubHome'] as ClubDtoShort,
      clubAway: map['clubAway'] as ClubDtoShort,
      clubHomeScore: map['clubHomeScore'] as int,
      clubAwayScore: map['clubAwayScore'] as int,
      events: map['events'] as List<Event>,
      playerRegistration: map['playerRegistration'] as bool,
    );
  }

//</editor-fold>
}