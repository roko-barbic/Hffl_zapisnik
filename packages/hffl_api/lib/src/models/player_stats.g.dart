// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerStats _$PlayerStatsFromJson(Map<String, dynamic> json) => PlayerStats(
      FirstName: json['firstName'] as String,
      LastName: json['lastName'] as String,
      Id: (json['id'] as num?)?.toInt(),
      TDPass: (json['tdPass'] as num).toInt(),
      TDCatch: (json['tdCatch'] as num).toInt(),
      TDRun: (json['tdRun'] as num).toInt(),
      IntPass: (json['intPass'] as num).toInt(),
      IntCatch: (json['intCatch'] as num).toInt(),
      IntTD: (json['intTD'] as num).toInt(),
      XPPass: (json['xpPass'] as num).toInt(),
      XPCatch: (json['xpCatch'] as num).toInt(),
      XPRun: (json['xpRun'] as num).toInt(),
      Safety: (json['safety'] as num).toInt(),
    );

Map<String, dynamic> _$PlayerStatsToJson(PlayerStats instance) =>
    <String, dynamic>{
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'Id': instance.Id,
      'TDPass': instance.TDPass,
      'TDCatch': instance.TDCatch,
      'TDRun': instance.TDRun,
      'IntPass': instance.IntPass,
      'IntCatch': instance.IntCatch,
      'IntTD': instance.IntTD,
      'XPPass': instance.XPPass,
      'XPCatch': instance.XPCatch,
      'XPRun': instance.XPRun,
      'Safety': instance.Safety,
    };
