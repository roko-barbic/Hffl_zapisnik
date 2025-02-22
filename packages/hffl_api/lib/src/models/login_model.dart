
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class UserLoginRequestDto {
  final String email;
  final String password;

  factory UserLoginRequestDto.fromJson(Map<String, dynamic> json) => _$UserLoginRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginRequestDtoToJson(this);

//<editor-fold desc="Data Methods">
  const UserLoginRequestDto({
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLoginRequestDto &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password);

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'UserLoginRequestDto{' +
        ' email: $email,' +
        ' password: $password,' +
        '}';
  }

  UserLoginRequestDto copyWith({
    String? email,
    String? password,
  }) {
    return UserLoginRequestDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }

  factory UserLoginRequestDto.fromMap(Map<String, dynamic> map) {
    return UserLoginRequestDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}
