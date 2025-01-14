import 'package:hffl_api/src/models/club.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:hffl_api/hffl_api.dart';

part 'clubs.g.dart';

@immutable
@JsonSerializable()
class Clubs {
  final List<Club> clubs;

  factory Clubs.fromJson(List<dynamic> json) {
    return Clubs(
      clubs: json.map((e) => Club.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'clubs': clubs.map((club) => club.toJson()).toList(),
  };

//<editor-fold desc="Data Methods">
  const Clubs({
    required this.clubs,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Clubs &&
          runtimeType == other.runtimeType &&
          clubs == other.clubs);

  @override
  int get hashCode => clubs.hashCode;

  @override
  String toString() {
    return 'Clubs{' + ' clubs: $clubs,' + '}';
  }

  Clubs copyWith({
    List<Club>? clubs,
  }) {
    return Clubs(
      clubs: clubs ?? this.clubs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clubs': this.clubs,
    };
  }

  factory Clubs.fromMap(Map<String, dynamic> map) {
    return Clubs(
      clubs: map['clubs'] as List<Club>,
    );
  }

//</editor-fold>
}