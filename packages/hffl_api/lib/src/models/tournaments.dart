
import 'package:hffl_api/src/models/club.dart';
import 'package:hffl_api/src/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:uuid/uuid.dart';

part 'tournaments.g.dart';

@immutable
@JsonSerializable()
class Tournaments {
  final List<Tournament> tournaments;

  factory Tournaments.fromJson(List<dynamic> json) {
    return Tournaments(
      tournaments: json.map((e) => Tournament.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'tournaments': tournaments.map((tournament) => tournament.toJson())
            .toList(),
      };

//<editor-fold desc="Data Methods">

  const Tournaments({
    required this.tournaments,
  });

//<ed@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Tournaments &&
              runtimeType == other.runtimeType &&
              tournaments == other.tournaments
          );


  @override
  int get hashCode =>
      tournaments.hashCode;


  @override
  String toString() {
    return 'Tournaments{' +
        ' tournaments: $tournaments,' +
        '}';
  }


  Tournaments copyWith({
    List<Tournament>? tournaments,
  }) {
    return Tournaments(
      tournaments: tournaments ?? this.tournaments,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'tournaments': this.tournaments,
    };
  }

  factory Tournaments.fromMap(Map<String, dynamic> map) {
    return Tournaments(
      tournaments: map['tournaments'] as List<Tournament>,
    );
  }

}
