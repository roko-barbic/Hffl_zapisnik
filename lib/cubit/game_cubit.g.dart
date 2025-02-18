// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      games: json['games'] == null
          ? null
          : Games.fromJson(json['games'] as Map<String, dynamic>),
      gamesLoadingStatus:
          $enumDecode(_$LoadingStatusEnumMap, json['gamesLoadingStatus']),
      selectedGame: json['selectedGame'] == null
          ? null
          : GameDto.fromJson(json['selectedGame'] as Map<String, dynamic>),
      selectedGameLoadingStatus: $enumDecode(
          _$LoadingStatusEnumMap, json['selectedGameLoadingStatus']),
      selectedGameAndPlayers: json['selectedGameAndPlayers'] == null
          ? null
          : GameDetails.fromJson(
              json['selectedGameAndPlayers'] as Map<String, dynamic>),
      creatingGameStatus:
          $enumDecode(_$LoadingStatusEnumMap, json['creatingGameStatus']),
    );

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'games': instance.games,
      'gamesLoadingStatus':
          _$LoadingStatusEnumMap[instance.gamesLoadingStatus]!,
      'selectedGame': instance.selectedGame,
      'selectedGameLoadingStatus':
          _$LoadingStatusEnumMap[instance.selectedGameLoadingStatus]!,
      'selectedGameAndPlayers': instance.selectedGameAndPlayers,
      'creatingGameStatus':
          _$LoadingStatusEnumMap[instance.creatingGameStatus]!,
    };

const _$LoadingStatusEnumMap = {
  LoadingStatus.initial: 'initial',
  LoadingStatus.loading: 'loading',
  LoadingStatus.success: 'success',
  LoadingStatus.failure: 'failure',
};
