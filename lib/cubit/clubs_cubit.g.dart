// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubsState _$ClubsStateFromJson(Map<String, dynamic> json) => ClubsState(
      clubsLoadingStatus:
          $enumDecode(_$LoadingStatusEnumMap, json['clubsLoadingStatus']),
      clubs: json['clubs'] == null
          ? null
          : Clubs.fromJson(json['clubs'] as List<dynamic>),
      clubPlayersStats: json['clubPlayersStats'] == null
          ? null
          : ClubPlayersStats.fromJson(
              json['clubPlayersStats'] as Map<String, dynamic>),
      statsLoadingStatus:
          $enumDecode(_$LoadingStatusEnumMap, json['statsLoadingStatus']),
    );

Map<String, dynamic> _$ClubsStateToJson(ClubsState instance) =>
    <String, dynamic>{
      'clubsLoadingStatus':
          _$LoadingStatusEnumMap[instance.clubsLoadingStatus]!,
      'clubs': instance.clubs,
      'clubPlayersStats': instance.clubPlayersStats,
      'statsLoadingStatus':
          _$LoadingStatusEnumMap[instance.statsLoadingStatus]!,
    };

const _$LoadingStatusEnumMap = {
  LoadingStatus.initial: 'initial',
  LoadingStatus.loading: 'loading',
  LoadingStatus.success: 'success',
  LoadingStatus.failure: 'failure',
};
