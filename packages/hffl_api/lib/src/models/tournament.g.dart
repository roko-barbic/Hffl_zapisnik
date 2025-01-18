// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      id: (json['id'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
      season: json['season'] as String?,
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'name': instance.name,
      'season': instance.season,
    };
