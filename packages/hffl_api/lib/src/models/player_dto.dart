import 'package:json_annotation/json_annotation.dart';

part 'player_dto.g.dart';

@JsonSerializable()
class PlayerDto {
  final String LastName;
  final String firstName;
  final int? id;


  factory PlayerDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerDtoToJson(this);

//<editor-fold desc="Data Methods">
  const PlayerDto({
    required this.LastName,
    required this.firstName,
    this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerDto &&
          runtimeType == other.runtimeType &&
          LastName == other.LastName &&
          firstName == other.firstName &&
          id == other.id);

  @override
  int get hashCode => LastName.hashCode ^ firstName.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'PlayerDto{' +
        ' LastName: $LastName,' +
        ' firstName: $firstName,' +
        ' id: $id,' +
        '}';
  }

  PlayerDto copyWith({
    String? LastName,
    String? firstName,
    int? id,
  }) {
    return PlayerDto(
      LastName: LastName ?? this.LastName,
      firstName: firstName ?? this.firstName,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'LastName': this.LastName,
      'firstName': this.firstName,
      'id': this.id,
    };
  }

  factory PlayerDto.fromMap(Map<String, dynamic> map) {
    return PlayerDto(
      LastName: map['LastName'] as String,
      firstName: map['firstName'] as String,
      id: map['id'] as int,
    );
  }

//</editor-fold>
}