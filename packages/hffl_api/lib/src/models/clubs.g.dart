// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clubs _$ClubsFromJson(Map<String, dynamic> json) => Clubs(
      clubs: (json['clubs'] as List<dynamic>)
          .map((e) => Club.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClubsToJson(Clubs instance) => <String, dynamic>{
      'clubs': instance.clubs,
    };
