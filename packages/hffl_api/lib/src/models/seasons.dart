import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'seasons.g.dart';

@immutable
@JsonSerializable()
class Seasons {
  final List<String> seasons;

  factory Seasons.fromJson(List<dynamic> json) =>
      _$SeasonsFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonsToJson(this);

//<editor-fold desc="Data Methods">
  const Seasons({
    required this.seasons,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Seasons &&
          runtimeType == other.runtimeType &&
          seasons == other.seasons);

  @override
  int get hashCode => seasons.hashCode;

  @override
  String toString() {
    return 'Seasons{' + ' seasons: $seasons,' + '}';
  }

  Seasons copyWith({
    List<String>? seasons,
  }) {
    return Seasons(
      seasons: seasons ?? this.seasons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'seasons': this.seasons,
    };
  }

  factory Seasons.fromMap(Map<String, dynamic> map) {
    return Seasons(
      seasons: map['seasons'] as List<String>,
    );
  }

//</editor-fold>
}
