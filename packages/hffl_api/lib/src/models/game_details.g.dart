// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDetails _$GameDetailsFromJson(Map<String, dynamic> json) => GameDetails(
      homePlayersCombination: (json['homePlayersCombination'] as List<dynamic>)
          .map((e) => PlayerCombination.fromJson(e as Map<String, dynamic>))
          .toList(),
      awayPlayersCombination: (json['awayPlayersCombination'] as List<dynamic>)
          .map((e) => PlayerCombination.fromJson(e as Map<String, dynamic>))
          .toList(),
      homeClubId: (json['homeClubId'] as num).toInt(),
      awayClubId: (json['awayClubId'] as num).toInt(),
      gameId: (json['gameId'] as num).toInt(),
    );

Map<String, dynamic> _$GameDetailsToJson(GameDetails instance) =>
    <String, dynamic>{
      'homePlayersCombination': instance.homePlayersCombination,
      'awayPlayersCombination': instance.awayPlayersCombination,
      'homeClubId': instance.homeClubId,
      'awayClubId': instance.awayClubId,
      'gameId': instance.gameId,
    };
