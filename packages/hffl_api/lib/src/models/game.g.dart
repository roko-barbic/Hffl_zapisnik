// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      ///IMPORTANT DONT CHANGE
      id: (json['id'] as num?)?.toInt(),
      clubHome: ClubName.fromJson(json['club_Home'] as Map<String, dynamic>),
      clubAway: ClubName.fromJson(json['club_Away'] as Map<String, dynamic>),
      scoreHome: (json['club_Home_Score'] as num).toInt(),
      scoreAway: (json['club_Away_Score'] as num).toInt(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'club_Home': instance.clubHome,
      'club_Away': instance.clubAway,
      'club_Home_Score': instance.scoreHome,
      'club_Away_Score': instance.scoreAway,
    };
