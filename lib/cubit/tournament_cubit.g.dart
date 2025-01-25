// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentState _$TournamentStateFromJson(Map<String, dynamic> json) =>
    TournamentState(
      tournaments: json['tournaments'] == null
          ? null
          : Tournaments.fromJson(json['tournaments'] as List<dynamic>),
      tournamentLoadingStatus:
          $enumDecode(_$LoadingStatusEnumMap, json['tournamentLoadingStatus']),
      creatingTournament:
          $enumDecode(_$LoadingStatusEnumMap, json['creatingTournament']),
      deletingTournament:
          $enumDecode(_$LoadingStatusEnumMap, json['deletingTournament']),
      creatingNewTournament: json['creatingNewTournament'] == null
          ? null
          : Tournament.fromJson(
              json['creatingNewTournament'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TournamentStateToJson(TournamentState instance) =>
    <String, dynamic>{
      'tournaments': instance.tournaments,
      'tournamentLoadingStatus':
          _$LoadingStatusEnumMap[instance.tournamentLoadingStatus]!,
      'creatingTournament':
          _$LoadingStatusEnumMap[instance.creatingTournament]!,
      'deletingTournament':
          _$LoadingStatusEnumMap[instance.deletingTournament]!,
      'creatingNewTournament': instance.creatingNewTournament,
    };

const _$LoadingStatusEnumMap = {
  LoadingStatus.initial: 'initial',
  LoadingStatus.loading: 'loading',
  LoadingStatus.success: 'success',
  LoadingStatus.failure: 'failure',
};
