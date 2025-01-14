import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'tournament.g.dart';

@immutable
@JsonSerializable()
class Tournament {

  final int id;
  final DateTime date;
  final String name;

  factory Tournament.fromJson(Map<String, dynamic> json) => _$TorunamentFromJson(json);
  Map<String, dynamic> toJson() => _$TorunamentToJson(this);

//<editor-fold desc="Data Methods">
  const Tournament({
    required this.id,
    required this.date,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tournament &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Torunament{' +
        ' id: $id,' +
        ' date: $date,' +
        ' name: $name,' +
        '}';
  }

  Tournament copyWith({
    int? id,
    DateTime? date,
    String? name,
  }) {
    return Tournament(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'date': this.date,
      'name': this.name,
    };
  }

  factory Tournament.fromMap(Map<String, dynamic> map) {
    return Tournament(
      id: map['id'] as int,
      date: map['date'] as DateTime,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}
