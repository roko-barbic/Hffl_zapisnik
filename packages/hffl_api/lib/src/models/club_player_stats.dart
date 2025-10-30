
import 'package:hffl_api/src/models/player_stats.dart';
import 'package:json_annotation/json_annotation.dart';

part 'club_player_stats.g.dart';

@JsonSerializable()
class ClubPlayersStats {
  final String name;
  final int? clubId;
  final List<PlayerStats> players;

  factory ClubPlayersStats.fromJson(Map<String, dynamic> json) => _$ClubPlayersStatsFromJson(json);
  Map<String, dynamic> toJson() => _$ClubPlayersStatsToJson(this);

//<editor-fold desc="Data Methods">
  const ClubPlayersStats({
    required this.name,
    this.clubId,
    required this.players,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClubPlayersStats &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          clubId == other.clubId &&
          players == other.players);

  @override
  int get hashCode => name.hashCode ^ clubId.hashCode ^ players.hashCode;

  @override
  String toString() {
    return 'ClubPlayersStats{' +
        ' name: $name,' +
        ' clubId: $clubId,' +
        ' players: $players,' +
        '}';
  }

  ClubPlayersStats copyWith({
    String? name,
    int? clubId,
    List<PlayerStats>? players,
  }) {
    return ClubPlayersStats(
      name: name ?? this.name,
      clubId: clubId ?? this.clubId,
      players: players ?? this.players,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'clubId': this.clubId,
      'players': this.players,
    };
  }

  factory ClubPlayersStats.fromMap(Map<String, dynamic> map) {
    return ClubPlayersStats(
      name: map['name'] as String,
      clubId: map['clubId'] as int,
      players: map['players'] as List<PlayerStats>,
    );
  }

//</editor-fold>
}
