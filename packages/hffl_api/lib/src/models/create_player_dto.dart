import 'package:json_annotation/json_annotation.dart';


part 'create_player_dto.g.dart';


@JsonSerializable()
class CreatePlayerDto {
  final int playerId;
  final int clubId;


  factory CreatePlayerDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePlayerDtoToJson(this);

//<editor-fold desc="Data Methods">
  const CreatePlayerDto({
    required this.playerId,
    required this.clubId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreatePlayerDto &&
          runtimeType == other.runtimeType &&
          playerId == other.playerId &&
          clubId == other.clubId);

  @override
  int get hashCode => playerId.hashCode ^ clubId.hashCode;

  @override
  String toString() {
    return 'CreatePlayerDto{' +
        ' playerId: $playerId,' +
        ' clubId: $clubId,' +
        '}';
  }

  CreatePlayerDto copyWith({
    int? playerId,
    int? clubId,
  }) {
    return CreatePlayerDto(
      playerId: playerId ?? this.playerId,
      clubId: clubId ?? this.clubId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerId': this.playerId,
      'clubId': this.clubId,
    };
  }

  factory CreatePlayerDto.fromMap(Map<String, dynamic> map) {
    return CreatePlayerDto(
      playerId: map['playerId'] as int,
      clubId: map['clubId'] as int,
    );
  }

//</editor-fold>
}