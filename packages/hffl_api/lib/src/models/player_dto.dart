import 'package:json_annotation/json_annotation.dart';

part 'player_dto.g.dart';

@JsonSerializable()
class PlayerDto {
  final String LastName;
  final String firstName;


  factory PlayerDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerDtoToJson(this);

//<editor-fold desc="Data Methods">
  const PlayerDto({
    required this.LastName,
    required this.firstName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerDto &&
          runtimeType == other.runtimeType &&
          LastName == other.LastName &&
          firstName == other.firstName);

  @override
  int get hashCode => LastName.hashCode ^ firstName.hashCode;

  @override
  String toString() {
    return 'PlayerDto{' +
        ' LastName: $LastName,' +
        ' firstName: $firstName,' +
        '}';
  }

  PlayerDto copyWith({
    String? LastName,
    String? firstName,
  }) {
    return PlayerDto(
      LastName: LastName ?? this.LastName,
      firstName: firstName ?? this.firstName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'LastName': this.LastName,
      'firstName': this.firstName,
    };
  }

  factory PlayerDto.fromMap(Map<String, dynamic> map) {
    return PlayerDto(
      LastName: map['LastName'] as String,
      firstName: map['firstName'] as String,
    );
  }

//</editor-fold>
}