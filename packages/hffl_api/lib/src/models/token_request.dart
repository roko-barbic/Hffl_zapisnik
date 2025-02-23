import 'package:json_annotation/json_annotation.dart';
part 'token_request.g.dart';

@JsonSerializable()
class TokenRequest{
  final String token;
  final String refreshToken;

//<editor-fold desc="Data Methods">
  const TokenRequest({
    required this.token,
    required this.refreshToken,
  });

  factory TokenRequest.fromJson(Map<String, dynamic> json) => _$TokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TokenRequestToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TokenRequest &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          refreshToken == other.refreshToken);

  @override
  int get hashCode => token.hashCode ^ refreshToken.hashCode;

  @override
  String toString() {
    return 'TokenRequest{' +
        ' token: $token,' +
        ' refreshToken: $refreshToken,' +
        '}';
  }

  TokenRequest copyWith({
    String? token,
    String? refreshToken,
  }) {
    return TokenRequest(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': this.token,
      'refreshToken': this.refreshToken,
    };
  }

  factory TokenRequest.fromMap(Map<String, dynamic> map) {
    return TokenRequest(
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

//</editor-fold>
}