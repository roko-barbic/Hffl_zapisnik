// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePlayerDto _$CreatePlayerDtoFromJson(Map<String, dynamic> json) =>
    CreatePlayerDto(
      firstName: json['firstName'] as String,
      lastname: json['lastname'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      clubId: (json['clubId'] as num).toInt(),
    );

Map<String, dynamic> _$CreatePlayerDtoToJson(CreatePlayerDto instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastname': instance.lastname,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'clubId': instance.clubId,
    };
