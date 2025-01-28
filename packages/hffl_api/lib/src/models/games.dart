import 'package:hffl_api/src/models/game.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'games.g.dart';

@immutable
@JsonSerializable()
class Games{

  final int id;
  final String name;
  final String date;
  final List<Game> games;

  factory Games.fromJson(Map<String, dynamic> json) =>
      _$GamesFromJson(json);

  Map<String, dynamic> toJson() => _$GamesToJson(this);

//<editor-fold desc="Data Methods">
  const Games({
    required this.id,
    required this.name,
    required this.date,
    required this.games,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Games &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          date == other.date &&
          games == other.games);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ date.hashCode ^ games.hashCode;

  @override
  String toString() {
    return 'Games{' +
        ' id: $id,' +
        ' name: $name,' +
        ' date: $date,' +
        ' games: $games,' +
        '}';
  }

  Games copyWith({
    int? id,
    String? name,
    String? date,
    List<Game>? games,
  }) {
    return Games(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      games: games ?? this.games,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'date': this.date,
      'games': this.games,
    };
  }

  factory Games.fromMap(Map<String, dynamic> map) {
    return Games(
      id: map['id'] as int,
      name: map['name'] as String,
      date: map['date'] as String,
      games: map['games'] as List<Game>,
    );
  }

//</editor-fold>
}