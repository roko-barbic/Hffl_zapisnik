// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubsState _$ClubsStateFromJson(Map<String, dynamic> json) => ClubsState(
      clubsLoadingStatus: $enumDecodeNullable(
              _$LoadingStatusEnumMap, json['clubsLoadingStatus']) ??
          LoadingStatus.initial,
      clubs: json['clubs'] == null
          ? null
          : Clubs.fromJson(json['clubs'] as List<dynamic>),
    );

Map<String, dynamic> _$ClubsStateToJson(ClubsState instance) =>
    <String, dynamic>{
      'clubsLoadingStatus':
          _$LoadingStatusEnumMap[instance.clubsLoadingStatus]!,
      'clubs': instance.clubs,
    };

const _$LoadingStatusEnumMap = {
  LoadingStatus.initial: 'initial',
  LoadingStatus.loading: 'loading',
  LoadingStatus.success: 'success',
  LoadingStatus.failure: 'failure',
};
