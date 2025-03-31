import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tournament.g.dart';

@immutable
@JsonSerializable()
class Tournament {

  final int? id;
  final DateTime date;
  final String name;
  final String? season;
  final String? coverPhoto;
  final bool? isFinished;

  factory Tournament.fromJson(Map<String, dynamic> json) => _$TournamentFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentToJson(this);

//<editor-fold desc="Data Methods">
  const Tournament({
    this.id,
    required this.date,
    required this.name,
    this.season,
    this.coverPhoto,
    this.isFinished,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tournament &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          name == other.name &&
          season == other.season &&
          coverPhoto == other.coverPhoto &&
          isFinished == other.isFinished);

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      name.hashCode ^
      season.hashCode ^
      coverPhoto.hashCode ^
      isFinished.hashCode;

  @override
  String toString() {
    return 'Tournament{' +
        ' id: $id,' +
        ' date: $date,' +
        ' name: $name,' +
        ' season: $season,' +
        ' coverPhoto: $coverPhoto,' +
        ' isFinished: $isFinished,' +
        '}';
  }

  Tournament copyWith({
    int? id,
    DateTime? date,
    String? name,
    String? season,
    String? coverPhoto,
    bool? isFinished,
  }) {
    return Tournament(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      season: season ?? this.season,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'date': this.date,
      'name': this.name,
      'season': this.season,
      'coverPhoto': this.coverPhoto,
      'isFinished': this.isFinished,
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map) {
    return Tournament(
      id: map['id'] as int,
      date: map['date'] as DateTime,
      name: map['name'] as String,
      season: map['season'] as String,
      coverPhoto: map['coverPhoto'] as String,
      isFinished: map['isFinished'] as bool,
    );
  }

//</editor-fold>
}
