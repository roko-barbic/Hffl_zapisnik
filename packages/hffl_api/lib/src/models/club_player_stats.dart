
import 'package:hffl_api/src/models/player_stats.dart';
import 'package:json_annotation/json_annotation.dart';

part 'club_player_stats.g.dart';

@JsonSerializable()
class ClubPlayersStats {
  final String name;
  final List<PlayerStats> players;

  factory ClubPlayersStats.fromJson(Map<String, dynamic> json) => _$ClubPlayersStatsFromJson(json);
  Map<String, dynamic> toJson() => _$ClubPlayersStatsToJson(this);

//<editor-fold desc="Data Methods">
  const ClubPlayersStats({
    required this.name,
    required this.players,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClubPlayersStats &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          players == other.players);

  @override
  int get hashCode => name.hashCode ^ players.hashCode;

  @override
  String toString() {
    return 'ClubPlayersStats{' + ' name: $name,' + ' players: $players,' + '}';
  }

  ClubPlayersStats copyWith({
    String? name,
    List<PlayerStats>? players,
  }) {
    return ClubPlayersStats(
      name: name ?? this.name,
      players: players ?? this.players,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'players': this.players,
    };
  }

  factory ClubPlayersStats.fromMap(Map<String, dynamic> map) {
    return ClubPlayersStats(
      name: map['name'] as String,
      players: map['players'] as List<PlayerStats>,
    );
  }

//</editor-fold>
}
