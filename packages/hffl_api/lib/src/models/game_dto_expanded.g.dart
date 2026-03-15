// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_dto_expanded.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDto _$GameDtoFromJson(Map<String, dynamic> json) => GameDto(
      id: (json['id'] as num).toInt(),
      clubHome: ClubDtoShort.fromJson(json['club_Home'] as Map<String, dynamic>),
      clubAway: ClubDtoShort.fromJson(json['club_Away'] as Map<String, dynamic>),
      clubHomeScore: (json['club_Home_Score'] as num).toInt(),
      clubAwayScore: (json['club_Away_Score'] as num).toInt(),
      events: (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      playerRegistration: json['playerRegistration'] as bool,
      referees: (json['referees'] as List<dynamic>?)
          ?.map((e) => PlayerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameDtoToJson(GameDto instance) => <String, dynamic>{
      'id': instance.id,
      'clubHome': instance.clubHome,
      'clubAway': instance.clubAway,
      'clubHomeScore': instance.clubHomeScore,
      'clubAwayScore': instance.clubAwayScore,
      'events': instance.events,
      'playerRegistration': instance.playerRegistration,
      'referees': instance.referees,
    };
