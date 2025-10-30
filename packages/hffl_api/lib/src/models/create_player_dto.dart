import 'package:json_annotation/json_annotation.dart';


part 'create_player_dto.g.dart';


@JsonSerializable()
class CreatePlayerDto {
  final String firstName;
  final String lastname;
  final DateTime dateOfBirth;
  final int clubId;


  factory CreatePlayerDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePlayerDtoToJson(this);

//<editor-fold desc="Data Methods">
  const CreatePlayerDto({
    required this.firstName,
    required this.lastname,
    required this.dateOfBirth,
    required this.clubId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreatePlayerDto &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastname == other.lastname &&
          dateOfBirth == other.dateOfBirth &&
          clubId == other.clubId);

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastname.hashCode ^
      dateOfBirth.hashCode ^
      clubId.hashCode;

  @override
  String toString() {
    return 'CreatePlayerDto{' +
        ' firstName: $firstName,' +
        ' lastname: $lastname,' +
        ' dateOfBirth: $dateOfBirth,' +
        ' clubId: $clubId,' +
        '}';
  }

  CreatePlayerDto copyWith({
    String? firstName,
    String? lastname,
    DateTime? dateOfBirth,
    int? clubId,
  }) {
    return CreatePlayerDto(
      firstName: firstName ?? this.firstName,
      lastname: lastname ?? this.lastname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      clubId: clubId ?? this.clubId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': this.firstName,
      'lastname': this.lastname,
      'dateOfBirth': this.dateOfBirth,
      'clubId': this.clubId,
    };
  }

  factory CreatePlayerDto.fromMap(Map<String, dynamic> map) {
    return CreatePlayerDto(
      firstName: map['firstName'] as String,
      lastname: map['lastname'] as String,
      dateOfBirth: map['dateOfBirth'] as DateTime,
      clubId: map['clubId'] as int,
    );
  }

//</editor-fold>
}