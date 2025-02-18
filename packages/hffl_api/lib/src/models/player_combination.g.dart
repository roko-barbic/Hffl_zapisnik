// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_combination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerCombination _$PlayerCombinationFromJson(Map<String, dynamic> json) =>
    PlayerCombination(
      name: json['name'] as String,
      surname: json['surname'] as String,
      jerseyNumber:  json['jerseyNumber'] != null ? (json['jerseyNumber'] as num).toInt() : null,
      playerId: (json['playerId'] as num).toInt(),
    );

Map<String, dynamic> _$PlayerCombinationToJson(PlayerCombination instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'jerseyNumber': instance.jerseyNumber,
      'playerId': instance.playerId,
    };
