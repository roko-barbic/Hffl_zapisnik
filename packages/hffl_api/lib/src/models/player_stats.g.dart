// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerStats _$PlayerStatsFromJson(Map<String, dynamic> json) => PlayerStats(
      name: json['name'] as String,
      surname: json['surname'] as String,
      touchdownCatchCounter: (json['touchdownCatchCounter'] as num).toInt(),
      touchdownPassCounter: (json['touchdownPassCounter'] as num).toInt(),
      safteyCounter: (json['safteyCounter'] as num).toInt(),
      interceptionCounter: (json['interceptionCounter'] as num).toInt(),
      extraPointCatchCounter: (json['extraPointCatchCounter'] as num).toInt(),
      extreaPointPassCounter: (json['extreaPointPassCounter'] as num).toInt(),
    );

Map<String, dynamic> _$PlayerStatsToJson(PlayerStats instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'touchdownCatchCounter': instance.touchdownCatchCounter,
      'touchdownPassCounter': instance.touchdownPassCounter,
      'safteyCounter': instance.safteyCounter,
      'interceptionCounter': instance.interceptionCounter,
      'extraPointCatchCounter': instance.extraPointCatchCounter,
      'extreaPointPassCounter': instance.extreaPointPassCounter,
    };
