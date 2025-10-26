// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePlayerDto _$CreatePlayerDtoFromJson(Map<String, dynamic> json) =>
    CreatePlayerDto(
      playerId: (json['playerId'] as num).toInt(),
      clubId: (json['clubId'] as num).toInt(),
    );

Map<String, dynamic> _$CreatePlayerDtoToJson(CreatePlayerDto instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'clubId': instance.clubId,
    };
