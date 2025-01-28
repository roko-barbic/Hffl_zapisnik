import 'package:json_annotation/json_annotation.dart';

part 'club_dto_short.g.dart';

@JsonSerializable()
class ClubDtoShort {
  final String name;

  factory ClubDtoShort.fromJson(Map<String, dynamic> json) =>
      _$ClubDtoShortFromJson(json);

  Map<String, dynamic> toJson() => _$ClubDtoShortToJson(this);

//<editor-fold desc="Data Methods">
  const ClubDtoShort({
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClubDtoShort &&
          runtimeType == other.runtimeType &&
          name == other.name);

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'ClubDtoShort{' + ' name: $name,' + '}';
  }

  ClubDtoShort copyWith({
    String? name,
  }) {
    return ClubDtoShort(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
    };
  }

  factory ClubDtoShort.fromMap(Map<String, dynamic> map) {
    return ClubDtoShort(
      name: map['name'] as String,
    );
  }

//</editor-fold>
}