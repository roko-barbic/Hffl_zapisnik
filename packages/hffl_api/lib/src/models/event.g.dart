// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: (json['id'] as num).toInt(),
      playerOne: PlayerDto.fromJson(json['player_One'] as Map<String, dynamic>),
      playerTwo: PlayerDto.fromJson(json['player_Two'] as Map<String, dynamic>),
      type: (json['type'] as num).toInt(),
      teamGettingPoints: (json['teamGettingPoints'] as num).toInt(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'playerOne': instance.playerOne,
      'playerTwo': instance.playerTwo,
      'type': instance.type,
      'teamGettingPoints': instance.teamGettingPoints,
    };
