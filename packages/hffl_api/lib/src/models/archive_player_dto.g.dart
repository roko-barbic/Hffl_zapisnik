// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArchivePlayerDto _$ArchivePlayerDtoFromJson(Map<String, dynamic> json) =>
    ArchivePlayerDto(
      playerId: (json['playerId'] as num).toInt(),
      clubId: (json['clubId'] as num).toInt(),
    );

Map<String, dynamic> _$ArchivePlayerDtoToJson(ArchivePlayerDto instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'clubId': instance.clubId,
    };
