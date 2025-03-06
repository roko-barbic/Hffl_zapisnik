// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_player_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubPlayersStats _$ClubPlayersStatsFromJson(Map<String, dynamic> json) =>
    ClubPlayersStats(
      name: json['name'] as String,
      players: (json['players'] as List<dynamic>)
          .map((e) => PlayerStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClubPlayersStatsToJson(ClubPlayersStats instance) =>
    <String, dynamic>{
      'name': instance.name,
      'players': instance.players,
    };
