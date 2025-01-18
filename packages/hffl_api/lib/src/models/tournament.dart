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

  factory Tournament.fromJson(Map<String, dynamic> json) => _$TournamentFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentToJson(this);

//<editor-fold desc="Data Methods">
  const Tournament({
    this.id,
    required this.date,
    required this.name,
    this.season,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tournament &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          name == other.name &&
          season == other.season);

  @override
  int get hashCode =>
      id.hashCode ^ date.hashCode ^ name.hashCode ^ season.hashCode;

  @override
  String toString() {
    return 'Tournament{' +
        ' id: $id,' +
        ' date: $date,' +
        ' name: $name,' +
        ' season: $season,' +
        '}';
  }

  Tournament copyWith({
    int? id,
    DateTime? date,
    String? name,
    String? season,
  }) {
    return Tournament(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      season: season ?? this.season,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'date': this.date,
      'name': this.name,
      'season': this.season,
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map) {
    return Tournament(
      id: map['id'] as int,
      date: map['date'] as DateTime,
      name: map['name'] as String,
      season: map['season'] as String,
    );
  }

//</editor-fold>
}
