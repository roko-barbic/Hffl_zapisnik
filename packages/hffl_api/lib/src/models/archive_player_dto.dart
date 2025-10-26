
import 'package:json_annotation/json_annotation.dart';


part 'archive_player_dto.g.dart';


@JsonSerializable()
class ArchivePlayerDto {
  final int playerId;
  final int clubId;


  factory ArchivePlayerDto.fromJson(Map<String, dynamic> json) =>
      _$ArchivePlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArchivePlayerDtoToJson(this);

//<editor-fold desc="Data Methods">

  const ArchivePlayerDto({
    required this.playerId,
    required this.clubId,
  });

//<ed@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ArchivePlayerDto &&
              runtimeType == other.runtimeType &&
              playerId == other.playerId &&
              clubId == other.clubId
          );


  @override
  int get hashCode =>
      playerId.hashCode ^
      clubId.hashCode;


  @override
  String toString() {
    return 'ArchivePLayerDto{' +
        ' playerId: $playerId,' +
        ' clubId: $clubId,' +
        '}';
  }


  ArchivePlayerDto copyWith({
    int? playerId,
    int? clubId,
  }) {
    return ArchivePlayerDto(
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

  factory ArchivePlayerDto.fromMap(Map<String, dynamic> map) {
    return ArchivePlayerDto(
      playerId: map['playerId'] as int,
      clubId: map['clubId'] as int,
    );
  }

}