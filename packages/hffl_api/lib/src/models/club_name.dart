import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:uuid/uuid.dart';

part 'club_name.g.dart';

@immutable
@JsonSerializable()
class ClubName {

  final String name;

  factory ClubName.fromJson(Map<String, dynamic> json) => _$ClubNameFromJson(json);
  Map<String, dynamic> toJson() => _$ClubNameToJson(this);

//<editor-fold desc="Data Methods">
  const ClubName({
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClubName &&
          runtimeType == other.runtimeType &&
          name == other.name);

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'ClubName{' + ' name: $name,' + '}';
  }

  ClubName copyWith({
    String? name,
  }) {
    return ClubName(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
    };
  }

  factory ClubName.fromMap(Map<String, dynamic> map) {
    return ClubName(
      name: map['name'] as String,
    );
  }

//</editor-fold>
}