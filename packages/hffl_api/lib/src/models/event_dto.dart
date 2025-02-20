import 'package:json_annotation/json_annotation.dart';


part 'event_dto.g.dart';

@JsonSerializable()
class EventDto{

  final int playerOneId;
  final int playetTwoId;
  final int type;

//<editor-fold desc="Data Methods">
  const EventDto({
    required this.playerOneId,
    required this.playetTwoId,
    required this.type,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventDto &&
          runtimeType == other.runtimeType &&
          playerOneId == other.playerOneId &&
          playetTwoId == other.playetTwoId &&
          type == other.type);

  @override
  int get hashCode =>
      playerOneId.hashCode ^ playetTwoId.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'EventDto{' +
        ' playerOneId: $playerOneId,' +
        ' playetTwoId: $playetTwoId,' +
        ' type: $type,' +
        '}';
  }

  EventDto copyWith({
    int? playerOneId,
    int? playetTwoId,
    int? type,
  }) {
    return EventDto(
      playerOneId: playerOneId ?? this.playerOneId,
      playetTwoId: playetTwoId ?? this.playetTwoId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerOneId': this.playerOneId,
      'playetTwoId': this.playetTwoId,
      'type': this.type,
    };
  }

  factory EventDto.fromMap(Map<String, dynamic> map) {
    return EventDto(
      playerOneId: map['playerOneId'] as int,
      playetTwoId: map['playetTwoId'] as int,
      type: map['type'] as int,
    );
  }

//</editor-fold>
}