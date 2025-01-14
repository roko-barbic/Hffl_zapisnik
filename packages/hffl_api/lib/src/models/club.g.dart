// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      win: (json['win'] as num).toInt(),
      draw: (json['draw'] as num).toInt(),
      loss: (json['loss'] as num).toInt(),
    );

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'win': instance.win,
      'draw': instance.draw,
      'loss': instance.loss,
    };
