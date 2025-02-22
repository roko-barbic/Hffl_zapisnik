import 'package:json_annotation/json_annotation.dart';
part 'auth_result.g.dart';

@JsonSerializable()
class AuthResult {
  final String? token;
  final String? refreshToken;
  final bool result;
  final List<String>? errors;

  factory AuthResult.fromJson(Map<String, dynamic> json) => _$AuthResultFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResultToJson(this);

//<editor-fold desc="Data Methods">
  const AuthResult({
    this.token,
    this.refreshToken,
    required this.result,
    this.errors,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthResult &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          refreshToken == other.refreshToken &&
          result == other.result &&
          errors == other.errors);

  @override
  int get hashCode =>
      token.hashCode ^
      refreshToken.hashCode ^
      result.hashCode ^
      errors.hashCode;

  @override
  String toString() {
    return 'AuthResult{' +
        ' token: $token,' +
        ' refreshToken: $refreshToken,' +
        ' result: $result,' +
        ' errors: $errors,' +
        '}';
  }

  AuthResult copyWith({
    String? token,
    String? refreshToken,
    bool? result,
    List<String>? errors,
  }) {
    return AuthResult(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      result: result ?? this.result,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': this.token,
      'refreshToken': this.refreshToken,
      'result': this.result,
      'errors': this.errors,
    };
  }

  factory AuthResult.fromMap(Map<String, dynamic> map) {
    return AuthResult(
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
      result: map['result'] as bool,
      errors: map['errors'] as List<String>,
    );
  }

//</editor-fold>
}