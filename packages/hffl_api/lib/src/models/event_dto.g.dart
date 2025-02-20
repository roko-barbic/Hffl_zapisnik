// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
      playerOneId: (json['playerOneId'] as num).toInt(),
      playetTwoId: (json['playetTwoId'] as num).toInt(),
      type: (json['type'] as num).toInt(),
    );

Map<String, dynamic> _$EventDtoToJson(EventDto instance) => <String, dynamic>{
  ///NE DIRAJ
      'player_OneId': instance.playerOneId,
      'player_TwoId': instance.playetTwoId,
      'type': instance.type,
    };
