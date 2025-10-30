// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerDto _$PlayerDtoFromJson(Map<String, dynamic> json) => PlayerDto(
      LastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerDtoToJson(PlayerDto instance) => <String, dynamic>{
      'LastName': instance.LastName,
      'firstName': instance.firstName,
      'id': instance.id,
    };
